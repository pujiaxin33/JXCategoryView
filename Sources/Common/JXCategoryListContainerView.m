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
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *validListDict;
@property (nonatomic, assign) BOOL isLayoutSubviewsed;
@property (nonatomic, strong) NSLock *lock;
@end

@implementation JXCategoryListContainerView

- (instancetype)initWithDelegate:(id<JXCategoryListContainerViewDelegate>)delegate{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        _didAppearPercent = 0.5;
        _delegate = delegate;
        _validListDict = [NSMutableDictionary dictionary];
        _lock = [[NSLock alloc] init];
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewInlistContainerView:)]) {
        _scrollView = [self.delegate scrollViewInlistContainerView:self];
    }else {
        _scrollView = [[UIScrollView alloc] init];
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.bounces = NO;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.scrollView];
}

- (void)reloadData {
    [_lock lock];
    for (id<JXCategoryListContentViewDelegate> list in _validListDict.allValues) {
        [[list listView] removeFromSuperview];
    }
    [_validListDict removeAllObjects];
    [_lock unlock];

    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);

    [self listDidAppear:self.currentIndex];
}

- (void)currentListDidAppear {
    [self listDidAppear:self.currentIndex];
}

- (void)currentListDidDisappear {
    [self listDidDisappear:self.currentIndex];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
    [_lock lock];
    [_validListDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull index, id<JXCategoryListContentViewDelegate>  _Nonnull list, BOOL * _Nonnull stop) {
        [list listView].frame = CGRectMake(index.intValue*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    }];
    [_lock unlock];
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

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notification {
    [_lock lock];
    for (NSNumber *index in _validListDict) {
        if (index.integerValue != _currentIndex) {
            id<JXCategoryListContentViewDelegate> list = _validListDict[index];
            [[list listView] removeFromSuperview];
        }
    }
    id<JXCategoryListContentViewDelegate> currentList = _validListDict[@(_currentIndex)];
    [_validListDict removeAllObjects];
    [_validListDict setObject:currentList forKey:@(_currentIndex)];
    [_lock unlock];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    if (self.currentIndex != index) {
        [self listDidDisappear:self.currentIndex];
        [self listDidAppear:index];
    }
}

#pragma mark - Private

- (void)listDidAppear:(NSInteger)index {
    NSUInteger count = [self.delegate numberOfListsInlistContainerView:self];
    if (count <= 0 || index >= count) {
        return;
    }
    self.currentIndex = index;

    [_lock lock];
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    [_lock unlock];
    if (list == nil) {
        list = [self.delegate listContainerView:self initListForIndex:index];
    }
    if ([list listView].superview == nil) {
        [list listView].frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.scrollView addSubview:[list listView]];
        [_lock lock];
        _validListDict[@(index)] = list;
        [_lock unlock];
    }
    if (list && [list respondsToSelector:@selector(listDidAppear)]) {
        [list listDidAppear];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    NSUInteger count = [self.delegate numberOfListsInlistContainerView:self];
    if (count <= 0 || index >= count) {
        return;
    }
    [_lock lock];
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    [_lock unlock];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
}


@end

@implementation JXCategoryListContainerView (Deprecated)

- (instancetype)initWithParentVC:(UIViewController *)parentVC delegate:(id<JXCategoryListContainerViewDelegate>)delegate {
    return [self initWithDelegate:delegate];
}

@end
