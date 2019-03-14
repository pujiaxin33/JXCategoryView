//
//  JXCategoryIndicatorDotLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorDotLineView : JXCategoryIndicatorComponentView

//线状态的最大宽度。默认：50
@property (nonatomic, assign) CGFloat lineWidth;

@end

/**
 指示器的宽度、高度、圆角、颜色属性设置都收拢到JXCategoryIndicatorComponentView基类里面了！
 */
@interface JXCategoryIndicatorDotLineView (JXDeprecated)

/**
 请使用indicatorHeight和indicatorWidth！默认宽度10，高度10
 */
@property (nonatomic, assign) CGSize dotSize;
/**
 请使用indicatorColor
 */
@property (nonatomic, strong) UIColor *dotLineViewColor;

@end
