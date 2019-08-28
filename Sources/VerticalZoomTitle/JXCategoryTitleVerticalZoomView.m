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

@interface JXCategoryTitleVerticalZoomView ()
@property (nonatomic, assign) CGFloat currentVerticalScale; //当前垂直方向的缩放基准值
@end

@implementation JXCategoryTitleVerticalZoomView

- (void)initializeData {
    [super initializeData];

    _maxVerticalFontScale = 2;
    _minVerticalFontScale = 1.3;
    _currentVerticalScale = _maxVerticalFontScale;
    self.cellWidthZoomEnabled = YES;
    self.cellWidthZoomScale = _maxVerticalFontScale;
    self.contentEdgeInsetLeft = 15;
    self.titleLabelZoomScale = _currentVerticalScale;
    self.titleLabelZoomEnabled = YES;
    self.selectedAnimationEnabled = YES;
    _maxVerticalCellSpacing = 20;
    _minVerticalCellSpacing = 10;
    self.cellSpacing = _maxVerticalCellSpacing;
}

- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent {
    CGFloat currentScale = [JXCategoryFactory interpolationFrom:self.minVerticalFontScale to:self.maxVerticalFontScale percent:percent];
    BOOL shouldReloadData = NO;
    if (self.currentVerticalScale != currentScale) {
        //有变化才允许reloadData
        shouldReloadData = YES;
    }
    self.currentVerticalScale = currentScale;
    self.cellWidthZoomScale = currentScale;
    self.cellSpacing = [JXCategoryFactory interpolationFrom:self.minVerticalCellSpacing to:self.maxVerticalCellSpacing percent:percent];
    if (shouldReloadData) {
        [self reloadData];
    }
}

- (void)setCurrentVerticalScale:(CGFloat)currentVerticalScale {
    _currentVerticalScale = currentVerticalScale;

    self.titleLabelZoomScale = currentVerticalScale;
}

- (void)setMaxVerticalCellSpacing:(CGFloat)maxVerticalCellSpacing {
    _maxVerticalCellSpacing = maxVerticalCellSpacing;

    self.cellSpacing = maxVerticalCellSpacing;
}

- (void)setMaxVerticalFontScale:(CGFloat)maxVerticalFontScale {
    _maxVerticalFontScale = maxVerticalFontScale;

    self.titleLabelZoomScale = maxVerticalFontScale;
    self.cellWidthZoomScale = maxVerticalFontScale;
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

@end
