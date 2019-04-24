//
//  JXCategoryNumberCellModel.h
//  DQGuess
//
//  Created by jiaxin on 2018/4/24.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryTitleCellModel.h"

@interface JXCategoryNumberCellModel : JXCategoryTitleCellModel

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *numberString;
@property (nonatomic, copy) void(^numberStringFormatterBlock)(NSInteger number);
@property (nonatomic, strong) UIColor *numberBackgroundColor;
@property (nonatomic, strong) UIColor *numberTitleColor;
@property (nonatomic, assign) CGFloat numberLabelWidthIncrement;
@property (nonatomic, assign) CGFloat numberLabelHeight;
@property (nonatomic, strong) UIFont *numberLabelFont;
@property (nonatomic, assign) CGPoint numberLabelOffset;
@end
