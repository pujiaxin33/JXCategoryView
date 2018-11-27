//
//  JXCategoryBaseView.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryBaseView.h"
#import "JXCategoryFactory.h"

struct DelegateFlags {
    unsigned int didSelectedItemAtIndexFlag : 1;
    unsigned int didClickSelectedItemAtIndexFlag : 1;
    unsigned int didScrollSelectedItemAtIndexFlag : 1;
    unsigned int contentScrollViewTransitionToIndexFlag : 1;
    unsigned int scrollingFromLeftIndexToRightIndexFlag : 1;
};

@interface JXCategoryBaseView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) struct DelegateFlags delegateFlags;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGFloat innerCellSpacing;
@property (nonatomic, assign) CGPoint lastContentViewContentOffset;

@end

@implementation JXCategoryBaseView

- (void)dealloc
{
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (void)setDelegate:(id<JXCategoryViewDelegate>)delegate {
    _delegate = delegate;

    _delegateFlags.didSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didSelectedItemAtIndex:)];
    _delegateFlags.didClickSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didClickSelectedItemAtIndex:)];
    _delegateFlags.didScrollSelectedItemAtIndexFlag = [delegate respondsToSelector:@selector(categoryView:didScrollSelectedItemAtIndex:)];
    _delegateFlags.contentScrollViewTransitionToIndexFlag = [delegate respondsToSelector:@selector(categoryView:contentScrollViewTransitionToIndex:)];
    _delegateFlags.scrollingFromLeftIndexToRightIndexFlag = [delegate respondsToSelector:@selector(categoryView:scrollingFromLeftIndex:toRightIndex:ratio:)];
}

- (void)initializeData
{
    _dataSource = [NSMutableArray array];
    _selectedIndex = 0;
    _cellWidth = JXCategoryViewAutomaticDimension;
    _cellWidthIncrement = 0;
    _cellSpacing = 20;
    _averageCellSpacingEnabled = YES;
    _cellWidthZoomEnabled = NO;
    _cellWidthZoomScale = 1.2;
    _cellWidthZoomScrollGradientEnabled = YES;
    _contentEdgeInsetLeft = JXCategoryViewAutomaticDimension;
    _contentEdgeInsetRight = JXCategoryViewAutomaticDimension;
    _lastContentViewContentOffset = CGPointZero;
}

