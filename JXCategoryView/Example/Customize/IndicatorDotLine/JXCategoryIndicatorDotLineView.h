//
//  JXCategoryIndicatorDotLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorDotLineView : JXCategoryIndicatorComponentView

@property (nonatomic, assign) CGSize dotSize;   //默认：CGSizeMake(10, 10)

@property (nonatomic, assign) CGFloat lineWidth;    //默认：50

@property (nonatomic, strong) UIColor *dotLineViewColor;   //默认为[UIColor redColor]

@end
