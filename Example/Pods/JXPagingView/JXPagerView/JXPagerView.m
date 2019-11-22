//
//  JXPagerView.m
//  JXPagerView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXPagerView.h"

@interface JXPagerView () <UITableViewDataSource, UITableViewDelegate, JXPagerListContainerViewDelegate>
@property (nonatomic, weak) id<JXPagerViewDelegate> delegate;
@property (nonatomic, strong) JXPagerMainTableView *mainTableView;
@property (nonatomic, strong) JXPagerListContainerView *listContainerView;
@property (nonatomic, strong) UIScrollView *currentScrollingListView;
@property (nonatomic, strong) id<JXPagerViewListViewDelegate> currentList;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<JXPagerViewListViewDelegate>> *validListDict;
@property (nonatomic, assign) UIDeviceOrientation currentDeviceOrientation;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) BOOL willRemoveFromWindow;
@property (nonatomic, assign) BOOL isFirstMoveToWindow;
@property (nonatomic, strong) JXPagerView *retainedSelf;
@property (nonatomic, strong) UIView *tableHeaderContainerView;
@end

@implementation JXPagerView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (instancetype)initWithDelegate:(id<JXPagerViewDelegate>)delegate {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _delegate = delegate;
        _validListDict = [NSMutableDictionary dictionary];
        _automaticallyDisplayListVerticalScrollIndicator = YES;
        _deviceOrientationChangeEnabled = NO;
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

- (void)layoutSubviews {
    [super layoutSubviews];

    if (!CGRectEqualToRect(self.bounds, self.mainTableView.frame)) {
        self.mainTableView.frame = self.bounds;
        [self.mainTableView reloadData];
    }
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;

    self.listContainerView.defaultSelectedIndex = defaultSelectedIndex;
}

- (void)setIsListHorizontalScrollEnabled:(BOOL)isListHorizontalScrollEnabled {
    _isListHorizontalScrollEnabled = isListHorizontalScrollEnabled;

    self.listContainerView.collectionView.scrollEnabled = isListHorizontalScrollEnabled;
}

- (void)reloadData {
    self.currentList = nil;
    self.currentScrollingListView = nil;

    for (id<JXPagerViewListViewDelegate> list in self.validListDict.allValues) {
        [list.listView removeFromSuperview];
    }
    [_validListDict removeAllObjects];

    [self refreshTableHeaderView];
    [self.mainTableView reloadData];
    [self.listContainerView reloadData];
}

- (void)resizeTableHeaderViewHeightWithAnimatable:(BOOL)animatable duration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve {
    if (animatable) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:duration];
        [UIView setAnimationCurve:curve];
        CGRect frame = self.tableHeaderContainerView.bounds;
        frame.size.height = [self.delegate tableHeaderViewHeightInPagerView:self];
        self.tableHeaderContainerView.frame = frame;
        self.mainTableView.tableHeaderView = self.tableHeaderContainerView;
        [UIView commitAnimations];
    }else {
        CGRect frame = self.tableHeaderContainerView.bounds;
        frame.size.height = [self.delegate tableHeaderViewHeightInPagerView:self];
        self.tableHeaderContainerView.frame = frame;
        self.mainTableView.tableHeaderView = self.tableHeaderContainerView;
    }
}

#pragma mark - Private

- (void)refreshTableHeaderView {
    if (self.delegate == nil) {
        return;
    }
    UIView *tableHeaderView = [self.delegate tableHeaderViewInPagerView:self];
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, [self.delegate tableHeaderViewHeightInPagerView:self])];
    [containerView addSubview:tableHeaderView];
    tableHeaderView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:tableHeaderView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:tableHeaderView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:tableHeaderView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:tableHeaderView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:containerView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    [containerView addConstraints:@[top, leading, bottom, trailing]];
    self.tableHeaderContainerView = containerView;
    self.mainTableView.tableHeaderView = containerView;
}

- (void)adjustMainScrollViewToTargetContentInsetIfNeeded:(UIEdgeInsets)insets {
    if (UIEdgeInsetsEqualToEdgeInsets(insets, self.mainTableView.contentInset) == NO) {
        self.mainTableView.contentInset = insets;
    }
}

- (void)listViewDidScroll:(UIScrollView *)scrollView {
    self.currentScrollingListView = scrollView;

    [self preferredProcessListViewDidScroll:scrollView];
}

