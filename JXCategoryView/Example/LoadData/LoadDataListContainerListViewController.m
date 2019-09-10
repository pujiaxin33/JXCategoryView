//
//  LoadDataListContainerListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "LoadDataListContainerListViewController.h"

@interface LoadDataListContainerListViewController ()

@end

@implementation LoadDataListContainerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //因为列表延迟加载了，所以在初始化的时候加载数据即可
    [self loadDataForFirst];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

//- (void)listWillAppear {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)listDidAppear {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)listWillDisappear {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//
//- (void)listDidDisappear {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

@end
