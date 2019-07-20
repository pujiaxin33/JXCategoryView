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
 垂直方向cellSpacing范围：minVerticalCellSpacing~maxVerticalCellSpacing，用于达到缩小时cell更加紧凑
 根据UI设计师给你的参数，去多次尝试设置上面的值来达到同样的效果。多尝试几次就知道每个属性设置之后的效果。
 */
@interface JXCategoryTitleVerticalZoomView : JXCategoryTitleView

@property (nonatomic, assign) CGFloat maxVerticalFontScale; //垂直方向最大的缩放值
@property (nonatomic, assign) CGFloat minVerticalFontScale; //垂直方向最小的缩放值
@property (nonatomic, assign) CGFloat maxVerticalCellSpacing;   //垂直方向最大的cellSpacing
@property (nonatomic, assign) CGFloat minVerticalCellSpacing;   //垂直方向最小的cellSpacing

/**
 当前列表滚动时，根据当前垂直方向categoryView高度变化的百分比，刷新布局

 @param percent 当前垂直方向categoryView高度变化百分比
 */
- (void)listDidScrollWithVerticalHeightPercent:(CGFloat)percent;

@end

NS_ASSUME_NONNULL_END
