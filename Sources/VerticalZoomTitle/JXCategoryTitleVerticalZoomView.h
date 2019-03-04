//
//  JXCategoryTitleVerticalZoomView.h
//  JXCategoryView
//
//  Created by jiaxin on 2019/2/14.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"

NS_ASSUME_NONNULL_BEGIN


/**
 垂直方向的缩放值范围：minVerticalFontScale~maxVerticalFontScale；
 垂直方向左边距范围：minVerticalContentEdgeInsetLeft~maxVerticalContentEdgeInsetLeft，用于达到第一个cell左对齐的效果；
 垂直方向cellSpacing范围：minVerticalCellSpacing~maxVerticalCellSpacing，用于达到缩小时cell更加紧凑
 根据UI设计师给你的参数，去多次尝试设置上面的值来达到同样的效果。多尝试几次就知道每个属性设置之后的效果。
 */
@interface JXCategoryTitleVerticalZoomView : JXCategoryTitleView

@property (nonatomic, assign) CGFloat currentVerticalScale; //当前垂直方向的缩放基准值
@property (nonatomic, assign) CGFloat maxVerticalFontScale; //垂直方向最大的缩放值
@property (nonatomic, assign) CGFloat minVerticalFontScale; //垂直方向最小的缩放值
@property (nonatomic, assign) CGFloat maxVerticalContentEdgeInsetLeft;  //垂直方向左右水平滚动时，最大的左边距值，用于达到左边距对齐的效果
@property (nonatomic, assign) CGFloat minVerticalContentEdgeInsetLeft;  //垂直方向左右水平滚动时，最小的左边距值，用于达到左边距对齐的效果
@property (nonatomic, assign) CGFloat maxVerticalCellSpacing;   //垂直方向最大的cellSpacing
@property (nonatomic, assign) CGFloat minVerticalCellSpacing;   //垂直方向最小的cellSpacing
@property (nonatomic, assign, readonly, getter=isHorizontalZoomTransitionAnimating) BOOL horizontalZoomTransitionAnimating; //是否正在水平缩放动画

/**
 当前列表滚动时，根据当前垂直方向categoryView高度变化的百分比，刷新布局

 @param percent 当前垂直方向categoryView高度变化百分比
 */
- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
