//
//  JXCategoryTitleCell.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleCell.h"
#import "JXCategoryTitleCellModel.h"

@interface JXCategoryTitleCell ()

@end

@implementation JXCategoryTitleCell

- (void)initializeViews
{
    [super initializeViews];
    
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label;
    });
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.contentView addConstraint:centerX];
    [self.contentView addConstraint:centerY];
}

- (void)reloadDatas:(JXCategoryBaseCellModel *)cellModel {
    [super reloadDatas:cellModel];

    JXCategoryTitleCellModel *myCellModel = (JXCategoryTitleCellModel *)cellModel;
    self.titleLabel.font = myCellModel.titleFont;
    if (myCellModel.selected) {
        self.titleLabel.textColor = myCellModel.titleSelectedColor;
    }else {
        self.titleLabel.textColor = myCellModel.titleColor;
    }

    self.titleLabel.text = myCellModel.title;
}


@end
