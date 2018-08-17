//
//  JXCategoryComponentView.m
//  DQGuess
//
//  Created by jiaxin on 2018/7/25.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryComponentView.h"


@interface JXCategoryComponentView()

@property (nonatomic, strong) UIView *backgroundContainerView;
@property (nonatomic, strong) CALayer *backgroundEllipseLayer;

@end

@implementation JXCategoryComponentView

- (void)initializeDatas {
    [super initializeDatas];

    _indicatorViewScrollEnabled = YES;
    _zoomEnabled = NO;
    _zoomScale = 1.2;
    _backgroundEllipseLayerWidth = JXCategoryViewAutomaticDimension;
    _backgroundEllipseLayerHeight = 20;
    _backgroundEllipseLayerCornerRadius = JXCategoryViewAutomaticDimension;
    _backgroundEllipseLayerShowEnabled = NO;
    _separatorLineShowEnabled = NO;
    _backgroundEllipseLayerColor = [UIColor lightGrayColor];
    _separatorLineColor = [UIColor lightGrayColor];
    _separatorLineSize = CGSizeMake(1/[UIScreen mainScreen].scale, 20);
    _backgroundEllipseLayerWidthIncrement = 0;
}

- (void)initializeViews {
    [super initializeViews];

    self.backgroundContainerView = [[UIView alloc] init];
    self.backgroundContainerView.backgroundColor = [UIColor clearColor];
    [self.collectionView insertSubview:self.backgroundContainerView atIndex:0];
    self.collectionView.backgroundContainerView = self.backgroundContainerView;

    self.backgroundEllipseLayer = [CALayer layer];
    [self.backgroundContainerView.layer addSublayer:self.backgroundEllipseLayer];
}

- (void)setComponents:(NSArray<UIView<JXCategoryComponentProtocol> *> *)components {
    for (UIView *component in self.components) {
        //先移除之前的component
        [component removeFromSuperview];
    }
    _components = components;

    for (UIView *component in self.components) {
        [self.collectionView addSubview:component];
    }
}

