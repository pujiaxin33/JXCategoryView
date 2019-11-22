//
//  SortExampleViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/9.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "SortExampleViewController.h"
#import "JXCategoryTitleSortView.h"
#import "JXCategoryIndicatorAlignmentLineView.h"

@interface SortExampleViewController () <JXCategoryViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *statusString;
@end

@implementation SortExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.statusString = @"综合";
    self.titles = @[@"综合", @"销量", @"价格", @"口碑", @"筛选"].mutableCopy;

    self.categoryView = [[JXCategoryTitleSortView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.uiTypes = @{@(0) : @(JXCategoryTitleSortUIType_ArrowDown),
                                    @(1) : @(JXCategoryTitleSortUIType_ArrowNone),
                                    @(2) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(3) : @(JXCategoryTitleSortUIType_ArrowNone),
                                    @(4) : @(JXCategoryTitleSortUIType_SingleImage)}.mutableCopy;
    self.categoryView.arrowDirections = @{@(0) : @(JXCategoryTitleSortArrowDirection_Down),
                                            @(2) : @(JXCategoryTitleSortArrowDirection_Both)}.mutableCopy;
    self.categoryView.singleImages = @{@(4) : [UIImage imageNamed:@"filter"]}.mutableCopy;
    [self.view addSubview:self.categoryView];

    JXCategoryIndicatorAlignmentLineView *indicator = [[JXCategoryIndicatorAlignmentLineView alloc] init];
    indicator.indicatorWidth = 31;
    indicator.indicatorColor = [UIColor redColor];
    self.categoryView.indicators = @[indicator];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    self.tableView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50);
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    if (index == 0 && categoryView.selectedIndex == 0) {
        NSString *currentTitle = self.titles[0];
        NSString *tobeTitle = @"综合";
        if ([currentTitle isEqualToString:@"综合"]) {
            tobeTitle = @"评论";
        }
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确定切换到【%@】排序方式吗？", tobeTitle] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.titles[0] = tobeTitle;
            self.categoryView.titles = self.titles;
            [self.categoryView reloadCellAtIndex:0];
            self.statusString = tobeTitle;
            [self.tableView reloadData];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    JXCategoryTitleSortArrowDirection currentPriceDirection = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(2)].integerValue);
    if (index == 2) {
        NSString *trailString = @"";
        if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
            trailString = @"往上";
        }else if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Up) {
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Down);
            trailString = @"往下";
        }else {
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
            trailString = @"往上";
        }
        [self.categoryView reloadCellAtIndex:2];
        NSString *itemString = self.titles[index];
        self.statusString = [NSString stringWithFormat:@"%@%@", itemString, trailString];
        [self.tableView reloadData];
    }else if(index != 4) {
        if (currentPriceDirection != JXCategoryTitleSortArrowDirection_Both) {
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Both);
            [self.categoryView reloadCellAtIndex:2];
        }
        self.statusString = self.titles[index];
        [self.tableView reloadData];
    }
}

- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index {
    if (index == 4) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"你点击了筛选，根据你自己的业务打开筛选条件页面" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld:%@", indexPath.row, self.statusString];
    return cell;
}

@end