- (void)deviceOrientationDidChangeNotification:(NSNotification *)notification {
    if (self.isDeviceOrientationChangeEnabled && self.currentDeviceOrientation != [UIDevice currentDevice].orientation) {
        self.currentDeviceOrientation = [UIDevice currentDevice].orientation;
        //前后台切换也会触发该通知，所以不相同的时候才处理
        [self.mainTableView reloadData];
        [self.listContainerView deviceOrientationDidChanged];
        [self.listContainerView reloadData];
    }
}

- (void)currentListDidAppear {
    [self listDidAppear:self.currentIndex];
}

- (void)currentListDidDisappear {
    id<JXPagerViewListViewDelegate> list = _validListDict[@(self.currentIndex)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
    self.willRemoveFromWindow = NO;
    self.retainedSelf = nil;
}

- (void)listDidAppear:(NSInteger)index {
    if (self.delegate == nil) {
        return;
    }
    NSUInteger count = [self.delegate numberOfListsInPagerView:self];
    if (count <= 0 || index >= count) {
        return;
    }
    self.currentIndex = index;

    id<JXPagerViewListViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidAppear)]) {
        [list listDidAppear];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    if (self.delegate == nil) {
        return;
    }
    NSUInteger count = [self.delegate numberOfListsInPagerView:self];
    if (count <= 0 || index >= count) {
        return;
    }
    id<JXPagerViewListViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate == nil) {
        return 0;
    }
    return MAX(self.bounds.size.height - [self.delegate heightForPinSectionHeaderInPagerView:self] - self.pinSectionHeaderVerticalOffset, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.listContainerView.frame = cell.bounds;
    [cell.contentView addSubview:self.listContainerView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.delegate == nil) {
        return 0;
    }
    return [self.delegate heightForPinSectionHeaderInPagerView:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.delegate == nil) {
        return [[UIView alloc] init];
    }
    return [self.delegate viewForPinSectionHeaderInPagerView:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectZero];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.pinSectionHeaderVerticalOffset != 0) {
        if (scrollView.contentOffset.y < self.pinSectionHeaderVerticalOffset) {

            if (scrollView.contentOffset.y >= self.mainTableViewMaxContentOffsetY) {
                //处理mainTableViewMaxContentOffsetY比pinSectionHeaderVerticalOffset还小的情况
                //固定的位置就是contentInset.top
                [self adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsMake(self.pinSectionHeaderVerticalOffset, 0, 0, 0)];
            }else if (scrollView.contentOffset.y >= 0) {
                //因为设置了contentInset.top，所以顶部会有对应高度的空白区间，所以需要设置负数抵消掉
                [self adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)];
            }else if (scrollView.contentOffset.y < 0) {
                [self adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsZero];
            }
        }else if (scrollView.contentOffset.y > self.pinSectionHeaderVerticalOffset){
            //固定的位置就是contentInset.top
            [self adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsMake(self.pinSectionHeaderVerticalOffset, 0, 0, 0)];
        }
    }

    [self preferredProcessMainTableViewDidScroll:scrollView];

    if (self.delegate && [self.delegate respondsToSelector:@selector(mainTableViewDidScroll:)]) {
        [self.delegate mainTableViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.listContainerView.collectionView.scrollEnabled = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.isListHorizontalScrollEnabled && !decelerate) {
        self.listContainerView.collectionView.scrollEnabled = YES;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isListHorizontalScrollEnabled) {
        self.listContainerView.collectionView.scrollEnabled = YES;
    }
    if (self.mainTableView.contentInset.top != 0 && self.pinSectionHeaderVerticalOffset != 0) {
        [self adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsZero];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.isListHorizontalScrollEnabled) {
        self.listContainerView.collectionView.scrollEnabled = YES;
    }
}

#pragma mark - JXPagingListContainerViewDelegate

- (NSInteger)numberOfRowsInListContainerView:(JXPagerListContainerView *)listContainerView {
    if (self.delegate == nil) {
        return 0;
    }
    return [self.delegate numberOfListsInPagerView:self];
}

- (UIView *)listContainerView:(JXPagerListContainerView *)listContainerView listViewInRow:(NSInteger)row {
    if (self.delegate == nil) {
        return [[UIView alloc] init];
    }
    id<JXPagerViewListViewDelegate> list = self.validListDict[@(row)];
    if (list == nil) {
        list = [self.delegate pagerView:self initListAtIndex:row];
        __weak typeof(self)weakSelf = self;
        __weak typeof(id<JXPagerViewListViewDelegate>) weakList = list;
        [list listViewDidScrollCallback:^(UIScrollView *scrollView) {
            weakSelf.currentList = weakList;
            [weakSelf listViewDidScroll:scrollView];
        }];
        _validListDict[@(row)] = list;
    }
    for (id<JXPagerViewListViewDelegate> listItem in self.validListDict.allValues) {
        if (listItem == list) {
            [listItem listScrollView].scrollsToTop = YES;
        }else {
            [listItem listScrollView].scrollsToTop = NO;
        }
    }

    return [list listView];
}

