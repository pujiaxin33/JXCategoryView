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
@property (nonatomic, strong) CALayer *backgroundEllipseLayer;

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
    _backgroundEllipseLayerWidth = JXCategoryViewAutomaticDimension;
    _backgroundEllipseLayerHeight = 20;
    _backgroundEllipseLayerCornerRadius = JXCategoryViewAutomaticDimension;
    _backgroundEllipseLayerShowEnabled = NO;
    _separatorLineShowEnabled = NO;
    _backgroundEllipseLayerColor = [UIColor lightGrayColor];
    _indicatorViewPanGestureManualEnabled = NO;
    _separatorLineColor = [UIColor lightGrayColor];
    _separatorLineSize = CGSizeMake(1/[UIScreen mainScreen].scale, 20);
    _indicatorImageViewShowEnabled = NO;
    _indicatorImageViewSize = CGSizeMake(30, 20);
    _indicatorImageViewRollEnabled = NO;
}

- (void)initializeViews {
    [super initializeViews];

    self.backgroundContainerView = [[UIView alloc] init];
    self.backgroundContainerView.backgroundColor = [UIColor clearColor];
    [self.collectionView insertSubview:self.backgroundContainerView atIndex:0];
    self.collectionView.backgroundContainerView = self.backgroundContainerView;

    self.indicatorLineView = [[UIView alloc] init];
    [self.collectionView insertSubview:self.indicatorLineView atIndex:0];

    _indicatorImageView = [[UIImageView alloc] init];
    self.indicatorImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.indicatorImageView.hidden = !self.indicatorImageViewShowEnabled;
    self.indicatorImageView.bounds = CGRectMake(0, 0, self.indicatorImageViewSize.width, self.indicatorImageViewSize.height);
    [self.collectionView insertSubview:self.indicatorImageView atIndex:0];

    self.backgroundEllipseLayer = [CALayer layer];
    [self.backgroundContainerView.layer addSublayer:self.backgroundEllipseLayer];
}

