//
//  JXCategoryComponentView.m
//  DQGuess
//
//  Created by jiaxin on 2018/7/25.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryComponentView.h"
#import "JXCategoryComponentCellModel.h"
#import "JXCategoryComponentCell.h"

@interface JXCategoryComponentView()

@property (nonatomic, strong) UIView *backgroundContainerView;
@property (nonatomic, strong) UIView *indicatorLineView;
@property (nonatomic, strong) CALayer *backEllipseLayer;

@end

@implementation JXCategoryComponentView

- (void)initializeDatas {
    [super initializeDatas];

    _indicatorLineViewHeight = 3;
    _indicatorLineWidth = JXCategoryViewAutomaticDimension;
    _indicatorViewScrollEnabled = YES;
    _indicatorLineViewColor = [UIColor redColor];
    _zoomEnabled = NO;
    _zoomScale = 1.2;
    _indicatorLineViewShowEnabled = YES;
    _backEllipseLayerWidth = JXCategoryViewAutomaticDimension;
    _backEllipseLayerHeight = 20;
    _backEllipseLayerCornerRadius = JXCategoryViewAutomaticDimension;
    _backEllipseLayerShowEnabled = NO;
    _separatorLineShowEnabled = NO;
    _backEllipseLayerColor = [UIColor lightGrayColor];
    _indicatorViewPanGestureManualEnabled = NO;
}

- (void)initializeViews {
    [super initializeViews];

    self.backgroundContainerView = [[UIView alloc] init];
    self.backgroundContainerView.backgroundColor = [UIColor clearColor];
    [self.collectionView insertSubview:self.backgroundContainerView atIndex:0];
    self.collectionView.backgroundContainerView = self.backgroundContainerView;

    self.indicatorLineView = [[UIView alloc] init];
    [self.collectionView insertSubview:self.indicatorLineView atIndex:0];

    self.backEllipseLayer = [CALayer layer];
    [self.backgroundContainerView.layer addSublayer:self.backEllipseLayer];
}

