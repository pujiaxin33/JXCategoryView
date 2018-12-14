//
//  LazyLoadViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/10.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "LazyLoadViewController.h"
#import "ListViewController.h"
#import "UIWindow+JXSafeArea.h"
#import "BaseViewController.h"
#import "JXCategoryTitleView.h"
#import "LoadDataListBaseViewController.h"

@interface LazyLoadViewController () <JXCategoryViewDelegate, UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableDictionary <NSNumber*, LoadDataListBaseViewController *>*listVCDict;
@end

@implementation LazyLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.listVCDict = [NSMutableDictionary dictionary];

    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    CGFloat naviHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];

    NSArray *titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    NSUInteger count = titles.count;
    CGFloat categoryViewHeight = 50;
    CGFloat width = WindowsSize.width;
    CGFloat height = WindowsSize.height - naviHeight - categoryViewHeight;

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, categoryViewHeight, width, height)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];

    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }


    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.titles = titles;
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.frame = CGRectMake(0, 0, WindowsSize.width, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.contentScrollView = self.scrollView;
    [self.view addSubview:self.categoryView];

    [self showVCWithIndex:0];   //defaultSelectedIndex是多少，就设置为多少
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)showVCWithIndex:(NSInteger)index {
    LoadDataListBaseViewController *vc = self.listVCDict[@(index)];
    if (vc == nil) {
        vc = [[LoadDataListBaseViewController alloc] init];
        vc.view.frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.scrollView addSubview:vc.view];
        self.listVCDict[@(index)] = vc;
        [vc loadDataForFirst];
    }
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    NSLog(@"%@", NSStringFromSelector(_cmd));

    [self showVCWithIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    if (ratio > 0.5) {
        //从rightIndex往leftIndex滚动
        [self showVCWithIndex:leftIndex];
    }else {
        //从leftIndex往rightIndex滚动
        [self showVCWithIndex:rightIndex];
    }
}

@end
