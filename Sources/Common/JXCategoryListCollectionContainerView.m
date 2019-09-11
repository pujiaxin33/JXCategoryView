//
//  JXCategoryListCollectionContainerView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryListCollectionContainerView.h"
#import <objc/runtime.h>

@interface JXCategoryListCollectionContainerView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) id<JXCategoryListCollectionContainerViewDataSource> dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<JXCategoryListCollectionContentViewDelegate>> *validListDict;
@property (nonatomic, assign) BOOL willRemoveFromWindow;
@property (nonatomic, strong) JXCategoryListCollectionContainerView *retainedSelf;
@property (nonatomic, assign) BOOL shouldRefreshSelectedContentOffset;
@property (nonatomic, assign) NSInteger willAppearIndex;
@property (nonatomic, assign) NSInteger willDisappearIndex;
@end

@implementation JXCategoryListCollectionContainerView

- (instancetype)initWithDataSource:(id<JXCategoryListCollectionContainerViewDataSource>)dataSource {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.dataSource = dataSource;
        _shouldRefreshSelectedContentOffset = YES;
        _validListDict = [NSMutableDictionary dictionary];
        _willAppearIndex = -1;
        _willDisappearIndex = -1;
        _initListPercent = 0.01;
        [self initializeViews];
    }
    return self;
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

- (void)initializeViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    if (self.dataSource &&
        [self.dataSource respondsToSelector:@selector(collectionViewClassInListContainerView:)] &&
        [[self.dataSource collectionViewClassInListContainerView:self] isKindOfClass:object_getClass([UICollectionView class])]) {
        _collectionView = (UICollectionView *)[[[self.dataSource collectionViewClassInListContainerView:self] alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    }else {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.bounces = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    if (@available(iOS 10.0, *)) {
        self.collectionView.prefetchingEnabled = NO;
    }
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.collectionView];
}

- (void)reloadData {
    for (id<JXCategoryListCollectionContentViewDelegate> list in _validListDict.allValues) {
        [[list listView] removeFromSuperview];
    }
    [_validListDict removeAllObjects];

    [self.collectionView reloadData];
    [self listDidAppear:self.currentIndex];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (!CGRectEqualToRect(self.collectionView.frame, CGRectZero) &&  !CGSizeEqualToSize(self.collectionView.bounds.size, self.bounds.size)) {
        [self.collectionView.collectionViewLayout invalidateLayout];
        self.shouldRefreshSelectedContentOffset = YES;
    }
    self.collectionView.frame = self.bounds;
    if (self.shouldRefreshSelectedContentOffset) {
        self.shouldRefreshSelectedContentOffset = NO;
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.bounds.size.width*self.currentIndex, 0) animated:NO];
    }
}

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

#pragma mark - Setter

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;

    self.currentIndex = defaultSelectedIndex;
}

#pragma mark - Private

- (void)initListIfNeededAtIndex:(NSInteger)index {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
        BOOL canInitList = [self.dataSource listContainerView:self canInitListAtIndex:index];
        if (!canInitList) {
            return;
        }
    }
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
    if (list != nil) {
        //列表已经创建好了
        return;
    }
    list = [self.dataSource listContainerView:self initListForIndex:index];
    _validListDict[@(index)] = list;

    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [list listView].frame = cell.contentView.bounds;
    [cell.contentView addSubview:[list listView]];
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
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
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
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
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
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
            canInitList = [self.dataSource listContainerView:self canInitListAtIndex:index];
        }
        if (canInitList) {
            id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
            if (list == nil) {
                list = [self.dataSource listContainerView:self initListForIndex:index];
                _validListDict[@(index)] = list;
            }
            if ([list listView].superview == nil) {
                UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
                [list listView].frame = cell.contentView.bounds;
                [cell.contentView addSubview:[list listView]];
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
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listWillDisappear)]) {
        [list listWillDisappear];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC beginAppearanceTransition:NO animated:NO];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC endAppearanceTransition];
    }
}

- (BOOL)checkIndexValid:(NSInteger)index {
    NSUInteger count = [self.dataSource numberOfListsInlistContainerView:self];
    if (count <= 0 || index >= count) {
        return NO;
    }
    return YES;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource numberOfListsInlistContainerView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(indexPath.item)];
    if (list && [list listView].superview == nil) {
        [list listView].frame = cell.contentView.bounds;
        [cell.contentView addSubview:[list listView]];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
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

@end
