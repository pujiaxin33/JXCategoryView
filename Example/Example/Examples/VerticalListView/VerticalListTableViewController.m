//
//  VerticalListTableViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/12.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "VerticalListTableViewController.h"
#import "JXCategoryView.h"
#import "VerticalTableSectionCategoryHeaderView.h"
#import "VerticalTableSectionHeaderView.h"
#import "VerticalListTableView.h"

static const CGFloat VerticalListCategoryViewHeight = 60;   //悬浮categoryView的高度
static const NSUInteger VerticalListPinSectionIndex = 1;    //悬浮固定section的index

@interface VerticalListTableViewController () <UITableViewDataSource, UITableViewDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) VerticalListTableView *tableView;
@property (nonatomic, strong) NSArray <NSArray <NSString *>*> *dataSource;
@property (nonatomic, strong) NSArray <NSString *> *headerTitles;
@property (nonatomic, strong) JXCategoryTitleView *pinCategoryView;
@property (nonatomic, strong) UIView *sectionCategoryHeaderView;
@property (nonatomic, strong) NSArray <NSValue *> *sectionHeaderRectArray;

@end

@implementation VerticalListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    //仅支持UITableViewStyleGrouped
    self.tableView = [[VerticalListTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[VerticalTableSectionCategoryHeaderView class] forHeaderFooterViewReuseIdentifier:@"pinHeader"];
    [self.tableView registerClass:[VerticalTableSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    __weak typeof(self)weakSelf = self;
    self.tableView.layoutSubviewsCallback = ^{
        [weakSelf updateSectionHeaderAttributes];
    };
    if (@available(iOS 11.0, *)) {
        if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    [self.view addSubview:self.tableView];

    //创建pinCategoryView，但是不要被addSubview
    _pinCategoryView = [[JXCategoryTitleView alloc] init];
    self.pinCategoryView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    self.pinCategoryView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, VerticalListCategoryViewHeight);
    self.pinCategoryView.titles = @[@"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事"];
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.verticalMargin = 15;
    self.pinCategoryView.indicators = @[lineView];
    self.pinCategoryView.delegate = self;

    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loading.bounds = CGRectMake(0, 0, 100, 100);
    loading.transform = CGAffineTransformMakeScale(3, 3);
    loading.center = self.view.center;
    [loading startAnimating];
    [self.view addSubview:loading];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //模拟数据加载
        [loading stopAnimating];
        [loading removeFromSuperview];

        self.headerTitles = @[@"我的频道", @"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事"];
        NSMutableArray *tempDataSource = [NSMutableArray array];
        for (NSString *headerTitle in self.headerTitles) {
            NSMutableArray *tempSectionTitles = [NSMutableArray array];
            for (NSInteger index = 0; index <= 10; index ++) {
                [tempSectionTitles addObject:[NSString stringWithFormat:@"%@:%ld", headerTitle, index]];
            }
            [tempDataSource addObject:tempSectionTitles];
        }
        self.dataSource = tempDataSource;
        [self.tableView reloadData];
    });
}

- (void)updateSectionHeaderAttributes {
    //获取到所有的sectionHeaderRect，用于后续的点击，滚动到指定contentOffset.y使用
    NSMutableArray *rects = [NSMutableArray array];
    CGRect lastHeaderRect = CGRectZero;
    for (int i = 0; i < self.headerTitles.count; i++) {
        CGRect rect = [self.tableView rectForHeaderInSection:i];
        [rects addObject:[NSValue valueWithCGRect:rect]];
        if (i == self.headerTitles.count - 1) {
            lastHeaderRect = rect;
        }
    }
    if (rects.count == 0) {
        return;
    }
    self.sectionHeaderRectArray = rects;

    //如果最后一个section条目太少了，会导致滚动最底部，但是却不能触发categoryView选中最后一个item。而且点击最后一个滚动的contentOffset.y也不好弄。所以添加contentInset，让最后一个section滚到最下面能显示完整个屏幕。
    CGRect lastCellRect = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource[self.headerTitles.count - 1].count - 1 inSection:self.headerTitles.count - 1]];
    CGFloat lastSectionHeight = CGRectGetMaxY(lastCellRect) - CGRectGetMinY(lastHeaderRect);
    CGFloat value = (self.view.bounds.size.height - VerticalListCategoryViewHeight) - lastSectionHeight;
    if (value > 0) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, value, 0);
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == VerticalListPinSectionIndex) {
        return VerticalListCategoryViewHeight;
    }
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == VerticalListPinSectionIndex) {
        VerticalTableSectionCategoryHeaderView *headerView = (VerticalTableSectionCategoryHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"pinHeader"];
        self.sectionCategoryHeaderView = headerView;
        if (self.pinCategoryView.superview == nil) {
            //首次使用VerticalSectionCategoryHeaderView的时候，把pinCategoryView添加到它上面。
            [headerView addSubview:self.pinCategoryView];
        }
        return headerView;
    }else {
        VerticalTableSectionHeaderView *headerView = (VerticalTableSectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        headerView.textLabel.text = self.headerTitles[section];
        return headerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect sectionHeaderRect = self.sectionHeaderRectArray[VerticalListPinSectionIndex].CGRectValue;
    if (scrollView.contentOffset.y >= sectionHeaderRect.origin.y) {
        //当滚动的contentOffset.y大于了指定sectionHeader的y值，且还没有被添加到self.view上的时候，就需要切换superView
        if (self.pinCategoryView.superview != self.view) {
            [self.view addSubview:self.pinCategoryView];
        }
    }else if (self.pinCategoryView.superview != self.sectionCategoryHeaderView) {
        //当滚动的contentOffset.y小于了指定sectionHeader的y值，且还没有被添加到sectionCategoryHeaderView上的时候，就需要切换superView
        [self.sectionCategoryHeaderView addSubview:self.pinCategoryView];
    }
    if (self.pinCategoryView.selectedIndex != 0 && scrollView.contentOffset.y == 0) {
        //点击了状态栏滚动到顶部时的处理
        [self.pinCategoryView selectItemAtIndex:0];
    }
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
    //用户滚动的才处理
    //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
    NSArray <NSIndexPath *>*topIndexPaths = [self.tableView indexPathsForRowsInRect:CGRectMake(0, scrollView.contentOffset.y + VerticalListCategoryViewHeight + 1, self.tableView.bounds.size.width, 200)];
    NSIndexPath *topIndexPath = topIndexPaths.firstObject;
    NSUInteger topSection = topIndexPath.section;
    if (topIndexPath != nil && topSection >= VerticalListPinSectionIndex) {
        if (self.pinCategoryView.selectedIndex != topSection - VerticalListPinSectionIndex) {
            //不相同才切换
            [self.pinCategoryView selectItemAtIndex:topSection - VerticalListPinSectionIndex];
        }
    }
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    //这里关心点击选中的回调！！！
    CGRect targetHeaderRect = self.sectionHeaderRectArray[index + VerticalListPinSectionIndex].CGRectValue;
    if (index == 0) {
        //选中了第一个，特殊处理一下，滚动到sectionHeaer的最上面
        [self.tableView setContentOffset:CGPointMake(0, targetHeaderRect.origin.y) animated:YES];
    }else {
        //不是第一个，需要滚动到categoryView下面
        [self.tableView setContentOffset:CGPointMake(0, targetHeaderRect.origin.y - VerticalListCategoryViewHeight) animated:YES];
    }
}

@end
