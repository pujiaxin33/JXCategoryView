//
//  OCExampleViewController.m
//  JXPagingView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "PagingViewController.h"
#import "JXPagingView.h"
#import "JXCategoryView.h"
#import "PagingViewTableHeaderView.h"
#import "PartnerListView.h"
#import "HobbyListView.h"
#import "PowerListView.h"

static const CGFloat JXTableHeaderViewHeight = 200;
static const CGFloat JXheightForHeaderInSection = 50;

@interface PagingViewController () <TestListViewDelegate, JXPagingViewDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) JXPagingView *pagingView;
@property (nonatomic, strong) PagingViewTableHeaderView *userHeaderView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <TestListBaseView *> *listViewArray;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@end

@implementation PagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人中心";
    self.navigationController.navigationBar.translucent = false;
    _titles = @[@"能力", @"爱好", @"队友"];

    
    PowerListView *powerListView = [[PowerListView alloc] init];
    powerListView.delegate = self;

    HobbyListView *hobbyListView = [[HobbyListView alloc] init];
    hobbyListView.delegate = self;

    PartnerListView *partnerListView = [[PartnerListView alloc] init];
    partnerListView.delegate = self;

    _listViewArray = @[powerListView, hobbyListView, partnerListView];

    _userHeaderView = [[PagingViewTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXTableHeaderViewHeight)];

    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    lineView.indicatorLineWidth = 30;
    self.categoryView.indicators = @[lineView];

    _pagingView = [[JXPagingView alloc] initWithDelegate:self];
    [self.view addSubview:self.pagingView];

    self.categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagingView.frame = self.view.bounds;
}

#pragma mark - TestListViewDelegate

- (void)listViewDidScroll:(UIScrollView *)scrollView {
    [self.pagingView listViewDidScroll:scrollView];
}

#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagingView:(JXPagingView *)pagingView {
    return self.userHeaderView;
}

- (CGFloat)tableHeaderViewHeightInPagingView:(JXPagingView *)pagingView {
    return JXTableHeaderViewHeight;
}

- (CGFloat)heightForPinSectionHeaderInPagingView:(JXPagingView *)pagingView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagingView:(JXPagingView *)pagingView {
    return self.categoryView;
}

- (NSInteger)numberOfListViewsInPagingView:(JXPagingView *)pagingView {
    return self.titles.count;
}

- (UIView<JXPagingViewListViewDelegate> *)pagingView:(JXPagingView *)pagingView listViewInRow:(NSInteger)row {
    return self.listViewArray[row];
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

@end


