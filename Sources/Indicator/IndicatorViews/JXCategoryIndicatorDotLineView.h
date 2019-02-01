//
//  JXCategoryIndicatorDotLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorDotLineView : JXCategoryIndicatorComponentView

//点的尺寸。默认：CGSizeMake(10, 10)
@property (nonatomic, assign) CGSize dotSize;
//线状态的最大宽度。默认：50
@property (nonatomic, assign) CGFloat lineWidth;
//点线的颜色值。默认为[UIColor redColor]
@property (nonatomic, strong) UIColor *dotLineViewColor;

@end
