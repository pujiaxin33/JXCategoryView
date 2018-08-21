//
//  JXCategoryIndicatorLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

typedef NS_ENUM(NSUInteger, JXCategoryIndicatorLineStyle) {
    JXCategoryIndicatorLineStyle_Normal = 0,
    JXCategoryIndicatorLineStyle_JD,
    JXCategoryIndicatorLineStyle_IQIYI,
};

@interface JXCategoryIndicatorLineView : JXCategoryIndicatorComponentView

@property (nonatomic, assign) JXCategoryIndicatorLineStyle lineStyle;

/**
 line滚动时x的偏移量，默认为10；
 lineStyle为JXCategoryLineStyle_IQIYI有用；
 */
@property (nonatomic, assign) CGFloat lineScrollOffsetX;

@property (nonatomic, assign) CGFloat indicatorLineViewHeight;  //默认：3

@property (nonatomic, assign) CGFloat indicatorLineWidth;    //默认JXCategoryViewAutomaticDimension（与cellWidth相等）

@property (nonatomic, assign) CGFloat indicatorLineViewCornerRadius;    //默认JXCategoryViewAutomaticDimension （等于self.indicatorLineViewHeight/2）

@property (nonatomic, strong) UIColor *indicatorLineViewColor;   //默认为[UIColor redColor]

@end
