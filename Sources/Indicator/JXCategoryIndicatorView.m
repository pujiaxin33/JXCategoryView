//
//  JXCategoryComponentView.m
//  DQGuess
//
//  Created by jiaxin on 2018/7/25.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryIndicatorView.h"
#import "JXCategoryIndicatorBackgroundView.h"
#import "JXCategoryFactory.h"

@interface JXCategoryIndicatorView()

@property (nonatomic, strong) CALayer *backgroundEllipseLayer;

@end

@implementation JXCategoryIndicatorView

- (void)initializeData {
    [super initializeData];

    _separatorLineShowEnabled = NO;
    _separatorLineColor = [UIColor lightGrayColor];
    _separatorLineSize = CGSizeMake(1/[UIScreen mainScreen].scale, 20);
    _cellBackgroundColorGradientEnabled = NO;
    _cellBackgroundUnselectedColor = [UIColor whiteColor];
    _cellBackgroundSelectedColor = [UIColor lightGrayColor];
}

- (void)initializeViews {
    [super initializeViews];
}

- (void)setIndicators:(NSArray<UIView<JXCategoryIndicatorProtocol> *> *)indicators {
    for (UIView *component in self.indicators) {
        //先移除之前的component
        [component removeFromSuperview];
    }
    _indicators = indicators;

    for (UIView *component in self.indicators) {
        [self.collectionView addSubview:component];
    }

    self.collectionView.indicators = indicators;
}

- (void)refreshState {
    [super refreshState];

    CGRect selectedCellFrame = CGRectZero;
    JXCategoryIndicatorCellModel *selectedCellModel = nil;
    for (int i = 0; i < self.dataSource.count; i++) {
        JXCategoryIndicatorCellModel *cellModel = (JXCategoryIndicatorCellModel *)self.dataSource[i];
        cellModel.sepratorLineShowEnabled = self.separatorLineShowEnabled;
        cellModel.separatorLineColor = self.separatorLineColor;
        cellModel.separatorLineSize = self.separatorLineSize;
        cellModel.backgroundViewMaskFrame = CGRectZero;
        cellModel.cellBackgroundColorGradientEnabled = self.cellBackgroundColorGradientEnabled;
        cellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        cellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        if (i == self.dataSource.count - 1) {
            cellModel.sepratorLineShowEnabled = NO;
        }
        if (i == self.selectedIndex) {
            selectedCellModel = cellModel;
            cellModel.selected = YES;
            selectedCellFrame = [self getTargetCellFrame:i];
        }
    }

    for (UIView<JXCategoryIndicatorProtocol> *component in self.indicators) {
        if (self.dataSource.count <= 0) {
            component.hidden = YES;
        }else {
            component.hidden = NO;
            [component jx_refreshState:selectedCellFrame];

            if ([component isKindOfClass:[JXCategoryIndicatorBackgroundView class]]) {
                CGRect maskFrame = component.frame;
                maskFrame.origin.x = maskFrame.origin.x - selectedCellFrame.origin.x;
                selectedCellModel.backgroundViewMaskFrame = maskFrame;
            }
        }
    }
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    JXCategoryIndicatorCellModel *myUnselectedCellModel = (JXCategoryIndicatorCellModel *)unselectedCellModel;
    myUnselectedCellModel.backgroundViewMaskFrame = CGRectZero;
    myUnselectedCellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
    myUnselectedCellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;

    JXCategoryIndicatorCellModel *myselectedCellModel = (JXCategoryIndicatorCellModel *)selectedCellModel;
    myselectedCellModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
    myselectedCellModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    [super contentOffsetOfContentScrollViewDidChanged:contentOffset];
    
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;

    CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];
    CGRect rightCellFrame = CGRectZero;
    if (baseIndex + 1 < self.dataSource.count) {
        rightCellFrame = [self getTargetCellFrame:baseIndex+1];
    }

    JXCategoryCellClickedPosition position = JXCategoryCellClickedPosition_Left;
    if (self.selectedIndex == baseIndex + 1) {
        position = JXCategoryCellClickedPosition_Right;
    }

    if (remainderRatio == 0) {
        for (UIView<JXCategoryIndicatorProtocol> *component in self.indicators) {
            [component jx_contentScrollViewDidScrollWithLeftCellFrame:leftCellFrame rightCellFrame:rightCellFrame selectedPosition:position percent:remainderRatio];
        }
    }else {
        JXCategoryIndicatorCellModel *leftCellModel = (JXCategoryIndicatorCellModel *)self.dataSource[baseIndex];
        JXCategoryIndicatorCellModel *rightCellModel = (JXCategoryIndicatorCellModel *)self.dataSource[baseIndex + 1];
        [self refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:remainderRatio];

        for (UIView<JXCategoryIndicatorProtocol> *component in self.indicators) {
            [component jx_contentScrollViewDidScrollWithLeftCellFrame:leftCellFrame rightCellFrame:rightCellFrame selectedPosition:position percent:remainderRatio];
            if ([component isKindOfClass:[JXCategoryIndicatorBackgroundView class]]) {
                CGRect leftMaskFrame = component.frame;
                leftMaskFrame.origin.x = leftMaskFrame.origin.x - leftCellFrame.origin.x;
                leftCellModel.backgroundViewMaskFrame = leftMaskFrame;

                CGRect rightMaskFrame = component.frame;
                rightMaskFrame.origin.x = rightMaskFrame.origin.x - rightCellFrame.origin.x;
                rightCellModel.backgroundViewMaskFrame = rightMaskFrame;
            }
        }

        JXCategoryBaseCell *leftCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex inSection:0]];
        [leftCell reloadData:leftCellModel];
        JXCategoryBaseCell *rightCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:baseIndex + 1 inSection:0]];
        [rightCell reloadData:rightCellModel];
    }
}

