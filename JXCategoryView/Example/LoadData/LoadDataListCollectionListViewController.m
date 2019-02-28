//
//  LoadDataListCollectionListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/2/26.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "LoadDataListCollectionListViewController.h"

@interface LoadDataListCollectionListViewController ()

@end

@implementation LoadDataListCollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //因为列表延迟加载了，所以在初始化的时候加载数据即可
    [self loadDataForFirst];
}

#pragma mark - JXCategoryListCollectionContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
