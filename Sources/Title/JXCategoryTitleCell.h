//
//  JXCategoryTitleCell.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorCell.h"
#import "JXCategoryViewDefines.h"
@class JXCategoryTitleCellModel;

@interface JXCategoryTitleCell : JXCategoryIndicatorCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *maskTitleLabel;

- (JXCategoryCellSelectedAnimationBlock)preferredTitleZoomAnimationBlock:(JXCategoryTitleCellModel *)cellModel baseScale:(CGFloat)baseScale;

- (JXCategoryCellSelectedAnimationBlock)preferredTitleStrokeWidthAnimationBlock:(JXCategoryTitleCellModel *)cellModel attributedString:(NSMutableAttributedString *)attributedString;

- (JXCategoryCellSelectedAnimationBlock)preferredTitleColorAnimationBlock:(JXCategoryTitleCellModel *)cellModel;

@end
