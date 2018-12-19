//
//  LoadDataViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "LoadDataNormalViewController.h"
#import "JXCategoryView.h"
#import "LoadDataListBaseViewController.h"
#import "UIWindow+JXSafeArea.h"

@interface LoadDataNormalViewController () <JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray <LoadDataListBaseViewController *> *listVCArray;
@property (nonatomic, strong) JXCategoryListVCContainerView *listVCContainerView;
@end

@implementation LoadDataNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat naviHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];

    NSArray *titles = [self getRandomTitles];
    NSUInteger count = titles.count;
    CGFloat categoryViewHeight = 50;
    CGFloat width = WindowsSize.width;
    CGFloat height = WindowsSize.height - naviHeight - categoryViewHeight;

    self.listVCArray = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        LoadDataListBaseViewController *listVC = [[LoadDataListBaseViewController alloc] initWithStyle:UITableViewStylePlain];
        listVC.view.frame = CGRectMake(i*width, 0, width, height);
        [self.listVCArray addObject:listVC];
    }

    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.frame = CGRectMake(0, 0, WindowsSize.width, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.titles = titles;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, categoryViewHeight, width, height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    [self.view addSubview:self.scrollView];

    for (int i = 0; i < count; i ++) {
        LoadDataListBaseViewController *listVC = self.listVCArray[i];
        [self.scrollView addSubview:listVC.view];
    }

    self.categoryView.contentScrollView = self.scrollView;
    [self.listVCArray.firstObject loadDataForFirst];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

/**
 重载数据源：比如从服务器获取新的数据、否则用户对分类进行了排序等
 */
- (void)reloadData {
    NSArray *titles = [self getRandomTitles];
    //先把之前的listView移除掉
    for (UIViewController *vc in self.listVCArray) {
        [vc.view removeFromSuperview];
    }
    [self.listVCArray removeAllObjects];

    for (int i = 0; i < titles.count; i ++) {
        LoadDataListBaseViewController *listVC = [[LoadDataListBaseViewController alloc] initWithStyle:UITableViewStylePlain];
        listVC.view.frame = CGRectMake(i*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.listVCArray addObject:listVC];
    }

    //根据新的数据源重新添加listView
    for (int i = 0; i < titles.count; i ++) {
        LoadDataListBaseViewController *listVC = self.listVCArray[i];
        [self.scrollView addSubview:listVC.view];
    }
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*titles.count, self.scrollView.bounds.size.height);

    //触发首次加载
    [self.listVCArray.firstObject loadDataForFirst];

    //重载之后默认回到0，你也可以指定一个index
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.titles = titles;
    [self.categoryView reloadData];
}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    [self.listVCArray[index] loadDataForFirst];
}

@end
