//
//  JXCategoryComponentView.m
//  DQGuess
//
//  Created by jiaxin on 2018/7/25.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryComponentView.h"


@interface JXCategoryComponentView()

@property (nonatomic, strong) CALayer *backgroundEllipseLayer;

@end

@implementation JXCategoryComponentView

- (void)initializeDatas {
    [super initializeDatas];

    _zoomEnabled = NO;
    _zoomScale = 1.2;
    _separatorLineShowEnabled = NO;
    _separatorLineColor = [UIColor lightGrayColor];
    _separatorLineSize = CGSizeMake(1/[UIScreen mainScreen].scale, 20);
}

- (void)initializeViews {
    [super initializeViews];
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

    self.collectionView.components = components;
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

    //POP:刷新状态：selectedCellFrame  superView.height
    for (UIView<JXCategoryComponentProtocol> *component in self.components) {
        [component jx_refreshState:selectedCellFrame];
    }

//    selectedCellModel.backgroundEllipseLayerMaskFrame = self.backgroundEllipseLayer.frame;
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

    CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];
    CGRect rightCellFrame = CGRectZero;
    if (baseIndex + 1 < self.dataSource.count) {
        rightCellFrame = [self getTargetCellFrame:baseIndex+1];
    }

    if (remainderRatio == 0) {
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
        
//        leftCellModel.backgroundEllipseLayerMaskFrame = CGRectMake(targetBackgroundEllipseLayerX - leftBackgroundEllipseLayerX - self.backgroundViewWidthIncrement/2, (leftCellFrame.size.height - self.backgroundViewHeight)/2, targetBackgroundViewWidth, self.backgroundViewHeight);
//        rightCellModel.backgroundEllipseLayerMaskFrame = CGRectMake(targetBackgroundEllipseLayerX - rightBackgroundEllipseLayerX - self.backgroundViewWidthIncrement/2, (leftCellFrame.size.height - self.backgroundViewHeight)/2, targetBackgroundViewWidth, self.backgroundViewHeight);
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

    CGRect clickedCellFrame = [self getTargetCellFrame:index];

    JXCategoryComponentCellModel *selectedCellModel = (JXCategoryComponentCellModel *)self.dataSource[index];
//    selectedCellModel.backgroundEllipseLayerMaskFrame = backgroundEllipseLayerToFrame;
    JXCategoryComponentCell *selectedCell = (JXCategoryComponentCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [selectedCell reloadDatas:selectedCellModel];

    for (UIView<JXCategoryComponentProtocol> *component in self.components) {
        [component jx_selectedCell:clickedCellFrame  isLeftCellSelected:isLeftCellSelected];
    }

    return YES;
}


- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    
}

@end
