//
//  JXCategoryLineStyleView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryComponentView.h"

typedef NS_ENUM(NSUInteger, JXCategoryLineStyle) {
    JXCategoryLineStyle_None = 0,
    JXCategoryLineStyle_JD,
    JXCategoryLineStyle_IQIYI,
};


/*
 1、JXCategoryLineStyle不能是JXCategoryLineStyle_None；
 2、indicatorLineWidth需要是固定值；
 3、没有处理backEllipseLayer的手势滚动处理；
 */
@interface JXCategoryLineStyleView : JXCategoryComponentView

@property (nonatomic, assign) JXCategoryLineStyle lineStyle;

/**
 line滚动时x的偏移量，默认为10；
 lineStyle为JXCategoryLineStyle_IQIYI有用；
 */
@property (nonatomic, assign) CGFloat lineScrollOffsetX;

@end
