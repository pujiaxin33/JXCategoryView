//
//  JXCategoryView.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorView.h"
#import "JXCategoryTitleCell.h"
#import "JXCategoryTitleCellModel.h"

@interface JXCategoryTitleView : JXCategoryIndicatorView

@property (nonatomic, strong) NSArray <NSString *>*titles;

@property (nonatomic, strong) UIColor *titleColor;      //默认：[UIColor blackColor]

@property (nonatomic, strong) UIColor *titleSelectedColor;      //默认：[UIColor redColor]

@property (nonatomic, strong) UIFont *titleFont;    //默认：[UIFont systemFontOfSize:15]

@property (nonatomic, strong) UIFont *titleSelectedFont;    //文字被选中的字体。默认：与titleFont一样

@property (nonatomic, assign) BOOL titleColorGradientEnabled;   //默认：NO，title的颜色是否渐变过渡

@property (nonatomic, assign) BOOL titleLabelMaskEnabled;   //默认：NO，titleLabel是否遮罩过滤。

//----------------------titleLabelZoomEnabled-----------------------//
@property (nonatomic, assign) BOOL titleLabelZoomEnabled;     //默认为NO。为YES时titleSelectedFont失效，以titleFont为准。

@property (nonatomic, assign) BOOL titleLabelZoomScrollGradientEnabled;     //手势滚动中，是否需要更新状态。默认为YES

@property (nonatomic, assign) CGFloat titleLabelZoomScale;    //默认1.2，titleLabelZoomEnabled为YES才生效。是对字号的缩放，比如titleFont的pointSize为10，放大之后字号就是10*1.2=12。

//----------------------titleLabelStrokeWidth-----------------------//
@property (nonatomic, assign) BOOL titleLabelStrokeWidthEnabled;     //默认：NO

@property (nonatomic, assign) CGFloat titleLabelSelectedStrokeWidth;    //默认：-3，用于控制字体的粗细（底层通过NSStrokeWidthAttributeName实现）。使用该属性，务必让titleFont和titleSelectedFont设置为一样的！！！

@end
