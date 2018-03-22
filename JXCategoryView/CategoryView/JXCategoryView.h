//
//  JXCategoryView.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXCategoryView;

extern const CGFloat JXCategoryViewLineWidthAutomaticDimension;

@protocol JXCategoryViewDelegate <NSObject>

@optional
- (void)categoryView:(JXCategoryView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface JXCategoryView : UIView

@property (nonatomic, weak) id<JXCategoryViewDelegate>delegate;

@property (nonatomic, weak) UIScrollView *contentScrollView;    //需要关联的contentScrollView

@property (nonatomic, assign) NSInteger defaultSelectedIndex;

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, assign) CGFloat titleFontSize;

@property (nonatomic, assign) BOOL titleColorGradientEnabled;   //默认为YES，title的颜色是否渐变过渡

@property (nonatomic, strong) UIColor *indicatorLineColor;      //底部指示器lineView颜色

@property (nonatomic, assign) CGFloat indicatorLineWidth;    //默认JXCategoryViewLineWidthAutomaticDimension

@property (nonatomic, assign) BOOL indicatorLineViewShowEnabled;     //默认为YES

@property (nonatomic, assign) BOOL backEllipseLayerShowEnabled;     //默认为NO

@property (nonatomic, assign) CGFloat backEllipseLayerHeight;   //默认为30

@property (nonatomic, strong) UIColor *backEllipseLayerFillColor;   //默认为[UIColor yellowColor]

@property (nonatomic, assign) BOOL indicatorViewScrollEnabled;   //指示器lineView、backEllipseLayer切换时是否支持滚动，默认为YES

@property (nonatomic, assign) BOOL zoomEnabled;     //默认为NO

@property (nonatomic, assign) CGFloat zoomScale;    //默认1.1，zoomEnabled为YES才生效

- (void)reloadDatas;    //更新titles之后都需要显示调用该方法，初始化也是一样的。

@end
