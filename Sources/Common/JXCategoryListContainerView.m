//
//  JXCategoryListContainerView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryListContainerView.h"

@interface JXCategoryListContainerView ()
@property (nonatomic, weak) id<JXCategoryListContainerViewDelegate> delegate;
@property (nonatomic, weak) UIViewController *parentViewController;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *listVCDict;
@property (nonatomic, assign) BOOL isLayoutSubviewsed;
@end

@implementation JXCategoryListContainerView

- (instancetype)initWithParentVC:(UIViewController *)parentVC delegate:(id<JXCategoryListContainerViewDelegate>)delegate {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _didAppearPercent = 0.5;
        _parentViewController = parentVC;
        _parentViewController.automaticallyAdjustsScrollViewInsets = NO;
        _delegate = delegate;
        _listVCDict = [NSMutableDictionary dictionary];
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    _scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.bounces = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.scrollView];
}

- (void)reloadData {
    for (id<JXCategoryListContentViewDelegate> list in self.listVCDict.allValues) {
        [list.listView removeFromSuperview];
    }
    [self.listVCDict removeAllObjects];

    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);

    [self listDidAppear:self.currentIndex];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
    if (!self.isLayoutSubviewsed) {
        self.isLayoutSubviewsed = YES;
        //初始化第一次调用
        [self listDidAppear:self.currentIndex];
    }
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;

    self.currentIndex = defaultSelectedIndex;
}

#pragma mark - JXCategoryBaseView回调

- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex {
    NSInteger targetIndex = -1;
    NSInteger disappearIndex = -1;
    if (rightIndex == selectedIndex) {
        //当前选中的在右边，用户正在从右边往左边滑动
        if (ratio < (1 - self.didAppearPercent)) {
            targetIndex = leftIndex;
            disappearIndex = rightIndex;
        }
    }else {
        //当前选中的在左边，用户正在从左边往右边滑动
        if (ratio > self.didAppearPercent) {
            targetIndex = rightIndex;
            disappearIndex = leftIndex;
        }
    }

    if (targetIndex != -1 && self.currentIndex != targetIndex) {
        [self listDidAppear:targetIndex];
        [self listDidDisappear:disappearIndex];
    }
}

- (void)didClickSelectedItemAtIndex:(NSInteger)index {
    [self listDidDisappear:self.currentIndex];
    [self listDidAppear:index];
}

#pragma mark - Private

- (void)listDidAppear:(NSInteger)index {
    self.currentIndex = index;

    id<JXCategoryListContentViewDelegate> list = self.listVCDict[@(index)];
    if (list == nil) {
        list = [self.delegate listContainerView:self initListForIndex:index];
    }
    if (list.listView.superview == nil) {
        list.listView.frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.scrollView addSubview:list.listView];
        self.listVCDict[@(index)] = list;
    }
    if (list && [list respondsToSelector:@selector(listDidAppear)]) {
        [list listDidAppear];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    id<JXCategoryListContentViewDelegate> list = self.listVCDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
}


@end
