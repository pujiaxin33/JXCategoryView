//
//  JXCategoryTitleVerticalZoomView.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/2/14.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleVerticalZoomView.h"
#import "JXCategoryTitleVerticalZoomCellModel.h"
#import "JXCategoryTitleVerticalZoomCell.h"
#import "JXCategoryFactory.h"
#import "JXCategoryViewAnimator.h"

@interface JXCategoryTitleVerticalZoomView()
@property (nonatomic, strong) JXCategoryViewAnimator *edgeLeftAnimator;
@property (nonatomic, assign) BOOL horizontalZoomTransitionAnimating;
@end

@implementation JXCategoryTitleVerticalZoomView

- (void)initializeData {
    [super initializeData];

    _currentVerticalScale = 2;
    _maxVerticalFontScale = 2;
    _minVerticalFontScale = 1.3;
    _maxVerticalContentEdgeInsetLeft = 30;
    self.cellSpacing = 30;
    self.contentEdgeInsetLeft = 30;
    _minVerticalContentEdgeInsetLeft = 15;
    self.titleLabelZoomScale = _currentVerticalScale;
    self.titleLabelZoomEnabled = YES;
    self.selectedAnimationEnabled = YES;
    _maxVerticalCellSpacing = 30;
    _minVerticalCellSpacing = 20;
}

- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent {
    CGFloat currentScale = [JXCategoryFactory interpolationFrom:self.minVerticalFontScale to:self.maxVerticalFontScale percent:percent];
    BOOL shouldReloadData = NO;
    if (self.currentVerticalScale != currentScale) {
        //有变化才允许reloadData
        shouldReloadData = YES;
    }
    self.currentVerticalScale = currentScale;
    CGFloat contentEdgeInsetScale = self.currentVerticalScale/self.maxVerticalFontScale;
    if (self.selectedIndex == 0) {
        self.contentEdgeInsetLeft = self.maxVerticalContentEdgeInsetLeft*contentEdgeInsetScale;
    }else {
        self.contentEdgeInsetLeft = self.minVerticalContentEdgeInsetLeft*contentEdgeInsetScale;
    }
    self.cellSpacing = [JXCategoryFactory interpolationFrom:self.minVerticalCellSpacing to:self.maxVerticalCellSpacing percent:percent];
    if (shouldReloadData) {
        //只有参数有变化才reloadData
        [self reloadData];
    }
}

- (void)setCurrentVerticalScale:(CGFloat)currentVerticalScale {
    _currentVerticalScale = currentVerticalScale;

    self.titleLabelZoomScale = currentVerticalScale;
}

- (Class)preferredCellClass {
    return [JXCategoryTitleVerticalZoomCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryTitleVerticalZoomCellModel *cellModel = [[JXCategoryTitleVerticalZoomCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTitleVerticalZoomCellModel *model = (JXCategoryTitleVerticalZoomCellModel *)cellModel;
    model.maxVerticalFontScale = self.maxVerticalFontScale;
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    if (leftCellModel.index == 0) {
        //第一个cell正在左右交互
        CGFloat scale = self.currentVerticalScale/self.maxVerticalFontScale;
        self.contentEdgeInsetLeft = [JXCategoryFactory interpolationFrom:self.maxVerticalContentEdgeInsetLeft*scale to:self.minVerticalContentEdgeInsetLeft*scale percent:ratio];
        [self.collectionView.collectionViewLayout invalidateLayout];
        [self.collectionView reloadData];
    }
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    if (self.isSelectedAnimationEnabled) {
        if (selectedCellModel.selectedType == JXCategoryCellSelectedTypeCode ||
            selectedCellModel.selectedType == JXCategoryCellSelectedTypeClick) {
            self.edgeLeftAnimator = [[JXCategoryViewAnimator alloc] init];
            self.edgeLeftAnimator.duration = self.selectedAnimationDuration;
            __weak typeof(self) weakSelf = self;
            self.edgeLeftAnimator.progressCallback = ^(CGFloat percent) {
                selectedCellModel.transitionAnimating = YES;
                unselectedCellModel.transitionAnimating = YES;
                weakSelf.horizontalZoomTransitionAnimating = YES;
                CGFloat scale = weakSelf.currentVerticalScale/weakSelf.maxVerticalFontScale;
                if (selectedCellModel.index == 0) {
                    weakSelf.contentEdgeInsetLeft = [JXCategoryFactory interpolationFrom:weakSelf.minVerticalContentEdgeInsetLeft*scale to:weakSelf.maxVerticalContentEdgeInsetLeft*scale percent:percent];
                    [weakSelf.collectionView.collectionViewLayout invalidateLayout];
                }else if (unselectedCellModel.index == 0) {
                    weakSelf.contentEdgeInsetLeft = [JXCategoryFactory interpolationFrom:weakSelf.maxVerticalContentEdgeInsetLeft*scale to:weakSelf.minVerticalContentEdgeInsetLeft*scale percent:percent];
                    [weakSelf.collectionView.collectionViewLayout invalidateLayout];
                }
            };
            self.edgeLeftAnimator.completeCallback = ^{
                selectedCellModel.transitionAnimating = NO;
                unselectedCellModel.transitionAnimating = NO;
                weakSelf.horizontalZoomTransitionAnimating = NO;
            };
            [self.edgeLeftAnimator start];
        }else {
            CGFloat scale = self.currentVerticalScale/self.maxVerticalFontScale;
            if (selectedCellModel.index == 0) {
                self.contentEdgeInsetLeft = self.maxVerticalContentEdgeInsetLeft*scale;
                [self.collectionView.collectionViewLayout invalidateLayout];
            }else if (unselectedCellModel.index == 0) {
                self.contentEdgeInsetLeft = self.minVerticalContentEdgeInsetLeft*scale;
                [self.collectionView.collectionViewLayout invalidateLayout];
            }
        }
    }
}

@end
