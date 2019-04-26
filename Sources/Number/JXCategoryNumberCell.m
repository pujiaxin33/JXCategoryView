//
//  JXCategoryNumberCell.m
//  DQGuess
//
//  Created by jiaxin on 2018/4/9.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryNumberCell.h"
#import "JXCategoryNumberCellModel.h"

@interface JXCategoryNumberCell ()

@end

@implementation JXCategoryNumberCell

- (void)initializeViews {
    [super initializeViews];
    
    self.numberLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;
        label;
    });
    [self.contentView addSubview:self.numberLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.numberLabel sizeToFit];
    JXCategoryNumberCellModel *myCellModel = (JXCategoryNumberCellModel *)self.cellModel;
    self.numberLabel.bounds = CGRectMake(0, 0, self.numberLabel.bounds.size.width + myCellModel.numberLabelWidthIncrement, myCellModel.numberLabelHeight);
    self.numberLabel.layer.cornerRadius = myCellModel.numberLabelHeight/2.0;
    
    self.numberLabel.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame)+myCellModel.numberLabelOffset.x, CGRectGetMinY(self.titleLabel.frame)+myCellModel.numberLabelOffset.y);
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryNumberCellModel *myCellModel = (JXCategoryNumberCellModel *)cellModel;
    self.numberLabel.hidden = myCellModel.count == 0;
    self.numberLabel.backgroundColor = myCellModel.numberBackgroundColor;
    self.numberLabel.font = myCellModel.numberLabelFont;
    self.numberLabel.textColor = myCellModel.numberTitleColor;
    self.numberLabel.text = myCellModel.numberString;

    [self setNeedsLayout];
}

@end
