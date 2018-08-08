//
//  JXCategoryView.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryComponentView.h"
#import "JXCategoryLineStyleView.h"

@interface JXCategoryTitleView : JXCategoryLineStyleView

@property (nonatomic, strong) NSArray <NSString *>*titles;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, assign) BOOL titleColorGradientEnabled;   //默认为NO，title的颜色是否渐变过渡

@end
