//
//  JXPagerSmoothView.h
//  JXPagerViewExample-OC
//
//  Created by jiaxin on 2019/11/15.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXPagerSmoothView;

@protocol JXPagerSmoothViewListViewDelegate <NSObject>
/**
返回listView。如果是vc包裹的就是vc.view；如果是自定义view包裹的，就是自定义view自己。
*/
- (UIView *)listView;
/**
 返回JXPagerSmoothViewListViewDelegate内部持有的UIScrollView或UITableView或UICollectionView
 */
- (UIScrollView *)listScrollView;

@optional
- (void)listDidAppear;
- (void)listDidDisappear;

@end

@protocol JXPagerSmoothViewDataSource <NSObject>

/**
 返回页面header的高度
 */
- (CGFloat)heightForPagerHeaderInPagerView:(JXPagerSmoothView *)pagerView;

/**
 返回页面header视图
 */
- (UIView *)viewForPagerHeaderInPagerView:(JXPagerSmoothView *)pagerView;

/**
 返回悬浮视图的高度
 */
- (CGFloat)heightForPinHeaderInPagerView:(JXPagerSmoothView *)pagerView;

/**
 返回悬浮视图
 */
- (UIView *)viewForPinHeaderInPagerView:(JXPagerSmoothView *)pagerView;

/**
 返回列表的数量
 */
- (NSInteger)numberOfListsInPagerView:(JXPagerSmoothView *)pagerView;

/**
 根据index初始化一个对应列表实例，需要是遵从`JXPagerSmoothViewListViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXPagerSmoothViewListViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXPagerSmoothViewListViewDelegate`协议，该方法返回自定义UIViewController即可。

 @param pagerView pagerView description
 @param index index description
 @return 新生成的列表实例
 */
- (id<JXPagerSmoothViewListViewDelegate>)pagerView:(JXPagerSmoothView *)pagerView initListAtIndex:(NSInteger)index;

@end

@protocol JXPagerSmoothViewDelegate <NSObject>
- (void)pagerSmoothViewDidScroll:(UIScrollView *)scrollView;
@end

@interface JXPagerSmoothView : UIView

/**
 当前已经加载过的列表：key就是@(index)值，value是对应的列表。
 */
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<JXPagerSmoothViewListViewDelegate>> *listDict;
@property (nonatomic, strong, readonly) UICollectionView *listCollectionView;
@property (nonatomic, assign) NSInteger defaultSelectedIndex;
@property (nonatomic, weak) id<JXPagerSmoothViewDelegate> delegate;

- (instancetype)initWithDataSource:(id<JXPagerSmoothViewDataSource>)dataSource NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)reloadData;

@end

