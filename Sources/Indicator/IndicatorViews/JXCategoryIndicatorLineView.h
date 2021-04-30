//
//  JXCategoryIndicatorLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

typedef NS_ENUM(NSUInteger, JXCategoryIndicatorLineStyle) {
    JXCategoryIndicatorLineStyle_Normal         = 0,
    JXCategoryIndicatorLineStyle_Lengthen       = 1,
    JXCategoryIndicatorLineStyle_LengthenOffset = 2,
};

@interface JXCategoryIndicatorLineView : JXCategoryIndicatorComponentView

@property (nonatomic, assign) JXCategoryIndicatorLineStyle lineStyle;

/**
 line 滚动时沿 x 轴方向上的偏移量，默认值为 10。
 
 lineStyle 为 JXCategoryIndicatorLineStyle_LengthenOffset 有用。
 */
@property (nonatomic, assign) CGFloat lineScrollOffsetX;

@end
