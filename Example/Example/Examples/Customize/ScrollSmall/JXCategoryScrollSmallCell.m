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
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation JXCategoryScrollSmallCell

- (void)initializeViews
{
    [super initializeViews];

    _timeLabel = [[UILabel alloc] init];
    self.timeLabel.clipsToBounds = YES;
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.timeLabel];

    NSLayoutConstraint *timeLabelCenterX = [NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *timeLabelCenterY = [NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-13];
    [NSLayoutConstraint activateConstraints:@[timeLabelCenterX, timeLabelCenterY]];
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryScrollSmallCellModel *myCellModel = (JXCategoryScrollSmallCellModel *)cellModel;
    self.timeLabel.text = myCellModel.timeTitle;
    self.timeLabel.alpha = myCellModel.bottomAlpha;
    if (myCellModel.isSelected) {
        self.timeLabel.textColor = myCellModel.timeTitleSelectedColor;
        self.timeLabel.font = myCellModel.timeTitleSelectedFont;
    }else {
        self.timeLabel.textColor = myCellModel.timeTitleNormalColor;
        self.timeLabel.font = myCellModel.timeTitleFont;
    }
}

- (void)refreshBottomAlpha:(CGFloat)alpha {
    self.timeLabel.alpha = alpha;
}

@end
