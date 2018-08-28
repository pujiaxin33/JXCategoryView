//
//  JXCategoryTitleAttributeCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleAttributeCell.h"
#import "JXCategoryTitleAttributeCellModel.h"

@implementation JXCategoryTitleAttributeCell

- (void)initializeViews {
    [super initializeViews];

    self.titleLabel.numberOfLines = 2;
    self.maskTitleLabel.numberOfLines = 2;
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryTitleAttributeCellModel *myCellModel = (JXCategoryTitleAttributeCellModel *)cellModel;

    self.maskTitleLabel.attributedText = myCellModel.attributeTitle;
    [self.maskTitleLabel sizeToFit];
    self.titleLabel.attributedText = myCellModel.attributeTitle;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}



@end
