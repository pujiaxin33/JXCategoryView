//
//  LoadDataListBaseViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "LoadDataListBaseViewController.h"
#import "DetailViewController.h"
#import "MJRefresh/MJRefresh.h"

@interface LoadDataListBaseViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isDataLoaded;
@end

@implementation LoadDataListBaseViewController

- (void)dealloc
{
    self.didScrollCallback = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = [NSMutableArray array];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
}

- (void)headerRefresh {
    [self.tableView.mj_header beginRefreshing];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.calendar = [NSCalendar currentCalendar];
    dateFormatter.dateFormat = @"HH:mm:ss";
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.dataSource removeAllObjects];
        for (int i = 0; i < 20; i++) {
            [self.dataSource addObject:[NSString stringWithFormat:@"%@测试数据:%d", dateString, i]];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)loadDataForFirst {
    //第一次才加载，后续触发的不处理
    if (!self.isDataLoaded) {
        [self headerRefresh];
        self.isDataLoaded = YES;
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.didScrollCallback ?: self.didScrollCallback(scrollView);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *vc = [[DetailViewController alloc] init];
    if (self.navigationController != nil) {
        [self.navigationController pushViewController:vc animated:true];
    } else {
        //仅仅是自定义列表容器示例才生效
        [self.naviController pushViewController:vc animated:true];
    }
}

@end
