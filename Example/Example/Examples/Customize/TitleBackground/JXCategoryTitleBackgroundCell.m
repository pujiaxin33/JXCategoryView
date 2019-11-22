//
//  JXCategoryTitleBackgroundCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/16.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleBackgroundCell.h"
#import "JXCategoryTitleBackgroundCellModel.h"

@interface JXCategoryTitleBackgroundCell()
@property (nonatomic, strong) CALayer *bgLayer;
@end

@implementation JXCategoryTitleBackgroundCell

- (void)initializeViews {
    [super initializeViews];

    self.bgLayer = [CALayer layer];
    [self.contentView.layer insertSublayer:self.bgLayer atIndex:0];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    JXCategoryTitleBackgroundCellModel *myCellModel = (JXCategoryTitleBackgroundCellModel *)self.cellModel;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGFloat bgWidth = self.contentView.bounds.size.width;
    if (myCellModel.backgroundWidth != JXCategoryViewAutomaticDimension) {
        bgWidth = myCellModel.backgroundWidth;
    }
    CGFloat bgHeight = self.contentView.bounds.size.height;
    if (myCellModel.backgroundHeight != JXCategoryViewAutomaticDimension) {
        bgHeight = myCellModel.backgroundHeight;
    }
    self.bgLayer.bounds = CGRectMake(0, 0, bgWidth, bgHeight);
    self.bgLayer.position = self.contentView.center;
    [CATransaction commit];
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryTitleBackgroundCellModel *myCellModel = (JXCategoryTitleBackgroundCellModel *)cellModel;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.bgLayer.borderWidth = myCellModel.borderLineWidth;
    self.bgLayer.cornerRadius = myCellModel.backgroundCornerRadius;
    if (myCellModel.isSelected) {
        self.bgLayer.backgroundColor = myCellModel.selectedBackgroundColor.CGColor;
        self.bgLayer.borderColor = myCellModel.selectedBorderColor.CGColor;
    }else {
        self.bgLayer.backgroundColor = myCellModel.normalBackgroundColor.CGColor;
        self.bgLayer.borderColor = myCellModel.normalBorderColor.CGColor;
    }
    [CATransaction commit];
}

@end
