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
@property (nonatomic, assign) BOOL isFirstMoveToWindow;
@property (nonatomic, strong) JXCategoryListCollectionContainerView *retainedSelf;
@property (nonatomic, assign) BOOL shouldRefreshSelectedContentOffset;
@end

@implementation JXCategoryListCollectionContainerView

- (instancetype)initWithDataSource:(id<JXCategoryListCollectionContainerViewDataSource>)dataSource {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.dataSource = dataSource;
        _isFirstMoveToWindow = YES;
        _shouldRefreshSelectedContentOffset = YES;
        _validListDict = [NSMutableDictionary dictionary];
        [self initializeViews];
    }
    return self;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (self.isFirstMoveToWindow) {
        //第一次调用过滤，因为第一次列表显示通知会从willDisplayCell方法通知
        self.isFirstMoveToWindow = NO;
        return;
    }
    //当前页面push到一个新的页面时，willMoveToWindow会调用三次。第一次调用的newWindow为nil，第二次调用间隔1ms左右newWindow有值，第三次调用间隔400ms左右newWindow为nil。
    //根据上述事实，第一次和第二次为无效调用，可以根据其间隔1ms左右过滤掉
    if (newWindow == nil) {
        self.willRemoveFromWindow = YES;
        //当前页面被pop的时候，willMoveToWindow只会调用一次，而且整个页面会被销毁掉，所以需要循环引用自己，确保能延迟执行currentListDidDisappear方法，触发列表消失事件。由此可见，循环引用也不一定是个坏事。是天使还是魔鬼，就看你如何对待它了。
        self.retainedSelf = self;
        [self performSelector:@selector(currentListDidDisappear) withObject:nil afterDelay:0.02];
    }else {
        if (self.willRemoveFromWindow) {
            self.willRemoveFromWindow = NO;
            self.retainedSelf = nil;
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(currentListDidDisappear) object:nil];
        }else {
            [self currentListDidAppear];
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

#pragma mark - Setter

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;

    self.currentIndex = defaultSelectedIndex;
}

#pragma mark - Private

- (void)currentListDidAppear {
    [self listDidAppear:self.currentIndex];
}

- (void)currentListDidDisappear {
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(self.currentIndex)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
    self.willRemoveFromWindow = NO;
    self.retainedSelf = nil;
}

- (void)listDidAppear:(NSInteger)index {
    NSUInteger count = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfListsInlistContainerView:)]) {
        count = [self.dataSource numberOfListsInlistContainerView:self];
    }
    if (count <= 0 || index >= count) {
        return;
    }
    self.currentIndex = index;

    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidAppear)]) {
        [list listDidAppear];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    NSUInteger count = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfListsInlistContainerView:)]) {
        count = [self.dataSource numberOfListsInlistContainerView:self];
    }
    if (count <= 0 || index >= count) {
        return;
    }
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfListsInlistContainerView:)]) {
        count = [self.dataSource numberOfListsInlistContainerView:self];
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    self.currentIndex = indexPath.item;
    BOOL canInitList = YES;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
        canInitList = [self.dataSource listContainerView:self canInitListAtIndex:indexPath.item];
    }
    if (canInitList) {
        id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(indexPath.item)];
        if (list == nil && self.dataSource && [self.dataSource respondsToSelector:@selector(listContainerView:initListForIndex:)]) {
            list = [self.dataSource listContainerView:self initListForIndex:indexPath.item];
            if (list != nil) {
                _validListDict[@(indexPath.item)] = list;
            }
        }
        if (list != nil) {
            [list listView].frame = cell.contentView.bounds;
            [cell.contentView addSubview:[list listView]];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(indexPath.item)];
    if (list && [list respondsToSelector:@selector(listDidAppear)]) {
        [list listDidAppear];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    id<JXCategoryListCollectionContentViewDelegate> list = _validListDict[@(indexPath.item)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

@end
