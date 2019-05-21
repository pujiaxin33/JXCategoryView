//
//  JXCategoryView.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorView.h"
#import "JXCategoryTitleCell.h"
#import "JXCategoryTitleCellModel.h"
#import "JXCategoryViewDefines.h"

@class JXCategoryTitleView;

@protocol JXCategoryTitleViewDataSource <NSObject>
@optional
// 如果将JXCategoryTitleView嵌套进UITableView的cell，每次重用的时候，JXCategoryTitleView进行reloadData时，会重新计算所有的title宽度。所以该应用场景，需要UITableView的cellModel缓存titles的文字宽度，再通过该代理方法返回给JXCategoryTitleView。
// 如果实现了该方法就以该方法返回的宽度为准，不触发内部默认的文字宽度计算。
- (CGFloat)categoryTitleView:(JXCategoryTitleView *)titleView widthForTitle:(NSString *)title;
@end


@interface JXCategoryTitleView : JXCategoryIndicatorView

@property (nonatomic, weak) id<JXCategoryTitleViewDataSource> titleDataSource;

@property (nonatomic, strong) NSArray <NSString *>*titles;

@property (nonatomic, assign) NSInteger titleNumberOfLines; //默认：1

@property (nonatomic, strong) UIColor *titleColor;      //默认：[UIColor blackColor]

@property (nonatomic, strong) UIColor *titleSelectedColor;      //默认：[UIColor redColor]

@property (nonatomic, strong) UIFont *titleFont;    //默认：[UIFont systemFontOfSize:15]

@property (nonatomic, strong) UIFont *titleSelectedFont;    //文字被选中的字体。默认：与titleFont一样

@property (nonatomic, assign, getter=isTitleColorGradientEnabled) BOOL titleColorGradientEnabled;   //默认：NO，title的颜色是否渐变过渡

@property (nonatomic, assign, getter=isTitleLabelMaskEnabled) BOOL titleLabelMaskEnabled;   //默认：NO，titleLabel是否遮罩过滤。

//----------------------titleLabelZoomEnabled-----------------------//
@property (nonatomic, assign, getter=isTitleLabelZoomEnabled) BOOL titleLabelZoomEnabled;     //默认为NO。为YES时titleSelectedFont失效，以titleFont为准。

@property (nonatomic, assign, getter=isTitleLabelZoomScrollGradientEnabled) BOOL titleLabelZoomScrollGradientEnabled;     //手势滚动中，是否需要更新状态。默认为YES

@property (nonatomic, assign) CGFloat titleLabelZoomScale;    //默认1.2，titleLabelZoomEnabled为YES才生效。是对字号的缩放，比如titleFont的pointSize为10，放大之后字号就是10*1.2=12。

//----------------------titleLabelStrokeWidth-----------------------//
@property (nonatomic, assign, getter=isTitleLabelStrokeWidthEnabled) BOOL titleLabelStrokeWidthEnabled;     //默认：NO

@property (nonatomic, assign) CGFloat titleLabelSelectedStrokeWidth;    //默认：-3，用于控制字体的粗细（底层通过NSStrokeWidthAttributeName实现）。使用该属性，务必让titleFont和titleSelectedFont设置为一样的！！！

//----------------------titleLabel缩放中心位置-----------------------//
@property (nonatomic, assign) CGFloat titleLabelVerticalOffset; //titleLabel锚点垂直方向的位置偏移，数值越大越偏离中心，默认为：0

@property (nonatomic, assign) JXCategoryTitleLabelAnchorPointStyle titleLabelAnchorPointStyle;  //titleLabel锚点位置，用于调整titleLabel缩放时的基准位置。默认为：JXCategoryTitleLabelAnchorPointStyleCenter
@end
