//
//  JXCategoryIndicatorBackgroundView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorBackgroundView : JXCategoryIndicatorComponentView

//背景指示器的宽度。默认JXCategoryViewAutomaticDimension（与cellWidth相等）
@property (nonatomic, assign) CGFloat backgroundViewWidth;
//背景指示器的宽度增量补偿，背景指示器一般要比cell宽度大。默认10
@property (nonatomic, assign) CGFloat backgroundViewWidthIncrement;
//背景指示器的高度。默认JXCategoryViewAutomaticDimension（与cell高度相等）
@property (nonatomic, assign) CGFloat backgroundViewHeight;
//背景指示器的圆角值。默认JXCategoryViewAutomaticDimension(即backgroundViewHeight/2)
@property (nonatomic, assign) CGFloat backgroundViewCornerRadius;
//背景指示器的颜色。默认为[UIColor redColor]
@property (nonatomic, strong) UIColor *backgroundViewColor;

@end
