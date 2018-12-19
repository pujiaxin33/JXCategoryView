//
//  JXCategoryListScrollView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
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
 可选实现，列表逻辑层面显示的时候调用
 */
- (void)listDidAppear;
/**
 可选实现，列表逻辑层面消失的时候调用
 */
- (void)listDidDisappear;

@end

@protocol JXCategoryListContainerViewDelegate <NSObject>
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView;

/**
 根据index初始化对应的遵从JXCategoryListContentViewDelegate协议的list，注意是初始化哟，要new一个新的实例！！！

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 新的遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index;
@end


@interface JXCategoryListContainerView : UIView

@property (nonatomic, strong, readonly) UIScrollView *scrollView;
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
/**
 指定的初始化器

 @param parentVC 父vc
 @param delegate JXCategoryListContainerViewDelegate代理
 @return JXCategoryListContainerView实例
 */
- (instancetype)initWithParentVC:(UIViewController *)parentVC delegate:(id<JXCategoryListContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (void)reloadData;

//必须调用，请按照demo示例那样调用
- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex;

//必须调用，请按照demo示例那样调用（注意是是点击选中的回调，不是其他回调）
- (void)didClickSelectedItemAtIndex:(NSInteger)index;

@end
