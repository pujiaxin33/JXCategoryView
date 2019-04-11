//
//  LoadDataListCollectionViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/2/26.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "LoadDataListCollectionViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryListCollectionContainerView.h"
#import "LoadDataListCollectionListViewController.h"

@interface LoadDataListCollectionViewController () < JXCategoryListCollectionContainerViewDataSource>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListCollectionContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@end

@implementation LoadDataListCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.titles = [self getRandomTitles];
    self.categoryView = [[JXCategoryTitleView alloc] init];
    //因为JXCategoryListCollectionContainerView触发列表加载是在willDisplayCell代理方法里面。如果categoryView跨item点击（比如当前index=0，点击了index=10），并且过渡有动画就会依次触发中间cell的willDisplayCell方法，进而加载列表（即触发index:1~9的列表加载）。这显然违背懒加载，所以如果你选择使用JXCategoryListCollectionContainerView，那么最好就是将contentScrollViewClickTransitionAnimationEnabled设置为NO。
    self.categoryView.contentScrollViewClickTransitionAnimationEnabled = NO;
    self.categoryView.titles = self.titles;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];

    self.listContainerView = [[JXCategoryListCollectionContainerView alloc] init];
    self.listContainerView.dataSource = self;
    [self.view addSubview:self.listContainerView];

    self.categoryView.contentScrollView = self.listContainerView.collectionView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    self.listContainerView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50);
}

/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)reloadData {
    self.titles = [self getRandomTitles];

    //重载之后默认回到0，你也可以指定一个index
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titles = self.titles;
    [self.categoryView reloadData];

    self.listContainerView.defaultSelectedIndex = 0;
    [self.listContainerView reloadData];
}

#pragma mark - JXCategoryListCollectionContainerViewDataSource

- (id<JXCategoryListCollectionContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LoadDataListCollectionListViewController *listVC = [[LoadDataListCollectionListViewController alloc] init];
    listVC.naviController = self.navigationController;
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end
