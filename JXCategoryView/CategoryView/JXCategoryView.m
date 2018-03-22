//
//  JXCategoryView.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryView.h"
#import "JXCategoryCell.h"
#import "JXCategoryCellModel.h"
#import "UIColor+JXAdd.h"
#import "JXCategoryCollectionView.h"

const CGFloat JXCategoryViewIndicatorLineWidthAutomaticDimension = -1;
static const NSInteger JXCategoryViewClickedIndexUnknown = -1;

@interface JXCategoryView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) JXCategoryCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <JXCategoryCellModel *>*dataSource;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) NSInteger clickedItemIndex;
@property (nonatomic, strong) CAShapeLayer *ellipseLayer;

@end

@implementation JXCategoryView

- (void)dealloc
{
    [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeDatas];
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeDatas];
        [self initializeViews];
    }
    return self;
}

- (void)initializeDatas
{
    _dataSource = [NSMutableArray array];
    _titleColor = [UIColor greenColor];
    _titleSelectedColor = [UIColor redColor];
    _titleFontSize = 12.0;
    _selectedIndex = 0;
    _indicatorLineColor = [UIColor blueColor];
    _lineHeight = 2;
    _indicatorLineWidth = JXCategoryViewIndicatorLineWidthAutomaticDimension;
    _minimumInteritemSpacing = 10;
    _indicatorViewScrollEnabled = YES;
    _clickedItemIndex = JXCategoryViewClickedIndexUnknown;
    _zoomEnabled = NO;
    _zoomScale = 1.1;
    _titleColorGradientEnabled = YES;
    _indicatorLineViewShowEnabled = YES;
    _backEllipseLayerHeight = 30.0;
    _backEllipseLayerShowEnabled = NO;
}

- (void)initializeViews
{
    self.backgroundColor = [UIColor lightGrayColor];
    JXCategoryCollectionView *collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        JXCategoryCollectionView *collectionView = [[JXCategoryCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[JXCategoryCell class] forCellWithReuseIdentifier:NSStringFromClass([JXCategoryCell class])];
        collectionView;
    });
    self.collectionView = collectionView;
    [self addSubview:collectionView];
    
    self.lineView = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = self.indicatorLineColor;
        view;
    });
    [self.collectionView insertSubview:self.lineView atIndex:0];

    _ellipseLayer = [CAShapeLayer layer];
    _ellipseLayer.fillColor = [UIColor yellowColor].CGColor;
    [self.collectionView.layer insertSublayer:_ellipseLayer atIndex:0];
    self.collectionView.backEllipseLayer = _ellipseLayer;
}

- (void)setindicatorLineColor:(UIColor *)indicatorLineColor {
    _indicatorLineColor = indicatorLineColor;

    self.lineView.backgroundColor = indicatorLineColor;
}