- (void)refreshState {
    [super refreshState];

    CGRect selectedCellFrame = CGRectZero;
    for (int i = 0; i < self.dataSource.count; i++) {
        JXCategoryComponentCellModel *cellModel = (JXCategoryComponentCellModel *)self.dataSource[i];
        cellModel.zoomEnabled = self.zoomEnabled;
        cellModel.zoomScale = 1.0;
        cellModel.sepratorLineShowEnabled = self.separatorLineShowEnabled;
        cellModel.separatorLineColor = self.separatorLineColor;
        cellModel.separatorLineSize = self.separatorLineSize;
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

    __block CGFloat lineViewX = self.cellSpacing;
    __block CGFloat backgroundEllipseLayerX = self.cellSpacing;
    [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryBaseCellModel * cellModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.selectedIndex) {
            lineViewX += cellModel.cellWidth + self.cellSpacing;
            backgroundEllipseLayerX += cellModel.cellWidth + self.cellSpacing;
        }else if (idx == self.selectedIndex) {
            lineViewX += (cellModel.cellWidth - [self getLineWidthWithIndex:self.selectedIndex])/2.0 ;
            backgroundEllipseLayerX += (cellModel.cellWidth - [self getbackgroundEllipseLayerWidthWithIndex:idx])/2.0;
        }
    }];

    self.indicatorLineView.hidden = !self.indicatorLineViewShowEnabled;
    self.indicatorLineView.backgroundColor = self.indicatorLineViewColor;
    self.indicatorLineView.layer.cornerRadius = self.indicatorLineViewHeight/2;
    self.indicatorLineView.frame = CGRectMake(lineViewX, self.bounds.size.height - self.indicatorLineViewHeight, [self getLineWidthWithIndex:self.selectedIndex], self.indicatorLineViewHeight);

    self.indicatorImageView.hidden = !self.indicatorImageViewShowEnabled;
    self.indicatorImageView.center = CGPointMake(self.indicatorLineView.center.x, self.bounds.size.height - self.indicatorImageViewSize.height/2);

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.backgroundEllipseLayer.hidden = !self.backgroundEllipseLayerShowEnabled;
    self.backgroundEllipseLayer.cornerRadius = [self getbackgroundEllipseLayerCornerRadius];
    self.backgroundEllipseLayer.backgroundColor = self.backgroundEllipseLayerColor.CGColor;
    self.backgroundEllipseLayer.frame = CGRectMake((selectedCellFrame.size.width - [self getbackgroundEllipseLayerWidthWithIndex:self.selectedIndex])/2, (selectedCellFrame.size.height - self.backgroundEllipseLayerHeight)/2, [self getbackgroundEllipseLayerWidthWithIndex:self.selectedIndex], self.backgroundEllipseLayerHeight);
    [CATransaction commit];

    if (self.dataSource.count <= 1) {
        self.indicatorLineView.hidden = YES;
        self.backgroundEllipseLayer.hidden = YES;
        self.indicatorImageView.hidden = YES;
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

    CGFloat indicatorLineViewX = self.cellSpacing;
    CGFloat targetIndicatorLineWidth = [self getLineWidthWithIndex:baseIndex];
    CGFloat backgroundEllipseLayerX = self.cellSpacing;
    CGFloat targetBackgroundEllipseLayerWidth = [self getbackgroundEllipseLayerWidthWithIndex:baseIndex];

    CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];

    CGFloat backgroundContainerViewX = leftCellFrame.origin.x;
    CGFloat backgroundContainerViewWidth = leftCellFrame.size.width;

    if (remainderRatio == 0) {
        indicatorLineViewX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetIndicatorLineWidth)/2.0;
        backgroundEllipseLayerX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetBackgroundEllipseLayerWidth)/2.0;
        [super selectItemWithIndex:baseIndex];
    }else {
        JXCategoryComponentCellModel *leftCellModel = (JXCategoryComponentCellModel *)self.dataSource[baseIndex];
        JXCategoryComponentCellModel *rightCellModel = (JXCategoryComponentCellModel *)self.dataSource[baseIndex + 1];

        if (self.zoomEnabled) {
            leftCellModel.zoomScale = [self interpolationFrom:self.zoomScale to:1.0 percent:remainderRatio];
            rightCellModel.zoomScale = [self interpolationFrom:1.0 to:self.zoomScale percent:remainderRatio];
        }

        [self refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:remainderRatio];
        if ([self.delegate respondsToSelector:@selector(categoryView:scrollingFromLeftIndex:toRightIndex:ratio:)]) {
            [self.delegate categoryView:self scrollingFromLeftIndex:baseIndex toRightIndex:baseIndex + 1 ratio:remainderRatio];
        }

        JXCategoryBaseCell *leftCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex inSection:0]];
        [leftCell reloadDatas:leftCellModel];

        JXCategoryBaseCell *rightCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex + 1 inSection:0]];
        [rightCell reloadDatas:rightCellModel];


        CGRect rightCellFrame = [self getTargetCellFrame:baseIndex+1];

        CGFloat leftXOfIndicatorLineView = leftCellFrame.origin.x + (leftCellFrame.size.width - targetIndicatorLineWidth)/2;
        CGFloat rightXOfIndicatorLineView = rightCellFrame.origin.x + (rightCellFrame.size.width - [self getLineWidthWithIndex:baseIndex + 1])/2;
        indicatorLineViewX = [self interpolationFrom:leftXOfIndicatorLineView to:rightXOfIndicatorLineView percent:remainderRatio];

        CGFloat leftXOfbackgroundEllipseLayer = leftCellFrame.origin.x + (leftCellFrame.size.width - targetBackgroundEllipseLayerWidth)/2;
        CGFloat rightXOfbackgroundEllipseLayer = rightCellFrame.origin.x + (rightCellFrame.size.width - [self getbackgroundEllipseLayerWidthWithIndex:baseIndex + 1])/2;
        backgroundEllipseLayerX = [self interpolationFrom:leftXOfbackgroundEllipseLayer to:rightXOfbackgroundEllipseLayer percent:remainderRatio];

        backgroundContainerViewX = [self interpolationFrom:leftCellFrame.origin.x to:rightCellFrame.origin.x percent:remainderRatio];
        backgroundContainerViewWidth = [self interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:remainderRatio];

        if (self.indicatorLineWidth == JXCategoryViewAutomaticDimension) {
            targetIndicatorLineWidth = [self interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:remainderRatio];
        }
        if (self.backgroundEllipseLayerWidth == JXCategoryViewAutomaticDimension) {
            targetBackgroundEllipseLayerWidth = [self interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:remainderRatio];
        }
    }

    if ((self.indicatorViewScrollEnabled == YES ||
        (self.indicatorViewScrollEnabled == NO && remainderRatio == 0)) &&
        !self.indicatorViewPanGestureManualEnabled) {

        self.backgroundContainerView.frame = CGRectMake(backgroundContainerViewX, 0, backgroundContainerViewWidth, leftCellFrame.size.height);

        [CATransaction begin];
        [CATransaction setDisableActions:true];
        self.backgroundEllipseLayer.frame = CGRectMake((backgroundContainerViewWidth - targetBackgroundEllipseLayerWidth)/2, (leftCellFrame.size.height - self.backgroundEllipseLayerHeight)/2, targetBackgroundEllipseLayerWidth, self.backgroundEllipseLayerHeight);
        [CATransaction commit];

        CGRect frame = self.indicatorLineView.frame;
        frame.origin.x = indicatorLineViewX;
        frame.size.width = targetIndicatorLineWidth;
        self.indicatorLineView.frame = frame;

        self.indicatorImageView.center = CGPointMake(self.indicatorLineView.center.x, self.bounds.size.height - self.indicatorImageViewSize.height/2);
        if (self.indicatorImageViewRollEnabled) {
            self.indicatorImageView.transform = CGAffineTransformMakeRotation(M_PI*2*remainderRatio);
        }
    }
}

