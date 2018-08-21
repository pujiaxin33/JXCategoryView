//
//  JXCategoryIndicatorTriangleView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorTriangleView : JXCategoryIndicatorComponentView

@property (nonatomic, assign) CGSize triangleViewSize;  //默认：CGSizeMake(14, 10)

@property (nonatomic, strong) UIColor *triangleViewColor;   //默认：[UIColor redColor]

@end
