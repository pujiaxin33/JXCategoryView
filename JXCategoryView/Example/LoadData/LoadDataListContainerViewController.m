//
//  LoadDataListContainerViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "LoadDataListContainerViewController.h"
#import "JXCategoryListContainerView.h"
#import "LoadDataListContainerListViewController.h"

@interface LoadDataListContainerViewController () <JXCategoryViewDelegate>

@end

@implementation LoadDataListContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
    [self.view addSubview:self.listContainerView];

    self.titles = [self getRandomTitles];
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.defaultSelectedIndex = 0;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
}

//!!!!!!!!!!!!!!!!!!!如果你的列表是UIViewController，且你的列表依赖ViewWillAppear等生命周期方法，请添加下面的方法。避免生命周期方法重复调用!!!!!!!!!!!!!!!!!!!!!!!!
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
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
    self.categoryView.defaultSelectedIndex = 1;
    self.categoryView.titles = self.titles;
    [self.categoryView reloadData];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LoadDataListContainerListViewController *listVC = [[LoadDataListContainerListViewController alloc] init];
    listVC.naviController = self.navigationController;
    //如果列表是UIViewController包裹的，需要添加addChildViewController代码，这样子在iPhoneX系列手机就不会有底部安全距离错误的问题！！！
    [self addChildViewController:listVC];
    listVC.title = self.titles[index];
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end
