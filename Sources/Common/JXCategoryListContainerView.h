//
//  JXCategoryListScrollView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryViewDefines.h"
@class JXCategoryListContainerView;

@protocol JXCategoryListContentViewDelegate <NSObject>

/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己

 @return 返回列表视图
 */
- (UIView *)listView;

@optional

/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppear;

/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappear;

/**
 可选实现，返回列表持有的滚动视图
 */
- (UIScrollView *)listScrollView;

@end

@protocol JXCategoryListContainerViewDelegate <NSObject>
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView;

/**
 根据index初始化一个对应列表实例，需要是遵从`JXCategoryListContentViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index;

@optional
/**
 返回自定义UIScrollView实例
 某些特殊情况需要自己处理UIScrollView内部逻辑。比如项目用了FDFullscreenPopGesture，需要处理手势相关代理。

 @param listContainerView JXCategoryListContainerView
 @return 自定义UIScrollView实例
 */
- (UIScrollView *)scrollViewInlistContainerView:(JXCategoryListContainerView *)listContainerView;

/**
 控制能否初始化对应index的列表。有些业务需求，需要在某些情况才允许初始化某些列表，通过通过该代理实现控制。
 */
- (BOOL)listContainerView:(JXCategoryListContainerView *)listContainerView canInitListAtIndex:(NSInteger)index;

@end


@interface JXCategoryListContainerView : UIView

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *validListDict;   //已经加载过的列表字典。key是index，value是对应的列表
/**
 滚动切换的时候，滚动距离超过一页的多少百分比，就认为切换了页面。默认0.5（即滚动超过了半屏，就认为翻页了）。范围0~1，开区间不包括0和1
 */
@property (nonatomic, assign) CGFloat didAppearPercent;
/**
 需要和self.categoryView.defaultSelectedIndex保持一致
 */
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithDelegate:(id<JXCategoryListContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (void)reloadData;

//必须调用，请按照demo示例那样调用
- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex;

//必须调用，请按照demo示例那样调用（注意是是点击选中的回调，不是其他回调）
- (void)didClickSelectedItemAtIndex:(NSInteger)index;

@end

@interface JXCategoryListContainerView (Deprecated)

/**
 初始化方法

 @param parentVC 父vc，可选。主要用于将其automaticallyAdjustsScrollViewInsets设置为NO。但是现在JXCategoryBaseView内部已经做了该操作。所以该方法已经弃用！！！
 @param delegate JXCategoryListContainerViewDelegate代理
 @return JXCategoryListContainerView实例
 */
- (instancetype)initWithParentVC:(UIViewController *)parentVC delegate:(id<JXCategoryListContainerViewDelegate>)delegate  JXCategoryViewDeprecated("请使用`- (instancetype)initWithDelegate:(id<JXCategoryListContainerViewDelegate>)delegate`方法，未来版本会删除该方法！");

@end