- (void)refreshState {
    [super refreshState];

    CGRect selectedCellFrame = CGRectZero;
    for (int i = 0; i < self.dataSource.count; i++) {
        JXCategoryComponentCellModel *cellModel = (JXCategoryComponentCellModel *)self.dataSource[i];
        cellModel.zoomEnabled = self.zoomEnabled;
        cellModel.zoomScale = 1.0;
        cellModel.sepratorLineShowEnabled = self.separatorLineShowEnabled;
        if (i == self.dataSource.count - 1) {
            cellModel.sepratorLineShowEnabled = NO;
        }
        if (i == self.selectedIndex) {
            cellModel.selected = YES;
            cellModel.zoomScale = self.zoomScale;
            selectedCellFrame = [self getTargetCellFrame:i];
        }
    }

    self.backgroundContainerView.frame = selectedCellFrame;

    __block CGFloat frameXOfLineView = self.cellSpacing;
    __block CGFloat frameXOfBackEllipseLayer = self.cellSpacing;
    [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryBaseCellModel * cellModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.selectedIndex) {
            frameXOfLineView += cellModel.cellWidth + self.cellSpacing;
            frameXOfBackEllipseLayer += cellModel.cellWidth + self.cellSpacing;
        }else if (idx == self.selectedIndex) {
            frameXOfLineView += (cellModel.cellWidth - [self getLineWidthWithIndex:self.selectedIndex])/2.0 ;
            frameXOfBackEllipseLayer += (cellModel.cellWidth - [self getBackEllipseLayerWidthWithIndex:idx])/2.0;
        }
    }];

    self.indicatorLineView.hidden = !self.indicatorLineViewShowEnabled;
    self.indicatorLineView.backgroundColor = self.indicatorLineViewColor;
    self.indicatorLineView.layer.cornerRadius = _indicatorLineViewHeight/2;
    self.indicatorLineView.frame = CGRectMake(frameXOfLineView, self.bounds.size.height - self.indicatorLineViewHeight, [self getLineWidthWithIndex:self.selectedIndex], self.indicatorLineViewHeight);

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.backEllipseLayer.hidden = !self.backEllipseLayerShowEnabled;
    self.backEllipseLayer.cornerRadius = [self getBackEllipseLayerCornerRadius];
    self.backEllipseLayer.backgroundColor = _backEllipseLayerColor.CGColor;
    self.backEllipseLayer.frame = CGRectMake((selectedCellFrame.size.width - [self getBackEllipseLayerWidthWithIndex:self.selectedIndex])/2, (selectedCellFrame.size.height - self.backEllipseLayerHeight)/2, [self getBackEllipseLayerWidthWithIndex:self.selectedIndex], self.backEllipseLayerHeight);
    [CATransaction commit];

    if (self.dataSource.count <= 1) {
        self.indicatorLineView.hidden = YES;
        self.backEllipseLayer.hidden = YES;
    }
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    JXCategoryComponentCellModel *myUnselectedCellModel = (JXCategoryComponentCellModel *)unselectedCellModel;
    myUnselectedCellModel.zoomScale = 1.0;

    JXCategoryComponentCellModel *myselectedCellModel = (JXCategoryComponentCellModel *)selectedCellModel;
    myselectedCellModel.zoomScale = self.zoomScale;
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    [super contentOffsetOfContentScrollViewDidChanged:contentOffset];
    
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;

    CGFloat totalXOfIndicatorLineView = self.cellSpacing;
    CGFloat targetindicatorLineWidth = [self getLineWidthWithIndex:baseIndex];
    CGFloat totalXOfBackEllipseLayer = self.cellSpacing;
    CGFloat targetBackEllipseLayerWidth = [self getBackEllipseLayerWidthWithIndex:baseIndex];

    CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];

    CGFloat backgroundContainerViewX = leftCellFrame.origin.x;
    CGFloat backgroundContainerViewWidth = leftCellFrame.size.width;

    if (remainderRatio == 0) {
        totalXOfIndicatorLineView = leftCellFrame.origin.x + (leftCellFrame.size.width - targetindicatorLineWidth)/2.0;
        totalXOfBackEllipseLayer = leftCellFrame.origin.x + (leftCellFrame.size.width - targetBackEllipseLayerWidth)/2.0;
        [super selectItemWithIndex:baseIndex];
    }else {
        JXCategoryComponentCellModel *leftCellModel = (JXCategoryComponentCellModel *)self.dataSource[baseIndex];
        JXCategoryComponentCellModel *rightCellModel = (JXCategoryComponentCellModel *)self.dataSource[baseIndex + 1];

        if (self.zoomEnabled) {
            leftCellModel.zoomScale = [self interpolationFrom:self.zoomScale to:1.0 percent:remainderRatio];
            rightCellModel.zoomScale = [self interpolationFrom:1.0 to:self.zoomScale percent:remainderRatio];
        }

        [self refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:remainderRatio];

        JXCategoryBaseCell *leftCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex inSection:0]];
        [leftCell reloadDatas:leftCellModel];

        JXCategoryBaseCell *rightCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex + 1 inSection:0]];
        [rightCell reloadDatas:rightCellModel];


        CGRect rightCellFrame = [self getTargetCellFrame:baseIndex+1];

        CGFloat leftXOfIndicatorLineView = leftCellFrame.origin.x + (leftCellFrame.size.width - targetindicatorLineWidth)/2;
        CGFloat rightXOfIndicatorLineView = rightCellFrame.origin.x + (rightCellFrame.size.width - [self getLineWidthWithIndex:baseIndex + 1])/2;
        totalXOfIndicatorLineView = [self interpolationFrom:leftXOfIndicatorLineView to:rightXOfIndicatorLineView percent:remainderRatio];

        CGFloat leftXOfBackEllipseLayer = leftCellFrame.origin.x + (leftCellFrame.size.width - targetBackEllipseLayerWidth)/2;
        CGFloat rightXOfBackEllipseLayer = rightCellFrame.origin.x + (rightCellFrame.size.width - [self getBackEllipseLayerWidthWithIndex:baseIndex + 1])/2;
        totalXOfBackEllipseLayer = [self interpolationFrom:leftXOfBackEllipseLayer to:rightXOfBackEllipseLayer percent:remainderRatio];

        backgroundContainerViewX = [self interpolationFrom:leftCellFrame.origin.x to:rightCellFrame.origin.x percent:remainderRatio];
        backgroundContainerViewWidth = [self interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:remainderRatio];

        if (self.indicatorLineWidth == JXCategoryViewAutomaticDimension) {
            targetindicatorLineWidth = [self interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:remainderRatio];
        }
        if (self.backEllipseLayerWidth == JXCategoryViewAutomaticDimension) {
            targetBackEllipseLayerWidth = [self interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:remainderRatio];
        }
    }

    if ((self.indicatorViewScrollEnabled == YES ||
        (self.indicatorViewScrollEnabled == NO && remainderRatio == 0)) &&
        !self.indicatorViewPanGestureManualEnabled) {

        self.backgroundContainerView.frame = CGRectMake(backgroundContainerViewX, 0, backgroundContainerViewWidth, leftCellFrame.size.height);

        [CATransaction begin];
        [CATransaction setDisableActions:true];
        self.backEllipseLayer.frame = CGRectMake((backgroundContainerViewWidth - targetBackEllipseLayerWidth)/2, (leftCellFrame.size.height - self.backEllipseLayerHeight)/2, targetBackEllipseLayerWidth, self.backEllipseLayerHeight);
        [CATransaction commit];

        CGRect frame = self.indicatorLineView.frame;
        frame.origin.x = totalXOfIndicatorLineView;
        frame.size.width = targetindicatorLineWidth;
        self.indicatorLineView.frame = frame;
    }
}

