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
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor colorWithRed:241/255.0 green:147/255.0 blue:95/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 7;
        label.layer.masksToBounds = YES;
        label;
    });
    [self.contentView addSubview:self.numberLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.numberLabel sizeToFit];
    self.numberLabel.bounds = CGRectMake(0, 0, self.numberLabel.bounds.size.width + 10, 14);
    self.numberLabel.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame));
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryNumberCellModel *myCellModel = (JXCategoryNumberCellModel *)cellModel;
    self.numberLabel.hidden = myCellModel.count == 0;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)myCellModel.count];
    if (myCellModel.count >= 1000) {
        self.numberLabel.text = @"999+";
    }

    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
