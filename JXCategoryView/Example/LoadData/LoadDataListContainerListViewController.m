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
