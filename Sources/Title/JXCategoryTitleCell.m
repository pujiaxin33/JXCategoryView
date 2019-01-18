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

    if (myCellModel.titleLabelZoomEnabled) {
        //先把font设置为缩放的最大值，再缩小到最小值，最后根据当前的titleLabelZoomScale值，进行缩放更新。这样就能避免transform从小到大时字体模糊
        UIFont *maxScaleFont = [UIFont fontWithDescriptor:myCellModel.titleFont.fontDescriptor size:myCellModel.titleFont.pointSize*myCellModel.titleLabelMaxZoomScale];
        CGFloat baseScale = myCellModel.titleFont.lineHeight/maxScaleFont.lineHeight;
        self.titleLabel.font = maxScaleFont;
        self.maskTitleLabel.font = maxScaleFont;
        self.titleLabel.transform = CGAffineTransformMakeScale(baseScale, baseScale);
        self.titleLabel.transform  = CGAffineTransformMakeScale(baseScale*myCellModel.titleLabelZoomScale, baseScale*myCellModel.titleLabelZoomScale);
    }else {
        if (myCellModel.selected) {
            self.titleLabel.font = myCellModel.titleSelectedFont;
            self.maskTitleLabel.font = myCellModel.titleSelectedFont;
        }else {
            self.titleLabel.font = myCellModel.titleFont;
            self.maskTitleLabel.font = myCellModel.titleFont;
        }
    }

    NSString *titleString = myCellModel.title ? myCellModel.title : @"";
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:titleString];
    if (myCellModel.titleLabelStrokeWidthEnabled) {
        [attriString addAttribute:NSStrokeWidthAttributeName value:@(myCellModel.titleLabelSelectedStrokeWidth) range:NSMakeRange(0, titleString.length)];
    }

    self.maskTitleLabel.hidden = !myCellModel.titleLabelMaskEnabled;
    if (myCellModel.titleLabelMaskEnabled) {
        self.titleLabel.textColor = myCellModel.titleColor;
        self.maskTitleLabel.textColor = myCellModel.titleSelectedColor;

        self.maskTitleLabel.attributedText = attriString;
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

    self.titleLabel.attributedText = attriString;
    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


@end
