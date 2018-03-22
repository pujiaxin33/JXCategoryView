//
//  JXCategoryCell.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryCell.h"

@interface JXCategoryCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation JXCategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews
{
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.titleLabel.frame = self.contentView.bounds;
}

- (void)setCellModel:(JXCategoryCellModel *)cellModel
{
    _cellModel = cellModel;

    [self refreshUI];
}

- (void)refreshUI
{
    self.titleLabel.font = [UIFont systemFontOfSize:self.cellModel.titleFontSize];
    if (self.cellModel.selected) {
        self.titleLabel.textColor = self.cellModel.titleSelectedColor;
    }else {
        self.titleLabel.textColor = self.cellModel.titleColor;
    }
    self.transform = CGAffineTransformMakeScale(self.cellModel.zoomScale, self.cellModel.zoomScale);
    self.titleLabel.text = self.cellModel.title;
}

@end
