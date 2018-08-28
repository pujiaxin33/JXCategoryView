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
@property (nonatomic, strong) CALayer *maskLayer;

@end

@implementation JXCategoryTitleCell

- (void)initializeViews
{
    [super initializeViews];
    
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];

    _maskTitleLabel = [[UILabel alloc] init];
    _maskTitleLabel.hidden = YES;
    self.maskTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.maskTitleLabel];

    _maskLayer = [CALayer layer];
    self.maskLayer.backgroundColor = [UIColor redColor].CGColor;
    self.maskTitleLabel.layer.mask = self.maskLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleLabel.center = self.contentView.center;
    self.maskTitleLabel.center = self.contentView.center;
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryTitleCellModel *myCellModel = (JXCategoryTitleCellModel *)cellModel;
    self.titleLabel.font = myCellModel.titleFont;

    if (myCellModel.titleLabelZoomEnabled) {
        self.titleLabel.transform = CGAffineTransformMakeScale(myCellModel.titleLabelZoomScale, myCellModel.titleLabelZoomScale);
        self.maskTitleLabel.transform = CGAffineTransformMakeScale(myCellModel.titleLabelZoomScale, myCellModel.titleLabelZoomScale);
    }else {
        self.titleLabel.transform = CGAffineTransformIdentity;
        self.maskTitleLabel.transform = CGAffineTransformIdentity;
    }

    self.maskTitleLabel.hidden = !myCellModel.titleLabelMaskEnabled;
    if (myCellModel.titleLabelMaskEnabled) {
        self.titleLabel.textColor = myCellModel.titleColor;
        self.maskTitleLabel.font = myCellModel.titleFont;
        self.maskTitleLabel.textColor = myCellModel.titleSelectedColor;

        self.maskTitleLabel.text = myCellModel.title;
        [self.maskTitleLabel sizeToFit];

        CGRect frame = myCellModel.backgroundViewMaskFrame;
        frame.origin.x -= (self.contentView.bounds.size.width - self.maskTitleLabel.bounds.size.width)/2;
        frame.origin.y = 0;
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.maskLayer.frame = frame;
        [CATransaction commit];
    }else {
        if (myCellModel.selected) {
            self.titleLabel.textColor = myCellModel.titleSelectedColor;
        }else {
            self.titleLabel.textColor = myCellModel.titleColor;
        }
    }

    self.titleLabel.text = myCellModel.title;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


@end
