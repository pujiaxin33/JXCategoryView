//
//  LoadDataListCollectionListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/2/26.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "LoadDataListCollectionListViewController.h"
#import "MJRefresh.h"

@implementation LoadDataListCollectionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //因为列表延迟加载了，所以在初始化的时候加载数据即可
    [self loadDataForFirst];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSLog(@"%@:%@", NSStringFromSelector(_cmd), self.title);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    NSLog(@"%@:%@", NSStringFromSelector(_cmd), self.title);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    NSLog(@"%@:%@", NSStringFromSelector(_cmd), self.title);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    NSLog(@"%@:%@", NSStringFromSelector(_cmd), self.title);
}

#pragma mark - JXCategoryListCollectionContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    //因为`JXCategoryListContainerView`内部通过`UICollectionView`的cell加载列表。当切换tab的时候，之前的列表所在的cell就被回收到缓存池，就会从视图层级树里面被剔除掉，即没有显示出来且不在视图层级里面。这个时候MJRefreshHeader所持有的UIActivityIndicatorView就会被设置hidden。所以需要在列表显示的时候，且isRefreshing==YES的时候，再让UIActivityIndicatorView重新开启动画。
    if (self.tableView.mj_header.isRefreshing) {
        UIActivityIndicatorView *activity = [self.tableView.mj_header valueForKey:@"loadingView"];
        [activity startAnimating];
    }
}

- (void)listDidDisappear {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
