//
//  JXCategoryIndicatorBackgroundView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorBackgroundView : JXCategoryIndicatorComponentView

@property (nonatomic, assign) CGFloat backgroundViewWidth;     //默认JXCategoryViewAutomaticDimension（与cellWidth相等）

@property (nonatomic, assign) CGFloat backgroundViewWidthIncrement;    //宽度增量补偿，因为backgroundEllipseLayer一般会比实际内容大一些。默认10

@property (nonatomic, assign) CGFloat backgroundViewHeight;   //默认JXCategoryViewAutomaticDimension（与cell高度相等）

@property (nonatomic, assign) CGFloat backgroundViewCornerRadius;   //默认JXCategoryViewAutomaticDimension(即backgroundViewHeight/2)

@property (nonatomic, strong) UIColor *backgroundViewColor;   //默认为[UIColor redColor]

@end
