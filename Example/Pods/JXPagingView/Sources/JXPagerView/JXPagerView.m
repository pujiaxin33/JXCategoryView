//
//  JXPagerView.m
//  JXPagerView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXPagerView.h"
@class JXPagerListContainerScrollView;
@class JXPagerListContainerCollectionView;

@interface JXPagerView () <UITableViewDataSource, UITableViewDelegate, JXPagerListContainerViewDelegate>
@property (nonatomic, weak) id<JXPagerViewDelegate> delegate;
@property (nonatomic, strong) JXPagerMainTableView *mainTableView;
@property (nonatomic, strong) JXPagerListContainerView *listContainerView;
@property (nonatomic, strong) UIScrollView *currentScrollingListView;
@property (nonatomic, strong) id<JXPagerViewListViewDelegate> currentList;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<JXPagerViewListViewDelegate>> *validListDict;
@property (nonatomic, strong) UIView *tableHeaderContainerView;
@end

@implementation JXPagerView

- (instancetype)initWithDelegate:(id<JXPagerViewDelegate>)delegate {
    return [self initWithDelegate:delegate listContainerType:JXPagerListContainerType_CollectionView];
}

- (instancetype)initWithDelegate:(id<JXPagerViewDelegate>)delegate listContainerType:(JXPagerListContainerType)type {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _delegate = delegate;
        _validListDict = [NSMutableDictionary dictionary];
        _automaticallyDisplayListVerticalScrollIndicator = YES;
        _isListHorizontalScrollEnabled = YES;

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

        _listContainerView = [[JXPagerListContainerView alloc] initWithType:type delegate:self];
    }
    return self;
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

    self.listContainerView.scrollView.scrollEnabled = isListHorizontalScrollEnabled;
}

- (void)reloadData {
    self.currentList = nil;
    self.currentScrollingListView = nil;
    [_validListDict removeAllObjects];

    [self refreshTableHeaderView];
    if (self.pinSectionHeaderVerticalOffset != 0) {
        self.mainTableView.contentOffset = CGPointZero;
    }
    [self.mainTableView reloadData];
    [self.listContainerView reloadData];
}

- (void)resizeTableHeaderViewHeightWithAnimatable:(BOOL)animatable duration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve {
    if (animatable) {
        UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear;
        switch (curve) {
            case UIViewAnimationCurveEaseIn: options = UIViewAnimationOptionCurveEaseIn; break;
            case UIViewAnimationCurveEaseOut: options = UIViewAnimationOptionCurveEaseOut; break;
            case UIViewAnimationCurveEaseInOut: options = UIViewAnimationOptionCurveEaseInOut; break;
            default: break;
        }
        [UIView animateWithDuration:duration delay:0 options:options animations:^{
            CGRect frame = self.tableHeaderContainerView.bounds;
            frame.size.height = [self.delegate tableHeaderViewHeightInPagerView:self];
            self.tableHeaderContainerView.frame = frame;
            self.mainTableView.tableHeaderView = self.tableHeaderContainerView;
            [self.mainTableView setNeedsLayout];
            [self.mainTableView layoutIfNeeded];
        } completion:^(BOOL finished) { }];
    }else {
        CGRect frame = self.tableHeaderContainerView.bounds;
        frame.size.height = [self.delegate tableHeaderViewHeightInPagerView:self];
        self.tableHeaderContainerView.frame = frame;
        self.mainTableView.tableHeaderView = self.tableHeaderContainerView;
    }
}

#pragma mark - Private

- (void)refreshTableHeaderView {
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
        self.mainTableView.delegate = nil;
        self.mainTableView.contentInset = insets;
        self.mainTableView.delegate = self;
    }
}

- (void)listViewDidScroll:(UIScrollView *)scrollView {
    self.currentScrollingListView = scrollView;
    [self preferredProcessListViewDidScroll:scrollView];
}

