//
//  JXCategoryComponentView.h
//  DQGuess
//
//  Created by jiaxin on 2018/7/25.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryBaseView.h"

@interface JXCategoryComponentView : JXCategoryBaseView

@property (nonatomic, assign) BOOL indicatorViewScrollEnabled;   //指示器lineView、backEllipseLayer切换时是否支持滚动，默认为YES

@property (nonatomic, assign) BOOL indicatorViewPanGestureManualEnabled;    //指示器lineView、backEllipseLayer随着用户手势滚动处理，是否需要子类自己处理（比如JXCategoryLineStyleView）。默认为NO。

//----------------------indicatorLineView-----------------------//
@property (nonatomic, strong, readonly) UIView *indicatorLineView;

@property (nonatomic, assign) BOOL indicatorLineViewShowEnabled;     //默认为YES

@property (nonatomic, assign) CGFloat indicatorLineViewHeight;

@property (nonatomic, assign) CGFloat indicatorLineWidth;    //默认JXCategoryViewAutomaticDimension（与cellWidth相等）

//----------------------backEllipseLayer-----------------------//
@property (nonatomic, assign) BOOL backEllipseLayerShowEnabled;     //默认为NO

@property (nonatomic, assign) CGFloat backEllipseLayerWidth;     //默认JXCategoryViewAutomaticDimension（与cellWidth相等）

@property (nonatomic, assign) CGFloat backEllipseLayerHeight;   //默认20

@property (nonatomic, assign) CGFloat backEllipseLayerCornerRadius;   //默认JXCategoryViewAutomaticDimension(即backEllipseLayerHeight/2)

@property (nonatomic, strong) UIColor *backEllipseLayerColor;   //默认为[UIColor yellowColor]

//----------------------zoomEnabled-----------------------//
@property (nonatomic, assign) BOOL zoomEnabled;     //默认为NO

@property (nonatomic, assign) CGFloat zoomScale;    //默认1.2，zoomEnabled为YES才生效

//----------------------separatorLine-----------------------//
@property (nonatomic, assign) BOOL separatorLineShowEnabled;    //默认为NO

/**
 当contentScrollView滚动时候，处理跟随手势的过渡效果。
 根据cellModel的左右位置、是否选中、ratio进行过滤数据计算。
 
 @param leftCellModel 左边的cellModel
 @param rightCellModel 右边的cellModel
 @param ratio 从左往右方向计算的百分比
 */
- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio NS_REQUIRES_SUPER;

@end