- (void)setBackEllipseLayerFillColor:(UIColor *)backEllipseLayerFillColor
{
    _backEllipseLayerFillColor = backEllipseLayerFillColor;

    _ellipseLayer.fillColor = backEllipseLayerFillColor.CGColor;
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex
{
    _defaultSelectedIndex = defaultSelectedIndex;

    _selectedIndex = defaultSelectedIndex;
}

- (void)setContentScrollView:(UIScrollView *)contentScrollView
{
    _contentScrollView = contentScrollView;

    [contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)reloadDatas {
    if (self.titles.count == 0) {
        return;
    }
    [self.dataSource removeAllObjects];

    CGFloat totalItemWidth = 0;
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryCellModel *cellModel = [[JXCategoryCellModel alloc] init];
        cellModel.title = self.titles[i];
        cellModel.titleFontSize = self.titleFontSize;
        cellModel.titleColor = self.titleColor;
        cellModel.titleSelectedColor = self.titleSelectedColor;
        cellModel.zoomScale = 1.0;
        if (i == self.selectedIndex) {
            cellModel.selected = YES;
            if (self.zoomEnabled) {
                cellModel.zoomScale = self.zoomScale;
            }
        }
        cellModel.cellWidth = ceilf([self.titles[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:self.titleFontSize]} context:nil].size.width) + 10;
        totalItemWidth += cellModel.cellWidth;
        [self.dataSource addObject:cellModel];
    }
    if ((totalItemWidth + self.minimumInteritemSpacing*(self.dataSource.count + 1)) < self.bounds.size.width) {
        CGFloat compensationWidth = (self.bounds.size.width - totalItemWidth - (self.dataSource.count + 1)*self.minimumInteritemSpacing)*1.0/self.dataSource.count;
        [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.cellWidth += compensationWidth;
        }];
    }

    [self.collectionView reloadData];
    [self.contentScrollView setContentOffset:CGPointMake(self.selectedIndex*self.contentScrollView.bounds.size.width, 0) animated:NO];

    self.lineView.hidden = !self.indicatorLineViewShowEnabled;
    self.ellipseLayer.hidden = !self.backEllipseLayerShowEnabled;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.collectionView.frame = self.bounds;
    CGFloat frameX = 0;
    for (int i = 0; i <= self.selectedIndex; i ++) {
        JXCategoryCellModel *cellModel = self.dataSource[i];
        if (i == self.selectedIndex) {
            frameX += cellModel.cellWidth/2.0 - [self getLineWithWithIndex:self.selectedIndex]/2.0 ;
        }else {
            frameX += cellModel.cellWidth + _minimumInteritemSpacing;
        }
    }
    self.lineView.frame = CGRectMake(frameX + _minimumInteritemSpacing, self.bounds.size.height - self.lineHeight, [self getLineWithWithIndex:self.selectedIndex], self.lineHeight);
    self.ellipseLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(frameX + _minimumInteritemSpacing, (self.bounds.size.height - self.backEllipseLayerHeight)/2.0, [self getLineWithWithIndex:self.selectedIndex], self.backEllipseLayerHeight) cornerRadius:self.backEllipseLayerHeight/2].CGPath;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JXCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JXCategoryCell class]) forIndexPath:indexPath];
    return cell;;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    JXCategoryCell *categoryCell = (JXCategoryCell *)cell;
    categoryCell.cellModel = self.dataSource[indexPath.item];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.clickedItemIndex = indexPath.item;
    [self selectedTargetCellWithIndex:indexPath.item];
    [self.contentScrollView setContentOffset:CGPointMake(indexPath.item*self.contentScrollView.bounds.size.width, 0) animated:YES];

    UICollectionViewCell *clickedCell = [collectionView cellForItemAtIndexPath:indexPath];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(self.ellipseLayer.path);
    UIBezierPath *toPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(clickedCell.frame.origin.x, (self.bounds.size.height - self.backEllipseLayerHeight)/2.0, clickedCell.bounds.size.width, self.backEllipseLayerHeight) cornerRadius:self.backEllipseLayerHeight/2];
    animation.toValue = (__bridge id _Nullable)toPath.CGPath;
    animation.duration = 0.3;
    [self.ellipseLayer addAnimation:animation forKey:@"move"];
    self.ellipseLayer.path = toPath.CGPath;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.lineView.frame;
        frame.size.width = clickedCell.bounds.size.width;
        self.lineView.frame = frame;
        CGPoint center = self.lineView.center;
        center.x = clickedCell.center.x;
        self.lineView.center = center;