- (BOOL)selectItemWithIndex:(NSInteger)index {
    BOOL result = [super selectItemWithIndex:index];
    if (!result) {
        return NO;
    }

    CGRect clickedCellFrame = [self getTargetCellFrame:index];

    CGFloat targetLineWidth = [self getLineWidthWithIndex:index];
    CGRect lineViewToFrame = CGRectMake(clickedCellFrame.origin.x + (clickedCellFrame.size.width - targetLineWidth)/2.0, self.bounds.size.height - self.indicatorLineViewHeight, targetLineWidth, self.indicatorLineViewHeight);

    CGFloat targetBackgroundEllipseLayerWidth = [self getbackgroundEllipseLayerWidthWithIndex:index];
    CGRect backgroundEllipseLayerToFrame = CGRectMake((clickedCellFrame.size.width - targetBackgroundEllipseLayerWidth)/2, (clickedCellFrame.size.height - self.backgroundEllipseLayerHeight)/2, targetBackgroundEllipseLayerWidth, self.backgroundEllipseLayerHeight);

    if (self.indicatorViewScrollEnabled) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.25];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        self.backgroundEllipseLayer.frame = backgroundEllipseLayerToFrame;
        [CATransaction commit];

        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.indicatorLineView.frame = lineViewToFrame;
            self.indicatorImageView.center = CGPointMake(self.indicatorLineView.center.x, self.bounds.size.height - self.indicatorImageViewSize.height/2);
            self.backgroundContainerView.frame = clickedCellFrame;
        } completion:^(BOOL finished) {
        }];
    }else {
        self.backgroundContainerView.frame = clickedCellFrame;
        self.indicatorLineView.frame = lineViewToFrame;
        self.indicatorImageView.center = CGPointMake(self.indicatorLineView.center.x, self.bounds.size.height - self.indicatorImageViewSize.height/2);
        [CATransaction begin];
        [CATransaction setDisableActions:true];
        self.backgroundEllipseLayer.frame = backgroundEllipseLayerToFrame;
        [CATransaction commit];
    }
    return YES;
}

- (CGFloat)getLineWidthWithIndex:(NSInteger)index
{
    if (self.dataSource.count == 0) {
        return 0;
    }
    if (self.indicatorLineWidth == JXCategoryViewAutomaticDimension) {
        JXCategoryBaseCellModel *cellModel = self.dataSource[index];
        return cellModel.cellWidth;
    }
    return self.indicatorLineWidth;
}

- (CGFloat)getbackgroundEllipseLayerWidthWithIndex:(NSInteger)index
{
    if (self.dataSource.count == 0) {
        return 0;
    }
    if (self.backgroundEllipseLayerWidth == JXCategoryViewAutomaticDimension) {
        JXCategoryBaseCellModel *cellModel = self.dataSource[index];
        return cellModel.cellWidth;
    }
    return self.backgroundEllipseLayerWidth;
}

- (CGFloat)getbackgroundEllipseLayerCornerRadius {
    if (self.backgroundEllipseLayerCornerRadius == JXCategoryViewAutomaticDimension) {
        return self.backgroundEllipseLayerHeight/2;
    }
    return self.backgroundEllipseLayerCornerRadius;
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    
}

@end
