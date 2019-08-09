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
    
    JXCategoryIndicatorLineStyle_JD               JXCategoryViewDeprecated("请使用JXCategoryIndicatorLineStyle_Lengthen，未来版本会删除该属性！")  = 1,    // Deprecated. Use JXCategoryIndicatorLineStyle_Lengthen
    JXCategoryIndicatorLineStyle_IQIYI            JXCategoryViewDeprecated("请使用JXCategoryIndicatorLineStyle_LengthenOffset，未来版本会删除该属性！")  = 2,    // Deprecated. Use JXCategoryIndicatorLineStyle_LengthenOffset
};

@interface JXCategoryIndicatorLineView : JXCategoryIndicatorComponentView

@property (nonatomic, assign) JXCategoryIndicatorLineStyle lineStyle;

/**
 line滚动时x的偏移量，默认为10；
 lineStyle为JXCategoryIndicatorLineStyle_LengthenOffset有用；
 */
@property (nonatomic, assign) CGFloat lineScrollOffsetX;

@end


/**
 指示器的宽度、高度、圆角、颜色属性设置都收拢到JXCategoryIndicatorComponentView基类里面了！
 */
@interface JXCategoryIndicatorLineView (JXDeprecated)
/**
 请使用indicatorHeight
 */
@property (nonatomic, assign) CGFloat indicatorLineViewHeight JXCategoryViewDeprecated("请使用indicatorHeight，未来版本会删除该属性！");
/**
 请使用indicatorWidth
 */
@property (nonatomic, assign) CGFloat indicatorLineWidth JXCategoryViewDeprecated("请使用indicatorWidth，未来版本会删除该属性！");
/**
 请使用indicatorCornerRadius
 */
@property (nonatomic, assign) CGFloat indicatorLineViewCornerRadius JXCategoryViewDeprecated("请使用indicatorCornerRadius，未来版本会删除该属性！");
/**
 请使用indicatorColor
 */
@property (nonatomic, strong) UIColor *indicatorLineViewColor JXCategoryViewDeprecated("请使用indicatorColor，未来版本会删除该属性！");

@end
