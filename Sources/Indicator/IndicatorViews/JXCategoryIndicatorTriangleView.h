//
//  JXCategoryIndicatorTriangleView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorTriangleView : JXCategoryIndicatorComponentView
//三角形的尺寸。默认：CGSizeMake(14, 10)
@property (nonatomic, assign) CGSize triangleViewSize;
//三角形的颜色值。默认：[UIColor redColor]
@property (nonatomic, strong) UIColor *triangleViewColor;

@end
