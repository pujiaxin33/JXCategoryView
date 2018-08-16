//
//  JXCategoryComponentView.h
//  DQGuess
//
//  Created by jiaxin on 2018/7/25.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryBaseView.h"
#import "JXCategoryComponentCell.h"
#import "JXCategoryComponentCellModel.h"

@interface JXCategoryComponentView : JXCategoryBaseView

@property (nonatomic, assign) BOOL indicatorViewScrollEnabled;   //指示器lineView、backgroundEllipseLayer切换时是否支持滚动，默认为YES

@property (nonatomic, assign) BOOL indicatorViewPanGestureManualEnabled;    //指示器lineView、backgroundContainerView随着用户手势滚动处理，是否需要子类自己处理（比如JXCategoryLineStyleView）。默认为NO。

//----------------------indicatorLineView-----------------------//
@property (nonatomic, strong, readonly) UIView *indicatorLineView;

@property (nonatomic, assign) BOOL indicatorLineViewShowEnabled;     //默认为YES

@property (nonatomic, assign) CGFloat indicatorLineViewHeight;

@property (nonatomic, assign) CGFloat indicatorLineWidth;    //默认JXCategoryViewAutomaticDimension（与cellWidth相等）

@property (nonatomic, assign) CGFloat indicatorLineViewCornerRadius;    //默认JXCategoryViewAutomaticDimension （等于self.indicatorLineViewHeight/2）

@property (nonatomic, strong) UIColor *indicatorLineViewColor;   //默认为[UIColor redColor]

//----------------------indicatorImageView-----------------------//

@property (nonatomic, assign) BOOL indicatorImageViewShowEnabled;      //默认NO

@property (nonatomic, assign) BOOL indicatorImageViewRollEnabled;      //默认NO

@property (nonatomic, strong, readonly) UIImageView *indicatorImageView;

@property (nonatomic, assign) CGSize indicatorImageViewSize;

//----------------------backgroundViews-----------------------//

/**
 承载背景指示器视图的容器，比如backgroundEllipseLayer、backgroundImageView就被添加到这上面。backgroundContainerView的frame和选中的cell相同。
 */
@property (nonatomic, strong, readonly) UIView *backgroundContainerView;

@property (nonatomic, strong, readonly) CALayer *backgroundEllipseLayer;

@property (nonatomic, assign) BOOL backgroundEllipseLayerShowEnabled;     //默认为NO

@property (nonatomic, assign) CGFloat backgroundEllipseLayerWidth;     //默认JXCategoryViewAutomaticDimension（与cellWidth相等）

@property (nonatomic, assign) CGFloat backgroundEllipseLayerWidthIncrement;    //宽度增量补偿，因为backgroundEllipseLayer一般会比实际内容大一些。默认0

@property (nonatomic, assign) CGFloat backgroundEllipseLayerHeight;   //默认20

@property (nonatomic, assign) CGFloat backgroundEllipseLayerCornerRadius;   //默认JXCategoryViewAutomaticDimension(即backgroundEllipseLayerHeight/2)

@property (nonatomic, strong) UIColor *backgroundEllipseLayerColor;   //默认为[UIColor redColor]

//----------------------zoomEnabled-----------------------//
@property (nonatomic, assign) BOOL zoomEnabled;     //默认为NO

@property (nonatomic, assign) CGFloat zoomScale;    //默认1.2，zoomEnabled为YES才生效

//----------------------separatorLine-----------------------//
@property (nonatomic, assign) BOOL separatorLineShowEnabled;    //默认为NO

@property (nonatomic, strong) UIColor *separatorLineColor;    //默认为[UIColor lightGrayColor]

@property (nonatomic, assign) CGSize separatorLineSize;    //默认为CGSizeMake(1/[UIScreen mainScreen].scale, 20)

/**
 当contentScrollView滚动时候，处理跟随手势的过渡效果。
 根据cellModel的左右位置、是否选中、ratio进行过滤数据计算。
 
 @param leftCellModel 左边的cellModel
 @param rightCellModel 右边的cellModel
 @param ratio 从左往右方向计算的百分比
 */
- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio NS_REQUIRES_SUPER;

- (CGFloat)getIndicatorLineViewWidthWithIndex:(NSInteger)index;

- (CGFloat)getIndicatorLineViewCornerRadius;

- (CGFloat)getBackgroundEllipseLayerWidthWithIndex:(NSInteger)index;

- (CGFloat)getbackgroundEllipseLayerCornerRadius;

@end