- (void)initializeViews
{
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        JXCategoryCollectionView *collectionView = [[JXCategoryCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        collectionView;
    });
    [self addSubview:self.collectionView];
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex
{
    _defaultSelectedIndex = defaultSelectedIndex;

    self.selectedIndex = defaultSelectedIndex;
}

- (void)setContentScrollView:(UIScrollView *)contentScrollView
{
    if (_contentScrollView != nil) {
        [_contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _contentScrollView = contentScrollView;

    [contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)reloadData {
    [self refreshDataSource];
    [self refreshState];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

- (void)reloadCellAtIndex:(NSInteger)index {
    if (index >= self.dataSource.count) {
        return;
    }
    JXCategoryBaseCellModel *cellModel = self.dataSource[index];
    [self refreshCellModel:cellModel index:index];
    JXCategoryBaseCell *cell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [cell reloadData:cellModel];
}

- (void)selectItemAtIndex:(NSInteger)index {
    [self selectCellAtIndex:index isClicked:YES];
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    [self reloadData];
}

#pragma mark - Subclass Override

- (void)refreshDataSource {

}

- (void)refreshState {
    if (self.selectedIndex >= self.dataSource.count) {
        self.selectedIndex = 0;
    }

    self.innerCellSpacing = self.cellSpacing;
    __block CGFloat totalItemWidth = [self getContentEdgeInsetLeft];
    CGFloat totalCellWidth = 0;
    for (int i = 0; i < self.dataSource.count; i++) {
        JXCategoryBaseCellModel *cellModel = self.dataSource[i];
        cellModel.index = i;
        cellModel.cellWidth = [self preferredCellWidthAtIndex:i] + self.cellWidthIncrement;
        totalCellWidth += cellModel.cellWidth;
        cellModel.cellWidthZoomEnabled = self.cellWidthZoomEnabled;
        cellModel.cellWidthZoomScale = 1.0;
        cellModel.cellSpacing = self.cellSpacing;
        if (i == self.dataSource.count - 1) {
            totalItemWidth += cellModel.cellWidth + [self getContentEdgeInsetRight];
        }else {
            totalItemWidth += cellModel.cellWidth + self.cellSpacing;
        }
        if (i == self.selectedIndex) {
            cellModel.selected = YES;
            cellModel.cellWidthZoomScale = self.cellWidthZoomScale;
        }else {
            cellModel.selected = NO;
        }
        [self refreshCellModel:cellModel index:i];
    }

    if (self.averageCellSpacingEnabled && totalItemWidth < self.bounds.size.width) {
        //如果总的内容宽度都没有超过视图度，就将cellWidth等分
        NSInteger cellSpacingItemCount = self.dataSource.count - 1;
        CGFloat totalCellSpacingWidth = self.bounds.size.width - totalCellWidth;
        //如果内容左边距是Automatic，就加1
        if (self.contentEdgeInsetLeft == JXCategoryViewAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else {
            totalCellSpacingWidth -= self.contentEdgeInsetLeft;
        }
        //如果内容右边距是Automatic，就加1
        if (self.contentEdgeInsetRight == JXCategoryViewAutomaticDimension) {
            cellSpacingItemCount += 1;
        }else {
            totalCellSpacingWidth -= self.contentEdgeInsetRight;
        }

        CGFloat cellSpacing = 0;
        if (cellSpacingItemCount > 0) {
            cellSpacing = totalCellSpacingWidth/cellSpacingItemCount;
        }
        self.innerCellSpacing = cellSpacing;
        [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryBaseCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.cellSpacing = cellSpacing;
        }];
    }

    __block CGFloat frameXOfSelectedCell = self.innerCellSpacing;
    __block CGFloat selectedCellWidth = 0;
    totalItemWidth = self.innerCellSpacing;
    [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryBaseCellModel * cellModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.selectedIndex) {
            frameXOfSelectedCell += cellModel.cellWidth + self.innerCellSpacing;
        }else if (idx == self.selectedIndex) {
            selectedCellWidth = cellModel.cellWidth;
        }
        totalItemWidth += cellModel.cellWidth + self.innerCellSpacing;
    }];

    CGFloat minX = 0;
    CGFloat maxX = totalItemWidth - self.bounds.size.width;
    CGFloat targetX = frameXOfSelectedCell - self.bounds.size.width/2.0 + selectedCellWidth/2.0;
    [self.collectionView setContentOffset:CGPointMake(MAX(MIN(maxX, targetX), minX), 0) animated:NO];

    if (CGRectEqualToRect(self.contentScrollView.frame, CGRectZero) && self.contentScrollView.superview != nil) {
        //某些情况、系统会出现JXCategoryView先布局，contentScrollView后布局。就会导致下面指定defaultSelectedIndex失效，所以发现frame为zero时，强行触发布局。
        [self.contentScrollView.superview setNeedsLayout];
        [self.contentScrollView.superview layoutIfNeeded];
    }
    [self.contentScrollView setContentOffset:CGPointMake(self.selectedIndex*self.contentScrollView.bounds.size.width, 0) animated:NO];
}

- (BOOL)selectCellAtIndex:(NSInteger)targetIndex isClicked:(BOOL)isClicked {
    return [self _selectCellAtIndex:targetIndex handleContentScrollView:YES isClicked:isClicked];
}

- (BOOL)_selectCellAtIndex:(NSInteger)targetIndex handleContentScrollView:(BOOL)handleContentScrollView isClicked:(BOOL)isClicked{
    if (targetIndex >= self.dataSource.count) {
        return NO;
    }

    if (self.selectedIndex == targetIndex) {
        if (isClicked) {
            if (self.delegateFlags.didSelectedItemAtIndexFlag) {
                [self.delegate categoryView:self didSelectedItemAtIndex:targetIndex];
            }
        }else {
            if (self.delegateFlags.didScrollSelectedItemAtIndexFlag) {
                [self.delegate categoryView:self didScrollSelectedItemAtIndex:targetIndex];
            }
        }
        return NO;
    }

    JXCategoryBaseCellModel *lastCellModel = self.dataSource[self.selectedIndex];
    JXCategoryBaseCellModel *selectedCellModel = self.dataSource[targetIndex];
    [self refreshSelectedCellModel:selectedCellModel unselectedCellModel:lastCellModel];

    JXCategoryBaseCell *lastCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    [lastCell reloadData:lastCellModel];

    JXCategoryBaseCell *selectedCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0]];
    [selectedCell reloadData:selectedCellModel];

    if (self.cellWidthZoomEnabled) {
        [self.collectionView.collectionViewLayout invalidateLayout];

        //延时为了解决cellwidth变化，点击最后几个cell，scrollToItem会出现位置偏移bug
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        });
    }else {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }

    if (handleContentScrollView) {
        if (self.delegateFlags.contentScrollViewTransitionToIndexFlag) {
            [self.delegate categoryView:self contentScrollViewTransitionToIndex:targetIndex];
        }else {
            [self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];
        }
    }

    self.selectedIndex = targetIndex;
    if (isClicked) {
        if (self.delegateFlags.didSelectedItemAtIndexFlag) {
            [self.delegate categoryView:self didSelectedItemAtIndex:targetIndex];
        }
    }else {
        if (self.delegateFlags.didScrollSelectedItemAtIndexFlag) {
            [self.delegate categoryView:self didScrollSelectedItemAtIndex:targetIndex];
        }
    }

    return YES;
}


- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    selectedCellModel.selected = YES;
    selectedCellModel.cellWidthZoomScale = self.cellWidthZoomScale;
    unselectedCellModel.selected = NO;
    unselectedCellModel.cellWidthZoomScale = 1.0;
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    if (contentOffset.x == 0 && self.selectedIndex == 0 && self.lastContentViewContentOffset.x == 0) {
        //滚动到了最左边，且已经选中了第一个，且之前的contentOffset.x为0
        return;
    }
    CGFloat maxContentOffsetX = self.contentScrollView.contentSize.width - self.contentScrollView.bounds.size.width;
    if (contentOffset.x == maxContentOffsetX && self.selectedIndex == self.dataSource.count - 1 && self.lastContentViewContentOffset.x == maxContentOffsetX) {
        //滚动到了最右边，且已经选中了最后一个，且之前的contentOffset.x为maxContentOffsetX
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;

    if (remainderRatio == 0) {
        //滑动翻页，需要更新选中状态
        //滑动一小段距离，然后放开回到原位，contentOffset同样的值会回调多次。例如在index为1的情况，滑动放开回到原位，contentOffset会多次回调CGPoint(width, 0)
        if (!(self.lastContentViewContentOffset.x == contentOffset.x && self.selectedIndex == baseIndex)) {
            [self scrollselectItemAtIndex:baseIndex];
        }
    }else {
        //快速滑动翻页，当remainderRatio没有变成0，但是已经翻页了，需要通过下面的判断，触发选中
        if (fabs(ratio - self.selectedIndex) > 1) {
            NSInteger targetIndex = baseIndex;
            if (ratio < self.selectedIndex) {
                targetIndex = baseIndex + 1;
            }
            if (self.delegateFlags.didScrollSelectedItemAtIndexFlag) {
                [self.delegate categoryView:self didScrollSelectedItemAtIndex:targetIndex];
            }
            [self _selectCellAtIndex:targetIndex handleContentScrollView:NO isClicked:NO];
        }
        if (self.cellWidthZoomEnabled && self.cellWidthZoomScrollGradientEnabled) {
            JXCategoryBaseCellModel *leftCellModel = (JXCategoryBaseCellModel *)self.dataSource[baseIndex];
            JXCategoryBaseCellModel *rightCellModel = (JXCategoryBaseCellModel *)self.dataSource[baseIndex + 1];
            leftCellModel.cellWidthZoomScale = [JXCategoryFactory interpolationFrom:self.cellWidthZoomScale to:1.0 percent:remainderRatio];
            rightCellModel.cellWidthZoomScale = [JXCategoryFactory interpolationFrom:1.0 to:self.cellWidthZoomScale percent:remainderRatio];
            [self.collectionView.collectionViewLayout invalidateLayout];
        }

        if (self.delegateFlags.scrollingFromLeftIndexToRightIndexFlag) {
            [self.delegate categoryView:self scrollingFromLeftIndex:baseIndex toRightIndex:baseIndex + 1 ratio:remainderRatio];
        }
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    return 0;
}

- (Class)preferredCellClass {
    return JXCategoryBaseCell.class;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {

}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    JXCategoryBaseCell *categoryCell = (JXCategoryBaseCell *)cell;
    [categoryCell reloadData:self.dataSource[indexPath.item]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self clickselectItemAtIndex:indexPath.row];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, [self getContentEdgeInsetLeft], 0, [self getContentEdgeInsetRight]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXCategoryBaseCellModel *cellModel = self.dataSource[indexPath.item];
    return CGSizeMake(cellModel.cellWidth, self.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.innerCellSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.innerCellSpacing;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if ((self.contentScrollView.isTracking || self.contentScrollView.isDecelerating)) {
            //用户滚动引起的contentOffset变化，才处理。
            [self contentOffsetOfContentScrollViewDidChanged:contentOffset];
        }
        self.lastContentViewContentOffset = contentOffset;
    }
}

#pragma mark - Other

- (CGRect)getTargetCellFrame:(NSInteger)targetIndex
{
    CGFloat x = [self getContentEdgeInsetLeft];
    for (int i = 0; i < targetIndex; i ++) {
        JXCategoryBaseCellModel *cellModel = self.dataSource[i];
        x += cellModel.cellWidth + self.innerCellSpacing;
    }
    CGFloat width = self.dataSource[targetIndex].cellWidth;
    return CGRectMake(x, 0, width, self.bounds.size.height);
}

#pragma mark - Private

- (CGFloat)getContentEdgeInsetLeft {
    if (self.contentEdgeInsetLeft == JXCategoryViewAutomaticDimension) {
        return self.innerCellSpacing;
    }
    return self.contentEdgeInsetLeft;
}

- (CGFloat)getContentEdgeInsetRight {
    if (self.contentEdgeInsetRight == JXCategoryViewAutomaticDimension) {
        return self.innerCellSpacing;
    }
    return self.contentEdgeInsetRight;
}

- (void)clickselectItemAtIndex:(NSInteger)index {
    [self selectCellAtIndex:index isClicked:YES];
}

- (void)scrollselectItemAtIndex:(NSInteger)index {
    [self selectCellAtIndex:index isClicked:NO];
}

@end
