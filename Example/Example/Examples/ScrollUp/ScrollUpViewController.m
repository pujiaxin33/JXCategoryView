//
//  ScrollUpViewController.m
//  Example
//
//  Created by jiaxin on 2020/5/22.
//  Copyright © 2020 jiaxin. All rights reserved.
//

#import "ScrollUpViewController.h"
#import <JXCategoryView/JXCategoryView.h>
#import "ScrollUpNavigationBar.h"
#import "UIWindow+JXSafeArea.h"
#import "ScrollUpListViewController.h"

CGFloat NaviBarHeight = 44;

@interface ScrollUpViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) ScrollUpNavigationBar *naviBar;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) UIScrollView *lastScrollView;
@property (nonatomic, assign) CGFloat lastOffsetY;
@property (nonatomic, strong) NSMutableArray <ScrollUpListViewController *> *lists;
@end

@implementation ScrollUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.lists = [NSMutableArray array];

    _naviBar = [[ScrollUpNavigationBar alloc] init];
    __weak typeof(self) weakSelf = self;
    self.naviBar.backBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:true];
    };
    self.naviBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, [UIApplication sharedApplication].keyWindow.jx_layoutInsets.top + NaviBarHeight);
    [self.view addSubview:self.naviBar];

    self.titles = @[@"第一", @"第二", @"第三"];
    _categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    [self.view addSubview:self.categoryView];
    self.categoryView.translatesAutoresizingMaskIntoConstraints = NO;
    CGFloat categoryViewHeight = 50;
    [self.categoryView.heightAnchor constraintEqualToConstant:categoryViewHeight].active = YES;
    [self.categoryView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.categoryView.topAnchor constraintEqualToAnchor:self.naviBar.bottomAnchor].active = YES;
    [self.categoryView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;


    _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_CollectionView delegate:self];
    [self.view addSubview:self.listContainerView];
    self.listContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.categoryView.bottomAnchor constraintEqualToAnchor:self.listContainerView.topAnchor].active = YES;
    [self.listContainerView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [self.listContainerView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    CGFloat listContainerViewHeight = self.view.bounds.size.height - [UIApplication sharedApplication].keyWindow.jx_layoutInsets.top - categoryViewHeight;
    [self.listContainerView.heightAnchor constraintEqualToConstant:listContainerViewHeight].active = YES;

    self.categoryView.listContainer = self.listContainerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)listScrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = CGPointZero;
    CGFloat offsetY = 0;
    if (scrollView.contentOffset.y <= 0 && self.naviBar.frame.origin.y != 0) {
        point = [scrollView.panGestureRecognizer translationInView:scrollView];
        offsetY = point.y - self.lastOffsetY;
    }else {
        if ((scrollView.contentOffset.y < 0 && self.naviBar.frame.origin.y == 0) || scrollView.contentOffset.y + scrollView.bounds.size.height >= scrollView.contentSize.height) {
            return;
        }
        point = scrollView.contentOffset;
        offsetY = -(point.y - self.lastOffsetY);
    }

    if (self.lastOffsetY == 0) {
        self.lastOffsetY = point.y;
        return;
    }
    CGRect naviBarFrame = self.naviBar.frame;
    naviBarFrame.origin.y += offsetY;
    naviBarFrame.origin.y = MAX(-NaviBarHeight, MIN(0, naviBarFrame.origin.y));
    self.naviBar.frame = naviBarFrame;
    double percent = (naviBarFrame.origin.y + NaviBarHeight)/NaviBarHeight;
    self.naviBar.alpha = percent;
    self.lastOffsetY = point.y;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    ScrollUpListViewController *list = [[ScrollUpListViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    list.scrollViewDidScrollBlock = ^(UIScrollView * _Nonnull scrollView) {
        [weakSelf listScrollViewDidScroll:scrollView];
    };
    list.willBeginDragging = ^(UIScrollView * _Nonnull scrollView) {
        weakSelf.lastOffsetY = 0;
    };
    list.didEndDragging = ^(UIScrollView * _Nonnull scrollView) {
        weakSelf.lastOffsetY = 0;
    };
    [self.lists addObject:list];
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //防止上一个列表还在滚动中，又立马滚动当前列表。会导致`- (void)listScrollViewDidScroll:(UIScrollView *)scrollView`方法被两个列表触发，导致异常。
    for (ScrollUpListViewController *list in self.lists) {
        [list stopScrolling];
    }
}



@end
