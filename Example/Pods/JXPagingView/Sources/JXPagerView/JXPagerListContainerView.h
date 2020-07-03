//
//  JXCategoryListScrollView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXPagerListContainerView;
@class JXPagerListContainerScrollView;

@protocol JXPagerViewListViewDelegate <NSObject>

/**
 返回listView。如果是vc包裹的就是vc.view；如果是自定义view包裹的，就是自定义view自己。

 @return UIView
 */
- (UIView *)listView;

/**
 返回listView内部持有的UIScrollView或UITableView或UICollectionView
 主要用于mainTableView已经显示了header，listView的contentOffset需要重置时，内部需要访问到外部传入进来的listView内的scrollView

 @return listView内部持有的UIScrollView或UITableView或UICollectionView
 */
- (UIScrollView *)listScrollView;

/**
 当listView内部持有的UIScrollView或UITableView或UICollectionView的代理方法`scrollViewDidScroll`回调时，需要调用该代理方法传入的callback

 @param callback `scrollViewDidScroll`回调时调用的callback
 */
- (void)listViewDidScrollCallback:(void (^)(UIScrollView *scrollView))callback;

@optional

- (void)listScrollViewWillResetContentOffset;
- (void)listWillAppear;
- (void)listDidAppear;
- (void)listWillDisappear;
- (void)listDidDisappear;

@end

/**
 列表容器视图的类型

 - ScrollView: UIScrollView。优势：没有其他副作用。劣势：实时的视图内存占用相对大一点，因为所有加载之后的列表视图都在视图层级里面。
 - CollectionView: 使用UICollectionView。优势：因为列表被添加到cell上，实时的视图内存占用更少，适合内存要求特别高的场景。劣势：因为cell重用机制的问题，导致列表被移除屏幕外之后，会被放入缓存区，而不存在于视图层级中。如果刚好你的列表使用了下拉刷新视图，在快速切换过程中，就会导致下拉刷新回调不成功的问题。一句话概括：使用CollectionView的时候，就不要让列表使用下拉刷新加载。
 */
typedef NS_ENUM(NSUInteger, JXPagerListContainerType) {
    JXPagerListContainerType_ScrollView,
    JXPagerListContainerType_CollectionView,
};

@protocol JXPagerListContainerViewDelegate <NSObject>
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXPagerListContainerView *)listContainerView;

/**
 根据index返回一个对应列表实例，需要是遵从`JXPagerViewListViewDelegate`协议的对象。
 你可以代理方法调用的时候初始化对应列表，达到懒加载的效果。这也是默认推荐的初始化列表方法。你也可以提前创建好列表，等该代理方法回调的时候再返回也可以，达到预加载的效果。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXPagerViewListViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXPagerViewListViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 遵从JXPagerViewListViewDelegate协议的list实例
 */
- (id<JXPagerViewListViewDelegate>)listContainerView:(JXPagerListContainerView *)listContainerView initListForIndex:(NSInteger)index;

@optional
/**
 返回自定义UIScrollView或UICollectionView的Class
 某些特殊情况需要自己处理UIScrollView内部逻辑。比如项目用了FDFullscreenPopGesture，需要处理手势相关代理。

 @param listContainerView JXPagerListContainerView
 @return 自定义UIScrollView实例
 */
- (Class)scrollViewClassInlistContainerView:(JXPagerListContainerView *)listContainerView;

/**
 控制能否初始化对应index的列表。有些业务需求，需要在某些情况才允许初始化某些列表，通过通过该代理实现控制。
 */
- (BOOL)listContainerView:(JXPagerListContainerView *)listContainerView canInitListAtIndex:(NSInteger)index;
- (void)listContainerViewDidScroll:(UIScrollView *)scrollView;
- (void)listContainerViewWillBeginDragging:(JXPagerListContainerView *)listContainerView;
- (void)listContainerViewWDidEndScroll:(JXPagerListContainerView *)listContainerView;
- (void)listContainerView:(JXPagerListContainerView *)listContainerView listDidAppearAtIndex:(NSInteger)index;

@end

@interface JXPagerListContainerView : UIView

@property (nonatomic, assign, readonly) JXPagerListContainerType containerType;
@property (nonatomic, strong, readonly) UIScrollView *scrollView;
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<JXPagerViewListViewDelegate>> *validListDict;   //已经加载过的列表字典。key是index，value是对应的列表
@property (nonatomic, strong) UIColor *listCellBackgroundColor; //默认：[UIColor whiteColor]
/**
 滚动切换的时候，滚动距离超过一页的多少百分比，就触发列表的初始化。默认0.01（即列表显示了一点就触发加载）。范围0~1，开区间不包括0和1
 */
@property (nonatomic, assign) CGFloat initListPercent;
///当使用Category嵌套Paging的时候，需要设置为YES，默认为NO；
@property (nonatomic, assign, getter=isCategoryNestPagingEnabled) BOOL categoryNestPagingEnabled;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithType:(JXPagerListContainerType)type delegate:(id<JXPagerListContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@end

@interface JXPagerListContainerView (ListContainer)
- (void)setDefaultSelectedIndex:(NSInteger)index;
- (UIScrollView *)contentScrollView;
- (void)reloadData;
- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex;
- (void)didClickSelectedItemAtIndex:(NSInteger)index;
@end