- (BOOL)selectItemWithIndex:(NSInteger)index {
    BOOL result = [super selectItemWithIndex:index];
    if (!result) {
        return NO;
    }

    CGRect clickedCellFrame = [self getTargetCellFrame:index];

    CGFloat targetLineWidth = [self getLineWidthWithIndex:index];
    CGRect lineToFrame = CGRectMake(clickedCellFrame.origin.x + (clickedCellFrame.size.width - targetLineWidth)/2.0, self.bounds.size.height - _indicatorLineViewHeight, targetLineWidth, _indicatorLineViewHeight);

    CGFloat targetEllipseLayerWidth = [self getBackEllipseLayerWidthWithIndex:index];
    CGRect ellipseLayerToFrame = CGRectMake((clickedCellFrame.size.width - targetEllipseLayerWidth)/2, (clickedCellFrame.size.height - self.backEllipseLayerHeight)/2, targetEllipseLayerWidth, self.backEllipseLayerHeight);

    if (self.indicatorViewScrollEnabled) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.25];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        self.backEllipseLayer.frame = ellipseLayerToFrame;
        [CATransaction commit];

        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.indicatorLineView.frame = lineToFrame;
            self.backgroundContainerView.frame = clickedCellFrame;
        } completion:^(BOOL finished) {
        }];
    }else {
        self.backgroundContainerView.frame = clickedCellFrame;
        self.indicatorLineView.frame = lineToFrame;
        [CATransaction begin];
        [CATransaction setDisableActions:true];
        self.backEllipseLayer.frame = ellipseLayerToFrame;
        [CATransaction commit];
    }
    return YES;
}

- (CGFloat)getLineWidthWithIndex:(NSInteger)index
{
    if (self.dataSource.count == 0) {
        return 0;
    }
    if (_indicatorLineWidth == JXCategoryViewAutomaticDimension) {
        JXCategoryBaseCellModel *cellModel = self.dataSource[index];
        return cellModel.cellWidth;
    }
    return _indicatorLineWidth;
}

- (CGFloat)getBackEllipseLayerWidthWithIndex:(NSInteger)index
{
    if (self.dataSource.count == 0) {
        return 0;
    }
    if (_backEllipseLayerWidth == JXCategoryViewAutomaticDimension) {
        JXCategoryBaseCellModel *cellModel = self.dataSource[index];
        return cellModel.cellWidth;
    }
    return _backEllipseLayerWidth;
}

- (CGFloat)getBackEllipseLayerCornerRadius {
    if (_backEllipseLayerCornerRadius == JXCategoryViewAutomaticDimension) {
        return _backEllipseLayerHeight/2;
    }
    return _backEllipseLayerCornerRadius;
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    
}

@end
