//
//  JXCategoryIndicatorBackgroundView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorBackgroundView : JXCategoryIndicatorComponentView


@end

/**
 指示器的宽度、高度、圆角、颜色属性设置都收拢到JXCategoryIndicatorComponentView基类里面了！
 */
@interface JXCategoryIndicatorBackgroundView (JXDeprecated)

/**
 请使用indicatorWidth
 默认：JXCategoryViewAutomaticDimension
 */
@property (nonatomic, assign) CGFloat backgroundViewWidth JXCategoryViewDeprecated("请使用indicatorWidth，未来版本会删除该属性！");
/**
 请使用indicatorWidthIncrement
 背景指示器的宽度增量补偿，背景指示器一般要比cell宽度大。默认10
 */
@property (nonatomic, assign) CGFloat backgroundViewWidthIncrement JXCategoryViewDeprecated("请使用indicatorWidthIncrement，未来版本会删除该属性！");
/**
 请使用indicatorHeight
 默认：JXCategoryViewAutomaticDimension
 */
@property (nonatomic, assign) CGFloat backgroundViewHeight JXCategoryViewDeprecated("请使用indicatorHeight，未来版本会删除该属性！");
/**
 请使用indicatorCornerRadius
 默认：JXCategoryViewAutomaticDimension
 */
@property (nonatomic, assign) CGFloat backgroundViewCornerRadius JXCategoryViewDeprecated("请使用indicatorCornerRadius，未来版本会删除该属性！");
/**
 请使用indicatorColor
 默认：[UIColor lightGrayColor]
 */
@property (nonatomic, strong) UIColor *backgroundViewColor JXCategoryViewDeprecated("请使用indicatorColor，未来版本会删除该属性！");

@end
