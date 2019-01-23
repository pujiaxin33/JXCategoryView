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
    
    CGFloat pointSize = myCellModel.selected ? myCellModel.titleSelectedFont.pointSize : myCellModel.titleFont.pointSize;
    UIFontDescriptor *fontDescriptor = myCellModel.selected ? myCellModel.titleSelectedFont.fontDescriptor : myCellModel.titleFont.fontDescriptor;
    UIColor *textColor = myCellModel.selected ? myCellModel.titleSelectedColor : myCellModel.titleColor;
    NSRange range = NSMakeRange(0, myCellModel.attributeTitle.length);
    
    NSMutableAttributedString *mutaAttrStr = [myCellModel.attributeTitle mutableCopy];
    
    [mutaAttrStr addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    
    UIFont *textFont = myCellModel.titleLabelZoomEnabled ? [UIFont fontWithDescriptor:fontDescriptor size:pointSize * myCellModel.titleLabelZoomScale] : [UIFont fontWithDescriptor:fontDescriptor size:pointSize];
    [mutaAttrStr addAttribute:NSFontAttributeName value:textFont range:range];
    
    if (myCellModel.titleLabelStrokeWidthEnabled) {
        [mutaAttrStr addAttribute:NSStrokeWidthAttributeName value:@(myCellModel.titleLabelSelectedStrokeWidth) range:range];
    }
    
    self.maskTitleLabel.hidden = !myCellModel.titleLabelMaskEnabled;
    if (myCellModel.titleLabelMaskEnabled) {
        self.maskTitleLabel.attributedText = mutaAttrStr;
        [self.maskTitleLabel sizeToFit];
    }else {
        self.titleLabel.attributedText = mutaAttrStr;
        [self.titleLabel sizeToFit];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}



@end
