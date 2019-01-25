//
//  JXCategoryTitleCellModel.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorCellModel.h"
#import <UIKit/UIKit.h>

@interface JXCategoryTitleCellModel : JXCategoryIndicatorCellModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleNormalColor;

@property (nonatomic, strong) UIColor *titleCurrentColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIFont *titleSelectedFont;

@property (nonatomic, assign) BOOL titleLabelMaskEnabled;

@property (nonatomic, assign) BOOL titleLabelZoomEnabled;

@property (nonatomic, assign) CGFloat titleLabelNormalZoomScale;

@property (nonatomic, assign) CGFloat titleLabelCurrentZoomScale;

@property (nonatomic, assign) CGFloat titleLabelSelectedZoomScale;

@property (nonatomic, assign) BOOL titleLabelStrokeWidthEnabled;

@property (nonatomic, assign) CGFloat titleLabelNormalStrokeWidth;

@property (nonatomic, assign) CGFloat titleLabelCurrentStrokeWidth;

@property (nonatomic, assign) CGFloat titleLabelSelectedStrokeWidth;

@end
