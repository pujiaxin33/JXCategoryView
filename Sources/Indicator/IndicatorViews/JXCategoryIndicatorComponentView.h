//
//  JXCategoryComponentBaseView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryIndicatorProtocol.h"
#import "JXCategoryViewDefines.h"

@interface JXCategoryIndicatorComponentView : UIView <JXCategoryIndicatorProtocol>

/**
 指示器的位置
 
 可设置的枚举类型：
 - 底部：JXCategoryComponentPosition_Bottom
 - 顶部：JXCategoryComponentPosition_Top
 */
@property (nonatomic, assign) JXCategoryComponentPosition componentPosition;

/**
 指示器的宽度
 
 默认值为 JXCategoryViewAutomaticDimension（表示与 cell 的宽度相等）。
 内部通过 `- (CGFloat)indicatorWidthValue:(CGRect)cellFrame` 方法获取实际的值。
 */
@property (nonatomic, assign) CGFloat indicatorWidth;

/**
 指示器的宽度增量
 
 例如：需求是指示器宽度比 cell 宽度多 10pt。就可以将该属性赋值为 10。
 最终指示器的宽度 = indicatorWidth + indicatorWidthIncrement。
 */
@property (nonatomic, assign) CGFloat indicatorWidthIncrement;

/**
 指示器的高度
 
 默认值为 3。
 内部通过 `- (CGFloat)indicatorHeightValue:(CGRect)cellFrame` 方法获取实际的值。
 */
@property (nonatomic, assign) CGFloat indicatorHeight;

/**
 指示器的 CornerRadius 圆角半径
 
 默认值为 JXCategoryViewAutomaticDimension （等于 indicatorHeight/2）。
 内部通过 `- (CGFloat)indicatorCornerRadiusValue:(CGRect)cellFrame` 方法获取实际的值。
 */
@property (nonatomic, assign) CGFloat indicatorCornerRadius;

/**
 指示器的颜色
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 指示器在垂直方向上的偏移量
 
 数值越大越靠近中心。默认值为 0。
 */
@property (nonatomic, assign) CGFloat verticalMargin;

/**
 是否允许手势滚动
 
 点击切换的时候，是否允许滚动，默认值为 YES。
 */
@property (nonatomic, assign, getter=isScrollEnabled) BOOL scrollEnabled;

/**
 指示器滚动样式
 
 点击切换的时候，如果允许滚动，分为简单滚动和复杂滚动。
 默认值为 JXCategoryIndicatorScrollStyleSimple
 目前仅JXCategoryIndicatorLineView、JXCategoryIndicatorDotLineView支持，其他子类暂不支持。
 */
@property (nonatomic, assign) JXCategoryIndicatorScrollStyle scrollStyle;

/**
 滚动动画的时间，默认值为 0.25s
 */
@property (nonatomic, assign) NSTimeInterval scrollAnimationDuration;

/**
 传入 cellFrame 获取指示器的最终宽度

 @param cellFrame cellFrame
 @return 指示器的最终宽度
 */
- (CGFloat)indicatorWidthValue:(CGRect)cellFrame;

/**
 传入 cellFrame 获取指示器的最终高度

 @param cellFrame cellFrame
 @return 指示器的最终高度
 */
- (CGFloat)indicatorHeightValue:(CGRect)cellFrame;

/**
 传入 cellFrame 获取指示器的最终圆角

 @param cellFrame cellFrame
 @return 指示器的最终圆角
 */
- (CGFloat)indicatorCornerRadiusValue:(CGRect)cellFrame;

@end
