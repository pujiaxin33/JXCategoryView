//
//  JXCategoryListScrollView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryViewDefines.h"
#import "JXCategoryBaseView.h"
@class JXCategoryListContainerView;

/**
 列表容器视图的类型

 - ScrollView: UIScrollView。优势：没有其他副作用。劣势：视图内存占用相对大一点。
 - CollectionView: 使用UICollectionView。优势：因为列表被添加到cell上，视图的内存占用更少，适合内存要求特别高的场景。劣势：因为cell重用机制的问题，导致列表下拉刷新视图，会因为被removeFromSuperview而被隐藏。需要参考`LoadDataListCollectionListViewController`类做特殊处理。
 */
typedef NS_ENUM(NSUInteger, JXCategoryListContainerType) {
    JXCategoryListContainerType_ScrollView,
    JXCategoryListContainerType_CollectionView,
};

@protocol JXCategoryListContentViewDelegate <NSObject>

/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己

 @return 返回列表视图
 */
- (UIView *)listView;

@optional

/**
 可选实现，列表将要显示的时候调用
 */
- (void)listWillAppear;

/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppear;

/**
 可选实现，列表将要消失的时候调用
 */
- (void)listWillDisappear;

/**
 可选实现，列表消失的时候调用
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
 根据index返回一个对应列表实例，需要是遵从`JXCategoryListContentViewDelegate`协议的对象。
 你可以代理方法调用的时候初始化对应列表，达到懒加载的效果。这也是默认推荐的初始化列表方法。你也可以提前创建好列表，等该代理方法回调的时候再返回也可以，达到预加载的效果。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXCategoryListContentViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index;

@optional
/**
 返回自定义UIScrollView或UICollectionView的Class
 某些特殊情况需要自己处理UIScrollView内部逻辑。比如项目用了FDFullscreenPopGesture，需要处理手势相关代理。

 @param listContainerView JXCategoryListContainerView
 @return 自定义UIScrollView实例
 */
- (Class)scrollViewClassInlistContainerView:(JXCategoryListContainerView *)listContainerView;

/**
 控制能否初始化对应index的列表。有些业务需求，需要在某些情况才允许初始化某些列表，通过通过该代理实现控制。
 */
- (BOOL)listContainerView:(JXCategoryListContainerView *)listContainerView canInitListAtIndex:(NSInteger)index;

- (void)listContainerViewDidScroll:(UIScrollView *)scrollView;
- (void)listContainerViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)listContainerViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)listContainerViewWillBeginDecelerating:(UIScrollView *)scrollView;
- (void)listContainerViewDidEndDecelerating:(UIScrollView *)scrollView;

@end


@interface JXCategoryListContainerView : UIView <JXCategoryViewListContainer>

@property (nonatomic, assign, readonly) JXCategoryListContainerType containerType;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *validListDict;   //已经加载过的列表字典。key是index，value是对应的列表
@property (nonatomic, strong) UIColor *listCellBackgroundColor; //默认：[UIColor whiteColor]
/**
 滚动切换的时候，滚动距离超过一页的多少百分比，就触发列表的初始化。默认0.01（即列表显示了一点就触发加载）。范围0~1，开区间不包括0和1
 */
@property (nonatomic, assign) CGFloat initListPercent;
@property (nonatomic, assign) BOOL bounces; //默认NO

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithType:(JXCategoryListContainerType)type delegate:(id<JXCategoryListContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@end

