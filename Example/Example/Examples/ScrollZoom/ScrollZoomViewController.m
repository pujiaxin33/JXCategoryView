//
//  ScrollZoomViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/2/14.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "ScrollZoomViewController.h"
#import "JXCategoryView.h"
#import "LoadDataListContainerListViewController.h"
#import "JXCategoryTitleVerticalZoomView.h"
#import "JXCategoryFactory.h"
#import "LoadDataListScrollZoomViewController.h"
#import "JXCategoryIndicatorScrollZoomLineView.h"

@interface ScrollZoomViewController () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, strong) JXCategoryTitleVerticalZoomView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, assign) CGFloat minCategoryViewHeight;
@property (nonatomic, assign) CGFloat maxCategoryViewHeight;
@property (nonatomic, strong) id interactivePopGestureRecognizerDelegate;
@end

@implementation ScrollZoomViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    CGFloat topStatusBarHeight = 20;
    self.minCategoryViewHeight = 50;
    self.maxCategoryViewHeight = 80;

    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, topStatusBarHeight + self.maxCategoryViewHeight, self.view.bounds.size.width, self.view.bounds.size.height - topStatusBarHeight - self.maxCategoryViewHeight);
    [self.view addSubview:self.listContainerView];

    self.categoryView = [[JXCategoryTitleVerticalZoomView alloc] init];
    self.categoryView.listContainer = self.listContainerView;
    self.categoryView.frame = CGRectMake(0, topStatusBarHeight, self.view.bounds.size.width, self.maxCategoryViewHeight);
    self.categoryView.averageCellSpacingEnabled = NO;
    self.categoryView.titles = @[@"推荐", @"关注"];
    self.categoryView.delegate = self;
    self.categoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    self.categoryView.titleLabelVerticalOffset = -5;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.contentEdgeInsetLeft = 15;    //设置内容左边距
    //推荐配置方案
    self.categoryView.maxVerticalCellSpacing = 20;
    self.categoryView.minVerticalCellSpacing = 10;
    self.categoryView.maxVerticalFontScale = 2;
    self.categoryView.minVerticalFontScale = 1.3;
    //你可以试试下面的配置方案
    /*
    self.categoryView.maxVerticalCellSpacing = 20;
    self.categoryView.minVerticalCellSpacing = 20;
    self.categoryView.maxVerticalFontScale = 2;
    self.categoryView.minVerticalFontScale = 1;
     */
    [self.view addSubview:self.categoryView];

    //如果你非要在scrollZoom效果上面加指示器效果，请使用JXCategoryIndicatorScrollZoomLineView自定义类，里面做了一点点特殊处理。
    JXCategoryIndicatorScrollZoomLineView *lineView = [[JXCategoryIndicatorScrollZoomLineView alloc] init];
    lineView.indicatorWidth = 20;
    self.categoryView.indicators = @[lineView];

    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.categoryView.bounds.size.height - 1, self.categoryView.bounds.size.width, 1)];
    separatorLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    separatorLine.backgroundColor = [UIColor redColor];
    [self.categoryView addSubview:separatorLine];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //测试代码选中
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.categoryView selectItemAtIndex:1];
        [self.listContainerView didClickSelectedItemAtIndex:1];
    });
     */
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)listScrollViewDidScroll:(UIScrollView *)scrollView {
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //用户交互引起的滚动才处理
        return;
    }
    //用于垂直方向滚动时，视图的frame调整
    if ((self.categoryView.bounds.size.height < self.maxCategoryViewHeight) && scrollView.contentOffset.y < 0) {
        //当前属于缩小状态且往下滑动
        //列表往下移动、categoryView高度增加
        CGRect categoryViewFrame = self.categoryView.frame;
        categoryViewFrame.size.height -= scrollView.contentOffset.y;
        categoryViewFrame.size.height = MIN(self.maxCategoryViewHeight, categoryViewFrame.size.height);
        self.categoryView.frame = categoryViewFrame;

        self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame));

        if (self.categoryView.bounds.size.height == self.maxCategoryViewHeight) {
            //从小缩放到最大，将其他列表的contentOffset重置
            for (id<JXCategoryListContentViewDelegate>list in self.listContainerView.validListDict.allValues) {
                UIScrollView *listScrollView = [self listScrollView:list];
                if (listScrollView != scrollView) {
                    [listScrollView setContentOffset:CGPointZero animated:NO];
                }
            }
        }

        scrollView.contentOffset = CGPointZero;
    }else if (((self.categoryView.bounds.size.height < self.maxCategoryViewHeight) && scrollView.contentOffset.y >= 0 && self.categoryView.bounds.size.height > self.minCategoryViewHeight) ||
              (self.categoryView.bounds.size.height >= self.maxCategoryViewHeight && scrollView.contentOffset.y >= 0)) {
        //当前属于缩小状态且往上滑动且categoryView的高度大于minCategoryViewHeight 或者 当前最大高度状态且往上滑动
        //列表往上移动、categoryView高度减小
        CGRect categoryViewFrame = self.categoryView.frame;
        categoryViewFrame.size.height -= scrollView.contentOffset.y;
        categoryViewFrame.size.height = MAX(self.minCategoryViewHeight, categoryViewFrame.size.height);
        self.categoryView.frame = categoryViewFrame;

        self.listContainerView.frame = CGRectMake(0, CGRectGetMaxY(self.categoryView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.categoryView.frame));

        scrollView.contentOffset = CGPointZero;
    }

    //必须调用
    CGFloat percent = (self.categoryView.bounds.size.height - self.minCategoryViewHeight)/(self.maxCategoryViewHeight - self.minCategoryViewHeight);
    [self.categoryView listDidScrollWithVerticalHeightPercent:percent];
}

- (UIScrollView *)listScrollView:(id<JXCategoryListContentViewDelegate>)list {
    LoadDataListContainerListViewController *listVC = (LoadDataListContainerListViewController *)list;
    return listVC.tableView;
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LoadDataListContainerListViewController *list = [[LoadDataListContainerListViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    list.didScrollCallback = ^(UIScrollView *scrollView) {
        [weakSelf listScrollViewDidScroll:scrollView];
    };
    //列表顶部有自定义视图
    /*
    LoadDataListScrollZoomViewController *list = [[LoadDataListScrollZoomViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    list.didScrollCallback = ^(UIScrollView *scrollView) {
        [weakSelf listScrollViewDidScroll:scrollView];
    };
     */
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}

@end
