//
//  JXPagerView.h
//  JXPagerView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerMainTableView.h"
#import "JXPagerListContainerView.h"

@class JXPagerView;

/**
 该协议主要用于mainTableView已经显示了header，listView的contentOffset需要重置时，内部需要访问到外部传入进来的listView内的scrollView
 */
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

/**
 将要重置listScrollView的contentOffset
 */
- (void)listScrollViewWillResetContentOffset;

/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppear;

/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappear;

@end

@protocol JXPagerViewDelegate <NSObject>

/**
 返回tableHeaderView的高度，因为内部需要比对判断，只能是整型数

 @param pagerView pagerView description
 @return return tableHeaderView的高度
 */
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView;

/**
 返回tableHeaderView

 @param pagerView pagerView description
 @return tableHeaderView
 */
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView;

/**
 返回悬浮HeaderView的高度，因为内部需要比对判断，只能是整型数

 @param pagerView pagerView description
 @return 悬浮HeaderView的高度
 */
- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView;

/**
 返回悬浮HeaderView。我用的是自己封装的JXCategoryView（Github:https://github.com/pujiaxin33/JXCategoryView），你也可以选择其他的三方库或者自己写

 @param pagerView pagerView description
 @return 悬浮HeaderView
 */
- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView;

/**
 返回列表的数量

 @param pagerView pagerView description
 @return 列表的数量
 */
- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView;

/**
 根据index初始化一个对应列表实例，需要是遵从`JXPagerViewListViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXPagerViewListViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXPagerViewListViewDelegate`协议，该方法返回自定义UIViewController即可。
 注意：一定要是新生成的实例！！！

 @param pagerView pagerView description
 @param index index description
 @return 新生成的列表实例
 */
- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index;

@optional

/**
 mainTableView的滚动回调，用于实现头图跟随缩放

 @param scrollView mainTableView
 */
- (void)mainTableViewDidScroll:(UIScrollView *)scrollView;

@end

@interface JXPagerView : UIView
/**
 需要和self.categoryView.defaultSelectedIndex保持一致
 */
@property (nonatomic, assign) NSInteger defaultSelectedIndex;
@property (nonatomic, strong, readonly) JXPagerMainTableView *mainTableView;
@property (nonatomic, strong, readonly) JXPagerListContainerView *listContainerView;
/**
 当前已经加载过可用的列表字典，key就是index值，value是对应的列表。
 */
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<JXPagerViewListViewDelegate>> *validListDict;
/**
 顶部固定sectionHeader的垂直偏移量。数值越大越往下沉。
 */
@property (nonatomic, assign) NSInteger pinSectionHeaderVerticalOffset;
/**
 是否支持设备旋转，默认为NO
 */
@property (nonatomic, assign, getter=isDeviceOrientationChangeEnabled) BOOL deviceOrientationChangeEnabled;
/**
 是否允许列表左右滑动。默认：YES
 */
@property (nonatomic, assign) BOOL isListHorizontalScrollEnabled;
/**
 是否允许当前列表自动显示或隐藏列表是垂直滚动指示器。YES：悬浮的headerView滚动到顶部开始滚动列表时，就会显示，反之隐藏。NO：内部不会处理列表的垂直滚动指示器。默认为：YES。
 */
@property (nonatomic, assign) BOOL automaticallyDisplayListVerticalScrollIndicator;

- (instancetype)initWithDelegate:(id<JXPagerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (void)reloadData;
- (void)resizeTableHeaderViewHeightWithAnimatable:(BOOL)animatable duration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve;

@end

@interface JXPagerView (UISubclassingGet)
/**
 暴露给子类使用，请勿直接使用该属性！
 */
@property (nonatomic, strong, readonly) UIScrollView *currentScrollingListView;
/**
 暴露给子类使用，请勿直接使用该属性！
 */
@property (nonatomic, strong, readonly) id<JXPagerViewListViewDelegate> currentList;
@property (nonatomic, assign, readonly) CGFloat mainTableViewMaxContentOffsetY;
@end

@interface JXPagerView (UISubclassingHooks)
- (void)initializeViews NS_REQUIRES_SUPER;
- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView;
- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView;
- (void)setMainTableViewToMaxContentOffsetY;
- (void)setListScrollViewToMinContentOffsetY:(UIScrollView *)scrollView;
- (CGFloat)minContentOffsetYInListScrollView:(UIScrollView *)scrollView;
@end

