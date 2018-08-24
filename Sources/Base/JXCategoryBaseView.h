//
//  JXCategoryView.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryBaseCell.h"
#import "JXCategoryBaseCellModel.h"
#import "JXCategoryCollectionView.h"
#import "JXCategoryViewDefines.h"

@class JXCategoryBaseView;

@protocol JXCategoryViewDelegate <NSObject>

@optional
//为什么会把选中代理分为三个，因为有时候只关心点击选中的，有时候只关心滚动选中的，有时候只关心选中。所以具体情况，使用对应方法。
/**
 点击选择或者滚动选中都会调用该方法，如果外部不关心具体是点击还是滚动选中的，只关心选中这个事件，就实现该方法。

 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

/**
 点击选中的情况才会调用该方法

 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;

/**
 滚动选中的情况才会调用该方法

 @param categoryView categoryView description
 @param index 选中的index
 */
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;

/**
 正在滚动中的回调

 @param categoryView categoryView description
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 百分比
 */
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;

@end

@interface JXCategoryBaseView : UIView

@property (nonatomic, strong) JXCategoryCollectionView *collectionView;

@property (nonatomic, strong) NSArray <JXCategoryBaseCellModel *>*dataSource;

@property (nonatomic, weak) id<JXCategoryViewDelegate>delegate;

@property (nonatomic, strong) UIScrollView *contentScrollView;    //需要关联的contentScrollView

@property (nonatomic, assign) NSInteger defaultSelectedIndex;   //修改初始化的时候默认选择的index

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, assign) CGFloat cellWidth;    //默认JXCategoryViewAutomaticDimension

@property (nonatomic, assign) CGFloat cellWidthIncrement;    //cell宽度补偿。默认：0

@property (nonatomic, assign) CGFloat cellSpacing;    //cell之间的间距，默认20

@property (nonatomic, assign) BOOL averageCellWidthEnabled;     //当cell内容总宽度小于JXCategoryBaseView的宽度，是否将cellWidth均分。默认为YES。

//----------------------cellWidthZoomEnabled-----------------------//
//cell宽度的缩放主要是为了腾讯视频效果打造的，一般情况下慎用，不太好控制。
@property (nonatomic, assign) BOOL cellWidthZoomEnabled;     //默认为NO

@property (nonatomic, assign) BOOL cellWidthZoomScrollGradientEnabled;     //手势滚动中，是否需要更新状态。默认为YES

@property (nonatomic, assign) CGFloat cellWidthZoomScale;    //默认1.2，cellWidthZoomEnabled为YES才生效

/**
 代码调用选中了目标index的item

 @param index 目标index
 */
- (void)selectItemWithIndex:(NSUInteger)index;

/**
 初始化的时候无需调用。初始化之后更新其他配置属性，需要调用该方法，进行刷新。
 */
- (void)reloadDatas;

/**
 刷新指定的index的cell

 @param index 指定cell的index
 */
- (void)reloadCell:(NSUInteger)index;

#pragma mark - Subclass use

- (CGRect)getTargetCellFrame:(NSInteger)targetIndex;

#pragma mark - Subclass Override

- (void)initializeDatas NS_REQUIRES_SUPER;

- (void)initializeViews NS_REQUIRES_SUPER;

/**
 reloadDatas方法调用，重新生成数据源赋值到self.dataSource
 */
- (void)refreshDataSource;

/**
 reloadDatas方法调用，根据数据源重新刷新状态；
 */
- (void)refreshState NS_REQUIRES_SUPER;

/**
 用户点击了某个item，刷新选中与取消选中的cellModel

 @param selectedCellModel 选中的cellModel
 @param unselectedCellModel 取消选中的cellModel
 */
- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel NS_REQUIRES_SUPER;

/**
 关联的contentScrollView的contentOffset发生了改变

 @param contentOffset 偏移量
 */
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset NS_REQUIRES_SUPER;


/**
 该方法用于子类重载，如果外部要选中某个index，请使用`- (void)selectItemWithIndex:(NSUInteger)index;`
 点击某一个item，或者contentScrollView滚动到某一个item的时候调用。根据selectIndex刷新选中状态。

 @param index 选中的index
 @return 返回值为NO，表示触发内部某些判断（点击了同一个cell），子类无需后续操作。
 */
- (BOOL)selectCellWithIndex:(NSInteger)index NS_REQUIRES_SUPER;

/**
 reloadData时，返回每个cell的宽度

 @param index 目标index
 @return cellWidth
 */
- (CGFloat)preferredCellWidthWithIndex:(NSInteger)index;


/**
 返回自定义cell的class

 @return cell class
 */
- (Class)preferredCellClass;

/**
 refreshState时调用，重置cellModel的状态

 @param cellModel 待重置的cellModel
 @param index 目标index
 */
- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index;

@end
