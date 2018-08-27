//
//  JXPagingView.h
//  JXPagingView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagingMainTableView.h"
#import "JXPagingListContainerView.h"

@class JXPagingView;

/**
 该协议主要用于mainTableView已经显示了header，listView的contentOffset需要重置时，内部需要访问到外部传入进来的listView内的scrollView
 */
@protocol JXPagingViewListViewDelegate <NSObject>

- (UIScrollView *)listScrollView;

@end

@protocol JXPagingViewDelegate <NSObject>


/**
 返回tableHeaderView的高度

 @param pagingView pagingView description
 @return return tableHeaderView的高度
 */
- (CGFloat)tableHeaderViewHeightInPagingView:(JXPagingView *)pagingView;


/**
 返回tableHeaderView

 @param pagingView pagingView description
 @return tableHeaderView
 */
- (UIView *)tableHeaderViewInPagingView:(JXPagingView *)pagingView;


/**
 返回悬浮HeaderView的高度。

 @param pagingView pagingView description
 @return 悬浮HeaderView的高度
 */
- (CGFloat)heightForPinSectionHeaderInPagingView:(JXPagingView *)pagingView;


/**
 返回悬浮HeaderView。我用的是自己封装的JXCategoryView（Github:https://github.com/pujiaxin33/JXCategoryView），你也可以选择其他的三方库或者自己写

 @param pagingView pagingView description
 @return 悬浮HeaderView
 */
- (UIView *)viewForPinSectionHeaderInPagingView:(JXPagingView *)pagingView;

/**
 底部listView的条数

 @param pagingView pagingView description
 @return 底部listView的条数
 */
- (NSInteger)numberOfListViewsInPagingView:(JXPagingView *)pagingView;


/**
 返回对应index的listView，需要是UIView的子类，且要遵循JXPagingViewListViewDelegate。
 这里要求返回一个UIView而不是一个UIScrollView，因为列表的UIScrollView一般是被包装到一个view里面，里面会处理数据源和其他逻辑。

 @param pagingView pagingView description
 @param row row index
 @return 遵循JXPagingViewListViewDelegate的UIView
 */
- (UIView <JXPagingViewListViewDelegate>*)pagingView:(JXPagingView *)pagingView listViewInRow:(NSInteger)row;

@optional

/**
 mainTableView的滚动回调，用于实现头图跟随缩放

 @param scrollView mainTableView
 */
- (void)mainTableViewDidScroll:(UIScrollView *)scrollView;

@end

@interface JXPagingView : UIView

@property (nonatomic, weak) id<JXPagingViewDelegate> delegate;

@property (nonatomic, strong, readonly) JXPagingMainTableView *mainTableView;

@property (nonatomic, strong, readonly) JXPagingListContainerView *listContainerView;

- (instancetype)initWithDelegate:(id<JXPagingViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)reloadData;


/**
 外部传入的listView，当其内部的scrollView滚动时，需要调用该方法

 @param scrollView scrollView
 */
- (void)listViewDidScroll:(UIScrollView *)scrollView;


@end


