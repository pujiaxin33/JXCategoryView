//
//  JXCategoryListContainerView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryListContainerView.h"

@interface JXCategoryListContainerView () <UIScrollViewDelegate>
@property (nonatomic, weak) id<JXCategoryListContainerViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *validListDict;
@property (nonatomic, assign) BOOL willRemoveFromWindow;
@property (nonatomic, strong) JXCategoryListContainerView *retainedSelf;
@property (nonatomic, assign) NSInteger willAppearIndex;
@property (nonatomic, assign) NSInteger willDisappearIndex;
@end

@implementation JXCategoryListContainerView

- (instancetype)initWithDelegate:(id<JXCategoryListContainerViewDelegate>)delegate{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _delegate = delegate;
        _validListDict = [NSMutableDictionary dictionary];
        _willAppearIndex = -1;
        _willDisappearIndex = -1;
        _initListPercent = 0.01;
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
    self.scrollView.delegate = self;
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

- (void)willMoveToWindow:(UIWindow *)newWindow {
    //当前页面push到一个新的页面时，willMoveToWindow会调用三次。第一次调用的newWindow为nil，第二次调用间隔1ms左右newWindow有值，第三次调用间隔400ms左右newWindow为nil。
    //根据上述事实，第一次和第二次为无效调用，可以根据其间隔1ms左右过滤掉
    if (newWindow == nil) {
        self.willRemoveFromWindow = YES;
        //当前页面被pop的时候，willMoveToWindow只会调用一次，而且整个页面会被销毁掉，所以需要循环引用自己，确保能延迟执行currentListWillAndDidDisappear方法，触发列表消失事件。由此可见，循环引用也不一定是个坏事。是天使还是魔鬼，就看你如何对待它了。
        self.retainedSelf = self;
        [self performSelector:@selector(currentListWillAndDidDisappear) withObject:nil afterDelay:0.02];
    }else {
        if (self.willRemoveFromWindow) {
            self.willRemoveFromWindow = NO;
            self.retainedSelf = nil;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(currentListWillAndDidDisappear) object:nil];
        }else {
            [self currentListWillAndDidAppear];
        }
    }
}

- (void)reloadData {
    for (id<JXCategoryListContentViewDelegate> list in _validListDict.allValues) {
        [[list listView] removeFromSuperview];
    }
    [_validListDict removeAllObjects];

    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);

    [self listDidAppear:self.currentIndex];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
    [_validListDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull index, id<JXCategoryListContentViewDelegate>  _Nonnull list, BOOL * _Nonnull stop) {
        [list listView].frame = CGRectMake(index.intValue*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    }];
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;
    self.currentIndex = defaultSelectedIndex;
}

- (void)setDidAppearPercent:(CGFloat)didAppearPercent {
    self.initListPercent = didAppearPercent;
}

- (void)setinitListPercent:(CGFloat)initListPercent {
    _initListPercent = initListPercent;
    if (initListPercent <= 0 || initListPercent >= 1) {
        NSAssert(NO, @"initListPercent值范围为开区间(0,1)，即不包括0和1");
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.willDisappearIndex != -1) {
        [self listWillAppear:self.willDisappearIndex];
        [self listWillDisappear:self.willAppearIndex];
        [self listDidAppear:self.willDisappearIndex];
        [self listDidDisappear:self.willAppearIndex];
        self.willDisappearIndex = -1;
        self.willAppearIndex = -1;
    }
}

#pragma mark - JXCategoryBaseView回调

- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex {
    NSInteger targetIndex = -1;
    NSInteger disappearIndex = -1;
    CGFloat didAppearRatio = 0.98;
    if (rightIndex == selectedIndex) {
        //当前选中的在右边，用户正在从右边往左边滑动
        if (ratio < (1 - self.initListPercent)) {
            [self initListIfNeededAtIndex:leftIndex];
        }
        if (ratio < (1 - didAppearRatio)) {
            targetIndex = leftIndex;
            disappearIndex = rightIndex;
        }else {
            if (self.willAppearIndex == -1) {
                self.willAppearIndex = leftIndex;
                [self listWillAppear:self.willAppearIndex];
            }
            if (self.willDisappearIndex == -1) {
                self.willDisappearIndex = rightIndex;
                [self listWillDisappear:self.willDisappearIndex];
            }
            targetIndex = rightIndex;
            disappearIndex = leftIndex;
        }
    }else {
        //当前选中的在左边，用户正在从左边往右边滑动
        if (ratio > self.initListPercent) {
            [self initListIfNeededAtIndex:rightIndex];
        }
        if (ratio > didAppearRatio) {
            targetIndex = rightIndex;
            disappearIndex = leftIndex;
        }else {
            if (self.willAppearIndex == -1) {
                self.willAppearIndex = rightIndex;
                [self listWillAppear:self.willAppearIndex];
            }
            if (self.willDisappearIndex == -1) {
                self.willDisappearIndex = leftIndex;
                [self listWillDisappear:self.willDisappearIndex];
            }
            targetIndex = leftIndex;
            disappearIndex = rightIndex;
        }
    }

    if (targetIndex != -1 && self.currentIndex != targetIndex) {
        self.willAppearIndex = -1;
        self.willDisappearIndex = -1;
        [self listDidAppear:targetIndex];
        [self listDidDisappear:disappearIndex];
    }
}

- (void)didClickSelectedItemAtIndex:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    self.willAppearIndex = -1;
    self.willDisappearIndex = -1;
    if (self.currentIndex != index) {
        [self listWillDisappear:self.currentIndex];
        [self listDidDisappear:self.currentIndex];
        [self listWillAppear:index];
        [self listDidAppear:index];
    }
}

#pragma mark - Private

- (void)initListIfNeededAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
        BOOL canInitList = [self.delegate listContainerView:self canInitListAtIndex:index];
        if (!canInitList) {
            return;
        }
    }
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list != nil) {
        //列表已经创建好了
        return;
    }
    list = [self.delegate listContainerView:self initListForIndex:index];
    _validListDict[@(index)] = list;

    [list listView].frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    [self.scrollView addSubview:[list listView]];
    [self listWillAppear:index];
}

- (void)currentListWillAndDidAppear {
    [self listWillAppear:self.currentIndex];
    [self listDidAppear:self.currentIndex];
}

- (void)currentListWillAndDidDisappear {
    [self listWillDisappear:self.currentIndex];
    [self listDidDisappear:self.currentIndex];
    self.willRemoveFromWindow = NO;
    self.retainedSelf = nil;
}

- (void)listWillAppear:(NSInteger)index {
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listWillAppear)]) {
        [list listWillAppear];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC beginAppearanceTransition:YES animated:NO];
    }
}

- (void)listDidAppear:(NSInteger)index {
    self.currentIndex = index;
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list != nil) {
        if (list && [list respondsToSelector:@selector(listDidAppear)]) {
            [list listDidAppear];
        }
        if ([list isKindOfClass:[UIViewController class]]) {
            UIViewController *listVC = (UIViewController *)list;
            [listVC endAppearanceTransition];
        }
    }else {
        //当前列表未被创建（通过点击触发的listDidAppear）
        BOOL canInitList = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
            canInitList = [self.delegate listContainerView:self canInitListAtIndex:index];
        }
        if (canInitList) {
            id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
            if (list == nil) {
                list = [self.delegate listContainerView:self initListForIndex:index];
                _validListDict[@(index)] = list;
            }
            if ([list listView].superview == nil) {
                [list listView].frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
                [self.scrollView addSubview:[list listView]];
                [self listWillAppear:index];
            }
            if (list && [list respondsToSelector:@selector(listDidAppear)]) {
                [list listDidAppear];
            }
            if ([list isKindOfClass:[UIViewController class]]) {
                UIViewController *listVC = (UIViewController *)list;
                [listVC endAppearanceTransition];
            }
        }
    }
}

- (void)listWillDisappear:(NSInteger)index {
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listWillDisappear)]) {
        [list listWillDisappear];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC beginAppearanceTransition:NO animated:NO];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC endAppearanceTransition];
    }
}

- (BOOL)checkIndexValid:(NSInteger)index {
    NSUInteger count = [self.delegate numberOfListsInlistContainerView:self];
    if (count <= 0 || index >= count) {
        return NO;
    }
    return YES;
}

@end