//仅用于处理设置了pinSectionHeaderVerticalOffset，又添加了MJRefresh的下拉刷新。这种情况会导致JXPagingView和MJRefresh来回设置contentInset值。针对这种及其特殊的情况，就内部特殊处理了。通过下面的判断条件，来判定当前是否处于下拉刷新中。请勿让pinSectionHeaderVerticalOffset和下拉刷新设置的contentInset.top值相同。
//具体原因参考：https://github.com/pujiaxin33/JXPagingView/issues/203
- (BOOL)isSetMainScrollViewContentInsetToZeroEnabled:(UIScrollView *)scrollView {
    //scrollView.contentInset.top不为0，且scrollView.contentInset.top不等于pinSectionHeaderVerticalOffset，即可认为列表正在刷新。所以这里必须要保证pinSectionHeaderVerticalOffset和MJRefresh的mj_insetT的值不相等。
    BOOL isRefreshing = scrollView.contentInset.top != 0 && scrollView.contentInset.top != self.pinSectionHeaderVerticalOffset;
    return !isRefreshing;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MAX(self.bounds.size.height - [self.delegate heightForPinSectionHeaderInPagerView:self] - self.pinSectionHeaderVerticalOffset, 0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    self.listContainerView.frame = cell.bounds;
    [cell.contentView addSubview:self.listContainerView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.delegate heightForPinSectionHeaderInPagerView:self];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
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
        if (!(self.currentScrollingListView != nil && self.currentScrollingListView.contentOffset.y > [self minContentOffsetYInListScrollView:self.currentScrollingListView])) {
            //没有处于滚动某一个listView的状态
            if (scrollView.contentOffset.y >= self.pinSectionHeaderVerticalOffset) {
                //固定的位置就是contentInset.top
                [self adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsMake(self.pinSectionHeaderVerticalOffset, 0, 0, 0)];
            }else {
                if ([self isSetMainScrollViewContentInsetToZeroEnabled:scrollView]) {
                    [self adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsZero];
                }
            }
        }
    }
    [self preferredProcessMainTableViewDidScroll:scrollView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(mainTableViewDidScroll:)]) {
        #pragma GCC diagnostic push
        #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        [self.delegate mainTableViewDidScroll:scrollView];
        #pragma GCC diagnostic pop
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pagerView:mainTableViewDidScroll:)]) {
        [self.delegate pagerView:self mainTableViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.listContainerView.scrollView.scrollEnabled = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(pagerView:mainTableViewWillBeginDragging:)]) {
        [self.delegate pagerView:self mainTableViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.isListHorizontalScrollEnabled && !decelerate) {
        self.listContainerView.scrollView.scrollEnabled = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pagerView:mainTableViewDidEndDragging:willDecelerate:)]) {
        [self.delegate pagerView:self mainTableViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isListHorizontalScrollEnabled) {
        self.listContainerView.scrollView.scrollEnabled = YES;
    }
    if ([self isSetMainScrollViewContentInsetToZeroEnabled:scrollView]) {
        if (self.mainTableView.contentInset.top != 0 && self.pinSectionHeaderVerticalOffset != 0) {
            [self adjustMainScrollViewToTargetContentInsetIfNeeded:UIEdgeInsetsZero];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pagerView:mainTableViewDidEndDecelerating:)]) {
        [self.delegate pagerView:self mainTableViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (self.isListHorizontalScrollEnabled) {
        self.listContainerView.scrollView.scrollEnabled = YES;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(pagerView:mainTableViewDidEndScrollingAnimation:)]) {
        [self.delegate pagerView:self mainTableViewDidEndScrollingAnimation:scrollView];
    }
}

#pragma mark - JXPagerListContainerViewDelegate

- (NSInteger)numberOfListsInlistContainerView:(JXPagerListContainerView *)listContainerView {
    return [self.delegate numberOfListsInPagerView:self];
}

- (id<JXPagerViewListViewDelegate>)listContainerView:(JXPagerListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    id<JXPagerViewListViewDelegate> list = self.validListDict[@(index)];
    if (list == nil) {
        list = [self.delegate pagerView:self initListAtIndex:index];
        __weak typeof(self)weakSelf = self;
        __weak typeof(id<JXPagerViewListViewDelegate>) weakList = list;
        [list listViewDidScrollCallback:^(UIScrollView *scrollView) {
            weakSelf.currentList = weakList;
            [weakSelf listViewDidScroll:scrollView];
        }];
        _validListDict[@(index)] = list;
    }
    return list;
}


- (void)listContainerViewWillBeginDragging:(JXPagerListContainerView *)listContainerView {
    self.mainTableView.scrollEnabled = NO;
}

- (void)listContainerViewWDidEndScroll:(JXPagerListContainerView *)listContainerView {
    self.mainTableView.scrollEnabled = YES;
}

- (void)listContainerView:(JXPagerListContainerView *)listContainerView listDidAppearAtIndex:(NSInteger)index {
    self.currentScrollingListView = [self.validListDict[@(index)] listScrollView];
    for (id<JXPagerViewListViewDelegate> listItem in self.validListDict.allValues) {
        if (listItem == self.validListDict[@(index)]) {
            [listItem listScrollView].scrollsToTop = YES;
        }else {
            [listItem listScrollView].scrollsToTop = NO;
        }
    }
}

- (Class)scrollViewClassInlistContainerView:(JXPagerListContainerView *)listContainerView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewClassInlistContainerViewInPagerView:)]) {
        return [self.delegate scrollViewClassInlistContainerViewInPagerView:self];
    }
    return nil;
}

@end

@implementation JXPagerView (UISubclassingGet)

- (CGFloat)mainTableViewMaxContentOffsetY {
    return [self.delegate tableHeaderViewHeightInPagerView:self] - self.pinSectionHeaderVerticalOffset;
}

@end

@implementation JXPagerView (UISubclassingHooks)

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
