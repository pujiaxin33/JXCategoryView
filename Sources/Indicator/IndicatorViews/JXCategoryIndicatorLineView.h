//
//  JXCategoryIndicatorLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

typedef NS_ENUM(NSUInteger, JXCategoryIndicatorLineStyle) {
    JXCategoryIndicatorLineStyle_Normal             = 0,
    JXCategoryIndicatorLineStyle_Lengthen           = 1,
    JXCategoryIndicatorLineStyle_LengthenOffset     = 2,
    
    JXCategoryIndicatorLineStyle_JD                 = 1,    // Deprecated. Use JXCategoryIndicatorLineStyle_Lengthen
    JXCategoryIndicatorLineStyle_IQIYI              = 2,    // Deprecated. Use JXCategoryIndicatorLineStyle_LengthenOffset
};

@interface JXCategoryIndicatorLineView : JXCategoryIndicatorComponentView

@property (nonatomic, assign) JXCategoryIndicatorLineStyle lineStyle;

/**
 line滚动时x的偏移量，默认为10；
 lineStyle为JXCategoryIndicatorLineStyle_LengthenOffset有用；
 */
@property (nonatomic, assign) CGFloat lineScrollOffsetX;
//指示器lineView的高度。默认：3
@property (nonatomic, assign) CGFloat indicatorLineViewHeight;
//指示器lineView的宽度。默认JXCategoryViewAutomaticDimension（与cellWidth相等）
@property (nonatomic, assign) CGFloat indicatorLineWidth;
//指示器lineView的圆角值。默认JXCategoryViewAutomaticDimension （等于self.indicatorLineViewHeight/2）
@property (nonatomic, assign) CGFloat indicatorLineViewCornerRadius;
//指示器lineView的颜色。默认为[UIColor redColor]
@property (nonatomic, strong) UIColor *indicatorLineViewColor;

@end
