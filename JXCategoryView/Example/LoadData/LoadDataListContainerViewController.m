//
//  LoadDataListContainerViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "LoadDataListContainerViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "LoadDataListContainerListViewController.h"

@interface LoadDataListContainerViewController () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@end

@implementation LoadDataListContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.titles = [self getRandomTitles];
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.defaultSelectedIndex = 0;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];

    self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];

    self.categoryView.contentScrollView = self.listContainerView.scrollView;

    [self reloadData];
}

//如果你的子列表在整个页面消失的时候，做一些暂停操作。比如列表有视频正在播放，离开的时候要暂停，就必须要调用`[self.listContainerView currentListDidDisappear];`方法
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.listContainerView currentListDidDisappear];
}

//如果你的子列表在整个页面重新出现的时候，做一些恢复操作。比如继续播放之前的视频。就必须要调用`[self.listContainerView currentListDidAppear];`方法
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.listContainerView currentListDidAppear];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 50);
    self.listContainerView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height);
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

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LoadDataListContainerListViewController *listVC = [[LoadDataListContainerListViewController alloc] init];
    listVC.naviController = self.navigationController;
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end
