//
//  JXCategoryScrollSmallCell.m
//  Example
//
//  Created by tony on 2021/10/22.
//  Copyright © 2021 jiaxin. All rights reserved.
//

#import "JXCategoryScrollSmallCell.h"
#import "JXCategoryScrollSmallCellModel.h"

@interface JXCategoryScrollSmallCell ()
@property (nonatomic, strong) UILabel *bottomLabel;
@end

@implementation JXCategoryScrollSmallCell

- (void)initializeViews
{
    [super initializeViews];

    _bottomLabel = [[UILabel alloc] init];
    self.bottomLabel.clipsToBounds = YES;
    self.bottomLabel.textAlignment = NSTextAlignmentCenter;
    self.bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.bottomLabel];

    NSLayoutConstraint *topLabelCenterX = [NSLayoutConstraint constraintWithItem:self.bottomLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *topLabelCenterY = [NSLayoutConstraint constraintWithItem:self.bottomLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-13];
    [NSLayoutConstraint activateConstraints:@[topLabelCenterX, topLabelCenterY]];
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryScrollSmallCellModel *myCellModel = (JXCategoryScrollSmallCellModel *)cellModel;
    self.bottomLabel.text = myCellModel.bottomTitle;
    self.bottomLabel.alpha = myCellModel.bottomAlpha;
    if (myCellModel.isSelected) {
        self.bottomLabel.textColor = myCellModel.bottomTitleSelectedColor;
        self.bottomLabel.font = myCellModel.bottomTitleSelectedFont;
    }else {
        self.bottomLabel.textColor = myCellModel.bottomTitleNormalColor;
        self.bottomLabel.font = myCellModel.bottomTitleFont;
    }
}

- (void)refreshBottomAlpha:(CGFloat)alpha {
    self.bottomLabel.alpha = alpha;
}

@end
