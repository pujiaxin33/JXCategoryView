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
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleLabel.center = self.contentView.center;
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

    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


@end