- (void)refreshState {
    [super refreshState];

    CGRect selectedCellFrame = CGRectZero;
    JXCategoryComponentCellModel *selectedCellModel = nil;
    for (int i = 0; i < self.dataSource.count; i++) {
        JXCategoryComponentCellModel *cellModel = (JXCategoryComponentCellModel *)self.dataSource[i];
        cellModel.zoomEnabled = self.zoomEnabled;
        cellModel.zoomScale = 1.0;
        cellModel.sepratorLineShowEnabled = self.separatorLineShowEnabled;
        cellModel.separatorLineColor = self.separatorLineColor;
        cellModel.separatorLineSize = self.separatorLineSize;
        cellModel.backgroundEllipseLayerMaskFrame = CGRectZero;
        if (i == self.dataSource.count - 1) {
            cellModel.sepratorLineShowEnabled = NO;
        }
        if (i == self.selectedIndex) {
            selectedCellModel = cellModel;
            cellModel.selected = YES;
            cellModel.zoomScale = self.zoomScale;
            selectedCellFrame = [self getTargetCellFrame:i];
        }
    }

    self.backgroundContainerView.frame = selectedCellFrame;

    //POP:刷新状态：selectedCellFrame  superView.height
    for (UIView<JXCategoryComponentProtocol> *component in self.components) {
        [component jx_refreshState:selectedCellFrame];
    }

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGFloat selectedBackgroundEllipseLayerWidth = [self getBackgroundEllipseLayerWidthWithIndex:self.selectedIndex];
    self.backgroundEllipseLayer.hidden = !self.backgroundEllipseLayerShowEnabled;
    self.backgroundEllipseLayer.cornerRadius = [self getbackgroundEllipseLayerCornerRadius];
    self.backgroundEllipseLayer.backgroundColor = self.backgroundEllipseLayerColor.CGColor;
//    self.backgroundEllipseLayer.frame = CGRectMake((selectedLineWidth - selectedBackgroundEllipseLayerWidth)/2, (selectedCellFrame.size.height - self.backgroundEllipseLayerHeight)/2, selectedBackgroundEllipseLayerWidth, self.backgroundEllipseLayerHeight);;
    [CATransaction commit];

    selectedCellModel.backgroundEllipseLayerMaskFrame = self.backgroundEllipseLayer.frame;

    if (self.dataSource.count <= 1) {
        self.backgroundEllipseLayer.hidden = YES;
    }
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    JXCategoryComponentCellModel *myUnselectedCellModel = (JXCategoryComponentCellModel *)unselectedCellModel;
    myUnselectedCellModel.zoomScale = 1.0;
    myUnselectedCellModel.backgroundEllipseLayerMaskFrame = CGRectZero;

    JXCategoryComponentCellModel *myselectedCellModel = (JXCategoryComponentCellModel *)selectedCellModel;
    myselectedCellModel.zoomScale = self.zoomScale;
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    [super contentOffsetOfContentScrollViewDidChanged:contentOffset];
    
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;

    CGFloat targetBackgroundEllipseLayerX = self.cellSpacing;
    CGFloat targetBackgroundEllipseLayerWidth = [self getBackgroundEllipseLayerWidthWithIndex:baseIndex];

    CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];
    CGRect rightCellFrame = CGRectZero;
    if (baseIndex + 1 < self.dataSource.count) {
        rightCellFrame = [self getTargetCellFrame:baseIndex+1];
    }

    CGFloat backgroundContainerViewX = leftCellFrame.origin.x;
    CGFloat backgroundContainerViewWidth = leftCellFrame.size.width;

    if (remainderRatio == 0) {
        targetBackgroundEllipseLayerX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetBackgroundEllipseLayerWidth)/2.0;
        //连续滑动翻页，需要更新选中状态
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

        CGFloat leftBackgroundEllipseLayerWidth = targetBackgroundEllipseLayerWidth;
        CGFloat rightBackgroundEllipseLayerWidth = [self getBackgroundEllipseLayerWidthWithIndex:baseIndex + 1];

        CGFloat leftBackgroundEllipseLayerX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftBackgroundEllipseLayerWidth)/2;
        CGFloat rightBackgroundEllipseLayerX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightBackgroundEllipseLayerWidth)/2;
        targetBackgroundEllipseLayerX = [self interpolationFrom:leftBackgroundEllipseLayerX to:rightBackgroundEllipseLayerX percent:remainderRatio];

        backgroundContainerViewX = [self interpolationFrom:leftCellFrame.origin.x to:rightCellFrame.origin.x percent:remainderRatio];
        backgroundContainerViewWidth = [self interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:remainderRatio];

        if (self.backgroundEllipseLayerWidth == JXCategoryViewAutomaticDimension) {
            targetBackgroundEllipseLayerWidth = [self interpolationFrom:leftBackgroundEllipseLayerWidth to:rightBackgroundEllipseLayerWidth percent:remainderRatio];
        }

        
        leftCellModel.backgroundEllipseLayerMaskFrame = CGRectMake(targetBackgroundEllipseLayerX - leftBackgroundEllipseLayerX - self.backgroundEllipseLayerWidthIncrement/2, (leftCellFrame.size.height - self.backgroundEllipseLayerHeight)/2, targetBackgroundEllipseLayerWidth, self.backgroundEllipseLayerHeight);
        rightCellModel.backgroundEllipseLayerMaskFrame = CGRectMake(targetBackgroundEllipseLayerX - rightBackgroundEllipseLayerX - self.backgroundEllipseLayerWidthIncrement/2, (leftCellFrame.size.height - self.backgroundEllipseLayerHeight)/2, targetBackgroundEllipseLayerWidth, self.backgroundEllipseLayerHeight);
        JXCategoryBaseCell *leftCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex inSection:0]];
        [leftCell reloadDatas:leftCellModel];
        JXCategoryBaseCell *rightCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex + 1 inSection:0]];
        [rightCell reloadDatas:rightCellModel];
    }

    BOOL isLeftCellSelected = YES;
    if (self.selectedIndex == baseIndex + 1) {
        isLeftCellSelected = NO;
    }
    for (UIView<JXCategoryComponentProtocol> *component in self.components) {
        [component jx_contentScrollViewDidScrollWithLeftCellFrame:leftCellFrame rightCellFrame:rightCellFrame isLeftCellSelected:isLeftCellSelected percent:remainderRatio];
    }

    //POP:contentScrollView滑动处理，leftCellFrame，rightCellFrame，ratio，superView.height
    if (self.indicatorViewScrollEnabled == YES ||
        (self.indicatorViewScrollEnabled == NO && remainderRatio == 0)) {

        self.backgroundContainerView.frame = CGRectMake(backgroundContainerViewX, 0, backgroundContainerViewWidth, leftCellFrame.size.height);

        [CATransaction begin];
        [CATransaction setDisableActions:true];
        self.backgroundEllipseLayer.frame = CGRectMake((backgroundContainerViewWidth - targetBackgroundEllipseLayerWidth)/2, (leftCellFrame.size.height - self.backgroundEllipseLayerHeight)/2, targetBackgroundEllipseLayerWidth, self.backgroundEllipseLayerHeight);
        [CATransaction commit];
    }
}

