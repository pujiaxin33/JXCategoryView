//
//  JXCategoryTitleCellModel.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryComponentCellModel.h"
#import <UIKit/UIKit.h>

@interface JXCategoryTitleCellModel : JXCategoryComponentCellModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, assign) BOOL titleLabelMaskEnabled;

@property (nonatomic, strong) CALayer *backgroundEllipseLayer;

@end
