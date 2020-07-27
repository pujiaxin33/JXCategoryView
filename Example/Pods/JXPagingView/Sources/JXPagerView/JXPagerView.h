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

@protocol JXPagerViewDelegate <NSObject>

/**
 返回tableHeaderView的高度，因为内部需要比对判断，只能是整型数
 */
- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView;

/**
 返回tableHeaderView
 */
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView;

/**
 返回悬浮HeaderView的高度，因为内部需要比对判断，只能是整型数
 */
- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView;

/**
 返回悬浮HeaderView。我用的是自己封装的JXCategoryView（Github:https://github.com/pujiaxin33/JXCategoryView），你也可以选择其他的三方库或者自己写
 */
- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView;

/**
 返回列表的数量
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

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView __attribute__ ((deprecated));
- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidScroll:(UIScrollView *)scrollView;
- (void)pagerView:(JXPagerView *)pagerView mainTableViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)pagerView:(JXPagerView *)pagerView mainTableViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

/**
 返回自定义UIScrollView或UICollectionView的Class
 某些特殊情况需要自己处理列表容器内UIScrollView内部逻辑。比如项目用了FDFullscreenPopGesture，需要处理手势相关代理。

 @param pagerView JXPagerView
 @return 自定义UIScrollView实例
 */
- (Class)scrollViewClassInlistContainerViewInPagerView:(JXPagerView *)pagerView;

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
 是否允许列表左右滑动。默认：YES
 */
@property (nonatomic, assign) BOOL isListHorizontalScrollEnabled;
/**
 是否允许当前列表自动显示或隐藏列表是垂直滚动指示器。YES：悬浮的headerView滚动到顶部开始滚动列表时，就会显示，反之隐藏。NO：内部不会处理列表的垂直滚动指示器。默认为：YES。
 */
@property (nonatomic, assign) BOOL automaticallyDisplayListVerticalScrollIndicator;

- (instancetype)initWithDelegate:(id<JXPagerViewDelegate>)delegate;
- (instancetype)initWithDelegate:(id<JXPagerViewDelegate>)delegate listContainerType:(JXPagerListContainerType)type NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (void)reloadData;
- (void)resizeTableHeaderViewHeightWithAnimatable:(BOOL)animatable duration:(NSTimeInterval)duration curve:(UIViewAnimationCurve)curve;

@end

/**
暴露给子类使用，请勿直接使用相关属性和方法！
*/
@interface JXPagerView (UISubclassingGet)
@property (nonatomic, strong, readonly) UIScrollView *currentScrollingListView;
@property (nonatomic, strong, readonly) id<JXPagerViewListViewDelegate> currentList;
@property (nonatomic, assign, readonly) CGFloat mainTableViewMaxContentOffsetY;
@end

@interface JXPagerView (UISubclassingHooks)
- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView;
- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView;
- (void)setMainTableViewToMaxContentOffsetY;
- (void)setListScrollViewToMinContentOffsetY:(UIScrollView *)scrollView;
- (CGFloat)minContentOffsetYInListScrollView:(UIScrollView *)scrollView;
@end

