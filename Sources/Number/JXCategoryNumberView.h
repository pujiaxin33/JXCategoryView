//
//  JXCategoryNumberView.h
//  DQGuess
//
//  Created by jiaxin on 2018/4/9.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryTitleView.h"
#import "JXCategoryNumberCell.h"
#import "JXCategoryNumberCellModel.h"

@interface JXCategoryNumberView : JXCategoryTitleView

/**
 需要与titles的count对应
 */
@property (nonatomic, strong) NSArray <NSNumber *> *counts;

/**
 内部默认不会格式化数字，直接转成字符串显示。比如业务需要数字超过999显示999+，可以通过该block实现。
 */
@property (nonatomic, copy) NSString *(^numberStringFormatterBlock)(NSInteger number);

/**
 numberLabel的font，默认：[UIFont systemFontOfSize:11]
 */
@property (nonatomic, strong) UIFont *numberLabelFont;

/**
 数字的背景色，默认：[UIColor colorWithRed:241/255.0 green:147/255.0 blue:95/255.0 alpha:1]
 */
@property (nonatomic, strong) UIColor *numberBackgroundColor;

/**
 数字的title颜色，默认：[UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *numberTitleColor;

/**
 numberLabel的宽度补偿，label真实的宽度是文字内容的宽度加上补偿的宽度，默认：10
 */
@property (nonatomic, assign) CGFloat numberLabelWidthIncrement;

/**
 numberLabel的高度，默认：14
 */
@property (nonatomic, assign) CGFloat numberLabelHeight;

/**
 numberLabel  x,y方向的偏移 （+值：水平方向向右，竖直方向向下）
 */
@property (nonatomic, assign) CGPoint numberLabelOffset;

@end