- (void)listContainerView:(JXPagerListContainerView *)listContainerView willDisplayCellAtRow:(NSInteger)row {
    [self listDidAppear:row];
    self.currentScrollingListView = [self.validListDict[@(row)] listScrollView];
}

- (void)listContainerView:(JXPagerListContainerView *)listContainerView didEndDisplayingCellAtRow:(NSInteger)row {
    [self listDidDisappear:row];
}

@end

@implementation JXPagerView (UISubclassingGet)

- (CGFloat)mainTableViewMaxContentOffsetY {
    if (self.delegate == nil) {
        return 0;
    }
    return [self.delegate tableHeaderViewHeightInPagerView:self] - self.pinSectionHeaderVerticalOffset;
}

@end

@implementation JXPagerView (UISubclassingHooks)

- (void)initializeViews {
    _mainTableView = [[JXPagerMainTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.showsHorizontalScrollIndicator = NO;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.scrollsToTop = NO;
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    [self refreshTableHeaderView];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.mainTableView];

    _listContainerView = [[JXPagerListContainerView alloc] initWithDelegate:self];
    self.listContainerView.mainTableView = self.mainTableView;

    self.isListHorizontalScrollEnabled = YES;

    self.currentDeviceOrientation = [UIDevice currentDevice].orientation;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChangeNotification:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView {
    if (self.mainTableView.contentOffset.y < self.mainTableViewMaxContentOffsetY) {
        //mainTableView的header还没有消失，让listScrollView一直为0
        if (self.currentList && [self.currentList respondsToSelector:@selector(listScrollViewWillResetContentOffset)]) {
            [self.currentList listScrollViewWillResetContentOffset];
        }
        [self setListScrollViewToMinContentOffsetY:scrollView];
        if (self.automaticallyDisplayListVerticalScrollIndicator) {
            scrollView.showsVerticalScrollIndicator = NO;
        }
    }else {
        //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
        self.mainTableView.contentOffset = CGPointMake(0, self.mainTableViewMaxContentOffsetY);
        if (self.automaticallyDisplayListVerticalScrollIndicator) {
            scrollView.showsVerticalScrollIndicator = YES;
        }
    }
}

- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView {
    if (self.currentScrollingListView != nil && self.currentScrollingListView.contentOffset.y > [self minContentOffsetYInListScrollView:self.currentScrollingListView]) {
        //mainTableView的header已经滚动不见，开始滚动某一个listView，那么固定mainTableView的contentOffset，让其不动
        [self setMainTableViewToMaxContentOffsetY];
    }

    if (scrollView.contentOffset.y < self.mainTableViewMaxContentOffsetY) {
        //mainTableView已经显示了header，listView的contentOffset需要重置
        for (id<JXPagerViewListViewDelegate> list in self.validListDict.allValues) {
            if ([list respondsToSelector:@selector(listScrollViewWillResetContentOffset)]) {
                [list listScrollViewWillResetContentOffset];
            }
            [self setListScrollViewToMinContentOffsetY:[list listScrollView]];
        }
    }

    if (scrollView.contentOffset.y > self.mainTableViewMaxContentOffsetY && self.currentScrollingListView.contentOffset.y == [self minContentOffsetYInListScrollView:self.currentScrollingListView]) {
        //当往上滚动mainTableView的headerView时，滚动到底时，修复listView往上小幅度滚动
        [self setMainTableViewToMaxContentOffsetY];
    }
}

- (void)setMainTableViewToMaxContentOffsetY {
    self.mainTableView.contentOffset = CGPointMake(0, self.mainTableViewMaxContentOffsetY);
}

- (void)setListScrollViewToMinContentOffsetY:(UIScrollView *)scrollView {
    scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, [self minContentOffsetYInListScrollView:scrollView]);
}

- (CGFloat)minContentOffsetYInListScrollView:(UIScrollView *)scrollView {
    if (@available(iOS 11.0, *)) {
        return -scrollView.adjustedContentInset.top;
    }
    return -scrollView.contentInset.top;
}


@end