//        下面的方案会让将要滚出屏幕的cell因为重用机制立马消失，如果用该方案，需要用UIScrollView
//        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }];

}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXCategoryCellModel *cellModel = self.dataSource[indexPath.item];
    return CGSizeMake(cellModel.cellWidth, self.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.minimumInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, _minimumInteritemSpacing, 0, _minimumInteritemSpacing);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{

    if ([keyPath isEqualToString:@"contentOffset"] && (self.contentScrollView.isDragging || self.contentScrollView.isDecelerating)) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
        //限制最大最小
        ratio = MAX(0, MIN(self.titles.count - 1, ratio));
        NSInteger baseIndex = floorf(ratio);
        CGFloat remainderRatio = ratio - baseIndex;
        CGFloat totalX = 0;
        CGFloat targetindicatorLineWidth = [self getLineWithWithIndex:baseIndex];
        CGFloat targetCellWidth = 0;

        if (remainderRatio == 0) {
            CGRect cellFrame = [self getTargetCellFrame:baseIndex];
            totalX = cellFrame.origin.x + cellFrame.size.width/2.0;
            totalX -= targetindicatorLineWidth/2.0;
            targetCellWidth = cellFrame.size.width;
            [self selectedTargetCellWithIndex:baseIndex];
        }else {

            JXCategoryCellModel *leftCellModel = self.dataSource[baseIndex];
            JXCategoryCellModel *rightCellModel = self.dataSource[baseIndex + 1];
            //处理颜色渐变
            if (self.titleColorGradientEnabled) {
                if (leftCellModel.selected) {
                    leftCellModel.titleSelectedColor = [self interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:remainderRatio];
                }else {
                    leftCellModel.titleColor = [self interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:remainderRatio];
                }
                if (rightCellModel.selected) {
                    rightCellModel.titleSelectedColor = [self interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:remainderRatio];
                }else {
                    rightCellModel.titleColor = [self interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:remainderRatio];
                }
            }
            //处理缩放
            if (self.zoomEnabled) {
                leftCellModel.zoomScale = [self interpolationFrom:self.zoomScale to:1.0 percent:remainderRatio];
                rightCellModel.zoomScale = [self interpolationFrom:1.0 to:self.zoomScale percent:remainderRatio];
            }

            JXCategoryCell *leftCell = (JXCategoryCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex inSection:0]];
            [leftCell refreshUI];

            JXCategoryCell *rightCell = (JXCategoryCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex + 1 inSection:0]];
            [rightCell refreshUI];

            CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];
            CGRect rightCellFrame = [self getTargetCellFrame:baseIndex+1];

            totalX = [self interpolationFrom:(leftCellFrame.origin.x + leftCellFrame.size.width/2.0) to:(rightCellFrame.origin.x + rightCellFrame.size.width/2.0) percent:remainderRatio];
            if (self.indicatorLineWidth == JXCategoryViewIndicatorLineWidthAutomaticDimension) {
                targetindicatorLineWidth = [self interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:remainderRatio];
            }
            totalX -= targetindicatorLineWidth/2.0;
            targetCellWidth = [self interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:remainderRatio];
        }

        if (self.indicatorViewScrollEnabled == YES ||
            (self.indicatorViewScrollEnabled == NO && remainderRatio == 0)) {
            self.ellipseLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(totalX, (self.bounds.size.height - self.backEllipseLayerHeight)/2.0, targetCellWidth, self.backEllipseLayerHeight) cornerRadius:self.backEllipseLayerHeight/2].CGPath;

            CGRect frame = self.lineView.frame;
            frame.origin.x = totalX;
            frame.size.width = targetindicatorLineWidth;
            self.lineView.frame = frame;
        }
    }
}

#pragma mark - Private

- (void)selectedTargetCellWithIndex:(NSInteger)targetIndex
{
    if (targetIndex == self.selectedIndex) {
        return;
    }

    JXCategoryCell *lastCell = (JXCategoryCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    JXCategoryCellModel *lastCellModel = self.dataSource[self.selectedIndex];
    lastCellModel.selected = NO;
    lastCellModel.titleColor = self.titleColor;
    lastCellModel.titleSelectedColor = self.titleSelectedColor;
    lastCellModel.zoomScale = 1.0;
    [lastCell refreshUI];

    JXCategoryCell *cell = (JXCategoryCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0]];
    JXCategoryCellModel *cellModel = self.dataSource[targetIndex];
    cellModel.selected = YES;
    cellModel.titleColor = self.titleColor;
    cellModel.titleSelectedColor = self.titleSelectedColor;
    cellModel.zoomScale = 1.0;
    if (self.zoomEnabled) {
        cellModel.zoomScale = self.zoomScale;
    }
    [cell refreshUI];

    self.selectedIndex = targetIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    self.clickedItemIndex = JXCategoryViewClickedIndexUnknown;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:didSelectedItemAtIndex:)]) {
        [self.delegate categoryView:self didSelectedItemAtIndex:targetIndex];
    }
}

- (CGFloat)getLineWithWithIndex:(NSInteger)index
{
    if (_indicatorLineWidth == JXCategoryViewIndicatorLineWidthAutomaticDimension) {
        JXCategoryCellModel *cellModel = self.dataSource[index];
        return cellModel.cellWidth;
    }
    return _indicatorLineWidth;
}

- (CGRect)getTargetCellFrame:(NSInteger)targetIndex
{
    CGFloat x = 0;
    for (int i = 0; i < targetIndex; i ++) {
        JXCategoryCellModel *cellModel = self.dataSource[i];
        x += cellModel.cellWidth + self.minimumInteritemSpacing;
    }
    CGFloat width = [(JXCategoryCellModel *)self.dataSource[targetIndex] cellWidth];
    return CGRectMake(x + self.minimumInteritemSpacing, 0, width, self.bounds.size.height);
}

- (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent
{
    percent = MAX(0, MIN(1, percent));
    return from + (to - from)*percent;
}

- (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat red = [self interpolationFrom:fromColor.red to:toColor.red percent:percent];
    CGFloat green = [self interpolationFrom:fromColor.green to:toColor.green percent:percent];
    CGFloat blue = [self interpolationFrom:fromColor.blue to:toColor.blue percent:percent];
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];

}

@end