- (BOOL)selectCellAtIndex:(NSInteger)index {
    //是否点击了相对于选中cell左边的cell
    JXCategoryCellClickedPosition clickedPosition = JXCategoryCellClickedPosition_Left;
    if (index > self.selectedIndex) {
        clickedPosition = JXCategoryCellClickedPosition_Right;
    }
    BOOL result = [super selectCellAtIndex:index];
    if (!result) {
        return NO;
    }

    CGRect clickedCellFrame = [self getTargetCellFrame:index];

    JXCategoryIndicatorCellModel *selectedCellModel = (JXCategoryIndicatorCellModel *)self.dataSource[index];
    for (UIView<JXCategoryIndicatorProtocol> *component in self.indicators) {
        [component jx_selectedCell:clickedCellFrame clickedRelativePosition:clickedPosition];
        if ([component isKindOfClass:[JXCategoryIndicatorBackgroundView class]]) {
            CGRect maskFrame = component.frame;
            maskFrame.origin.x = maskFrame.origin.x - clickedCellFrame.origin.x;
            selectedCellModel.backgroundViewMaskFrame = maskFrame;
        }
    }

    JXCategoryIndicatorCell *selectedCell = (JXCategoryIndicatorCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [selectedCell reloadData:selectedCellModel];

    return YES;
}


- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    if (self.cellBackgroundColorGradientEnabled) {
        //处理cell背景色渐变
        JXCategoryIndicatorCellModel *leftModel = (JXCategoryIndicatorCellModel *)leftCellModel;
        JXCategoryIndicatorCellModel *rightModel = (JXCategoryIndicatorCellModel *)rightCellModel;
        if (leftModel.selected) {
            leftModel.cellBackgroundSelectedColor = [JXCategoryFactory interpolationColorFrom:self.cellBackgroundSelectedColor to:self.cellBackgroundUnselectedColor percent:ratio];
            leftModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        }else {
            leftModel.cellBackgroundUnselectedColor = [JXCategoryFactory interpolationColorFrom:self.cellBackgroundSelectedColor to:self.cellBackgroundUnselectedColor percent:ratio];
            leftModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        }
        if (rightModel.selected) {
            rightModel.cellBackgroundSelectedColor = [JXCategoryFactory interpolationColorFrom:self.cellBackgroundUnselectedColor to:self.cellBackgroundSelectedColor percent:ratio];
            rightModel.cellBackgroundUnselectedColor = self.cellBackgroundUnselectedColor;
        }else {
            rightModel.cellBackgroundUnselectedColor = [JXCategoryFactory interpolationColorFrom:self.cellBackgroundUnselectedColor to:self.cellBackgroundSelectedColor percent:ratio];
            rightModel.cellBackgroundSelectedColor = self.cellBackgroundSelectedColor;
        }
    }

}

@end
