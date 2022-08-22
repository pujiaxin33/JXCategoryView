//
//  ScrollSmallViewController.m
//  Example
//
//  Created by tony on 2021/10/22.
//  Copyright © 2021 jiaxin. All rights reserved.
//

#import "ScrollSmallViewController.h"
#import <JXPagingView/JXPagerView.h>
#import "PagingViewTableHeaderView.h"
#import "TestListBaseView.h"
#import "JXCategoryScrollSmallView.h"

static const CGFloat JXTableHeaderViewHeight = 200;
static const CGFloat BigHeightForHeaderInSection = 50;
static const CGFloat SmallHeightForHeaderInSection = 30;

@interface ScrollSmallViewController () <JXPagerViewDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) PagingViewTableHeaderView *userHeaderView;
@property (nonatomic, strong) JXCategoryScrollSmallView *categoryView;
@property (nonatomic, strong) UIView *categoryContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSMutableArray <TestListBaseView *> *allLists;
@property (nonatomic, assign) CGFloat currentOffsetY;

@end

@implementation ScrollSmallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titles = @[@"10:00", @"11:00", @"12:00", @"13:00", @"14:00", @"15:00", @"16:00", @"17:00", ];
    NSArray <NSString *> *bottomTitles = @[@"已开抢", @"已开抢", @"已开抢", @"抢购中", @"即将开抢", @"即将开抢", @"即将开抢", @"即将开抢"];

    _allLists = [NSMutableArray array];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat diffHeight = BigHeightForHeaderInSection - SmallHeightForHeaderInSection;
    self.currentOffsetY = -diffHeight;
    
    _userHeaderView = [[PagingViewTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXTableHeaderViewHeight)];

    self.categoryContainerView = [[UIView alloc] init];
    self.categoryContainerView.backgroundColor = [UIColor clearColor];
    
    _categoryView = [[JXCategoryScrollSmallView alloc] init];
    self.categoryView.backgroundColor = [UIColor clearColor];
    self.categoryView.titles = self.titles;
    self.categoryView.bottomTitles = bottomTitles;
    self.categoryView.titleLabelVerticalOffset = -13;
    self.categoryView.titleColorGradientEnabled = YES;
    //设置底部状态
    self.categoryView.titleColor = [UIColor lightGrayColor];
    self.categoryView.titleSelectedColor = [UIColor blackColor];
    self.categoryView.titleFont = [UIFont boldSystemFontOfSize:13];
    self.categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:15];
    //设置顶部时间
    self.categoryView.bottomTitleFont = [UIFont systemFontOfSize:10];
    self.categoryView.bottomTitleSelectedFont = [UIFont systemFontOfSize:10];
    self.categoryView.bottomTitleNormalColor = [UIColor lightGrayColor];
    self.categoryView.bottomTitleSelectedColor = [UIColor whiteColor];
    self.categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, BigHeightForHeaderInSection);
    [self.categoryContainerView addSubview:self.categoryView];

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 16;
    backgroundView.indicatorCornerRadius = 8;
    backgroundView.verticalMargin = 13;
    backgroundView.indicatorColor = [UIColor whiteColor];
    self.categoryView.indicators = @[backgroundView];

    _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    self.pagingView.mainTableView.backgroundColor = [UIColor blackColor];
    if (@available(iOS 15.0, *)) {
        //最新版本的pagingView不需要添加该语句
        self.pagingView.mainTableView.sectionHeaderTopPadding = 0;
    }
    [self.view addSubview:self.pagingView];

    self.categoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagingView.listContainerView;

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagingView.frame = self.view.bounds;
}

- (void)listDidScrolling:(UIScrollView *)scrollView {
    //因为列表contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    CGFloat diffHeight = BigHeightForHeaderInSection - SmallHeightForHeaderInSection;
    CGFloat offsetY = scrollView.contentOffset.y + diffHeight;
    CGFloat alpha = 1 - MIN(1, offsetY/diffHeight);
    [self.categoryView refreshBottomAlpha:alpha];
    if (offsetY <= diffHeight) {
        for (TestListBaseView *list in _allLists) {
            if (list.tableView != scrollView) {
                list.tableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
            }
        }
        self.currentOffsetY = scrollView.contentOffset.y;
    }else {
        self.currentOffsetY = 0;
    }
}

#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return SmallHeightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryContainerView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    TestListBaseView *list = [[TestListBaseView alloc] initWithOffsetY:self.currentOffsetY];
    list.tableView.backgroundColor = [UIColor blackColor];
    CGFloat diffHeight = BigHeightForHeaderInSection - SmallHeightForHeaderInSection;
    list.tableView.contentInset = UIEdgeInsetsMake(diffHeight, 0, 0, 0);
    __weak ScrollSmallViewController *weakSelf = self;
    list.listScrollCallback = ^(UIScrollView *scrollView) {
        [weakSelf listDidScrolling:scrollView];
    };
    if (index == 0) {
        list.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮", @"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪", @"橡胶犀·榴弹炮", @"橡胶大蛇炮"].mutableCopy;
    }else if (index == 1) {
        list.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉", @"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉", @"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉", @"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉", @"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;
    }else {
        list.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾", @"【船匠】 弗兰奇", @"【音乐家】布鲁克", @"【考古学家】妮可·罗宾"].mutableCopy;
    }
    [self.allLists addObject:list];
    return list;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

@end
