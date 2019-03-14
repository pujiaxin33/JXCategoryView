//
//  JXCategoryIndicatorTriangleView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorTriangleView : JXCategoryIndicatorComponentView

@end

/**
 指示器的宽度、高度、圆角、颜色属性设置都收拢到JXCategoryIndicatorComponentView基类里面了！
 */
@interface JXCategoryIndicatorTriangleView (JXDeprecated)

/**
 请使用indicatorHeight和indicatorWidth！默认宽度14，高度10
 */
@property (nonatomic, assign) CGSize triangleViewSize;

/**
 请使用indicatorColor
 */
@property (nonatomic, strong) UIColor *triangleViewColor;

@end
