//
//  JXCategoryIndicatorBallView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/21.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorBallView : JXCategoryIndicatorComponentView

//球的X轴偏移量。默认：20
@property (nonatomic, assign) CGFloat ballScrollOffsetX;

@end

/**
 指示器的宽度、高度、圆角、颜色属性设置都收拢到JXCategoryIndicatorComponentView基类里面了！
 */
@interface JXCategoryIndicatorBallView (JXDeprecated)

/**
 请使用indicatorHeight和indicatorWidth！默认宽度15，高度15
 */
@property (nonatomic, assign) CGSize ballViewSize;
/**
 请使用indicatorColor
 */
@property (nonatomic, strong) UIColor *ballViewColor;

@end
