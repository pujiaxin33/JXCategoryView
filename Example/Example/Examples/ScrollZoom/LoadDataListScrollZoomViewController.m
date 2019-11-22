//
//  LoadDataListScrollZoomViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/24.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "LoadDataListScrollZoomViewController.h"


@interface LoadDataListScrollZoomViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, assign) CGFloat topContainerHeight;
@end

@implementation LoadDataListScrollZoomViewController

- (void)dealloc
{
    self.didScrollCallback = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.topContainerHeight = 150;
    [self.view addSubview:self.tableView];
    self.topView = [[UIView alloc] init];
    self.topView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topContainerHeight);
    self.topView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.topView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.contentInset = UIEdgeInsetsMake(self.topContainerHeight, 0, 0, 0);
        tableView.contentOffset = CGPointMake(0, -self.topContainerHeight);
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView = tableView;
        return tableView;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect topViewFrame = self.topView.frame;
    CGFloat targetY = -scrollView.contentOffset.y - self.topContainerHeight;
    topViewFrame.origin.y = MIN(0, targetY);
    self.topView.frame = topViewFrame;
    !self.didScrollCallback ?: self.didScrollCallback(scrollView);
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

@end
