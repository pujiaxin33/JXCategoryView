//
//  LoadDataViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "LoadDataListCustomViewController.h"
#import "JXCategoryView.h"
#import "LoadDataListBaseViewController.h"
#import "UIWindow+JXSafeArea.h"

@interface LoadDataListCustomViewController () <JXCategoryViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray <LoadDataListBaseViewController *> *listVCArray;
@end

@implementation LoadDataListCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat naviHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];

    NSArray *titles = [self getRandomTitles];
    CGFloat categoryViewHeight = 50;
    CGFloat width = WindowsSize.width;
    CGFloat height = WindowsSize.height - naviHeight - categoryViewHeight;

    self.listVCArray = [NSMutableArray array];

    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.frame = CGRectMake(0, 0, WindowsSize.width, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.titles = titles;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, categoryViewHeight, width, height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    if ([UIView userInterfaceLayoutDirectionForSemanticContentAttribute:UIView.appearance.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft) {
        self.scrollView.transform = CGAffineTransformMakeScale(-1, 1);
    }
    [self.view addSubview:self.scrollView];

    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        if ([self.scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    //FIXME:如果和自定义UIScrollView联动，删除纯UIScrollView示例
    self.categoryView.contentScrollView = self.scrollView;

    [self reloadData];
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
        listVC.naviController = self.navigationController;
        listVC.view.frame = CGRectMake(i*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        //如果列表是UIViewController包裹的，需要添加addChildViewController代码，这样子在iPhoneX系列手机就不会有底部安全距离错误的问题！！！
        [self addChildViewController:listVC];
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