- (BOOL)selectItemWithIndex:(NSInteger)index {
    //是否点击了相对于选中cell左边的cell
    BOOL isLeftCellSelected = true;
    if (index > self.selectedIndex) {
        isLeftCellSelected = false;
    }
    BOOL result = [super selectItemWithIndex:index];
    if (!result) {
        return NO;
    }

    //POP:点击切换，clickedCellFrame，superView.height
    CGRect clickedCellFrame = [self getTargetCellFrame:index];

    CGFloat targetBackgroundEllipseLayerWidth = [self getBackgroundEllipseLayerWidthWithIndex:index];
    CGRect backgroundEllipseLayerToFrame = CGRectMake((clickedCellFrame.size.width - targetBackgroundEllipseLayerWidth)/2, (clickedCellFrame.size.height - self.backgroundEllipseLayerHeight)/2, targetBackgroundEllipseLayerWidth, self.backgroundEllipseLayerHeight);

    JXCategoryComponentCellModel *selectedCellModel = (JXCategoryComponentCellModel *)self.dataSource[index];
    selectedCellModel.backgroundEllipseLayerMaskFrame = backgroundEllipseLayerToFrame;
    JXCategoryComponentCell *selectedCell = (JXCategoryComponentCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [selectedCell reloadDatas:selectedCellModel];

    for (UIView<JXCategoryComponentProtocol> *component in self.components) {
        [component jx_selectedCell:clickedCellFrame  isLeftCellSelected:isLeftCellSelected];
    }

    if (self.indicatorViewScrollEnabled) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.25];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        self.backgroundEllipseLayer.frame = backgroundEllipseLayerToFrame;
        [CATransaction commit];

        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.backgroundContainerView.frame = clickedCellFrame;
        } completion:^(BOOL finished) {
        }];
    }else {
        self.backgroundContainerView.frame = clickedCellFrame;
        [CATransaction begin];
        [CATransaction setDisableActions:true];
        self.backgroundEllipseLayer.frame = backgroundEllipseLayerToFrame;
        [CATransaction commit];
    }
    return YES;
}

- (CGFloat)getBackgroundEllipseLayerWidthWithIndex:(NSInteger)index
{
    if (self.dataSource.count == 0) {
        return 0;
    }
    if (self.backgroundEllipseLayerWidth == JXCategoryViewAutomaticDimension) {
        JXCategoryBaseCellModel *cellModel = self.dataSource[index];
        return cellModel.cellWidth  + self.backgroundEllipseLayerWidthIncrement;
    }
    return self.backgroundEllipseLayerWidth + self.backgroundEllipseLayerWidthIncrement;
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
