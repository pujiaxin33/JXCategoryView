//
//  JXCategoryDotCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryDotCell.h"
#import "JXCategoryDotCellModel.h"

@interface JXCategoryDotCell ()
@property (nonatomic, strong) CALayer *dotLayer;
@end

@implementation JXCategoryDotCell

- (void)initializeViews {
    [super initializeViews];

    _dotLayer = [CALayer layer];
    [self.contentView.layer addSublayer:self.dotLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    JXCategoryDotCellModel *myCellModel = (JXCategoryDotCellModel *)self.cellModel;
    self.dotLayer.bounds = CGRectMake(0, 0, myCellModel.dotSize.width, myCellModel.dotSize.height);
    switch (myCellModel.relativePosition) {
        case JXCategoryDotRelativePosition_TopLeft:
        {
            self.dotLayer.position = CGPointMake(CGRectGetMinX(self.titleLabel.frame) + myCellModel.dotOffset.x, CGRectGetMinY(self.titleLabel.frame) + myCellModel.dotOffset.y);
        }
            break;
        case JXCategoryDotRelativePosition_TopRight:
        {
            self.dotLayer.position = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + myCellModel.dotOffset.x, CGRectGetMinY(self.titleLabel.frame) + myCellModel.dotOffset.y);
        }
            break;
        case JXCategoryDotRelativePosition_BottomLeft:
        {
            self.dotLayer.position = CGPointMake(CGRectGetMinX(self.titleLabel.frame) + myCellModel.dotOffset.x, CGRectGetMaxY(self.titleLabel.frame) + myCellModel.dotOffset.y);
        }
            break;
        case JXCategoryDotRelativePosition_BottomRight:
        {
            self.dotLayer.position = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + myCellModel.dotOffset.x, CGRectGetMaxY(self.titleLabel.frame) + myCellModel.dotOffset.y);
        }
            break;
    }
    [CATransaction commit];
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryDotCellModel *myCellModel = (JXCategoryDotCellModel *)cellModel;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.dotLayer.hidden = !myCellModel.dotHidden;
    self.dotLayer.backgroundColor = myCellModel.dotColor.CGColor;
    self.dotLayer.cornerRadius = myCellModel.dotCornerRadius;
    [CATransaction commit];

    [self setNeedsLayout];
}

@end
