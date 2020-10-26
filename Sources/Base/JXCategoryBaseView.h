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

@protocol JXCategoryViewListContainer <NSObject>
- (void)setDefaultSelectedIndex:(NSInteger)index;
- (UIScrollView *)contentScrollView;
- (void)reloadData;
- (void)didClickSelectedItemAtIndex:(NSInteger)index;
@end

@protocol JXCategoryViewDelegate <NSObject>

@optional

//为什么会把选中代理分为三个，因为有时候只关心点击选中的，有时候只关心滚动选中的，有时候只关心选中。所以具体情况，使用对应方法。
/**
 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。

 @param categoryView categoryView对象
 @param index 选中的index
 */
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

/**
 点击选中的情况才会调用该方法

 @param categoryView categoryView对象
 @param index 选中的index
 */
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;

/**
 滚动选中的情况才会调用该方法

 @param categoryView categoryView对象
 @param index 选中的index
 */
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;

/**
 控制能否点击Item

 @param categoryView categoryView对象
 @param index 准备点击的index
 @return 能否点击
 */
- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index;

/**
 正在滚动中的回调

 @param categoryView categoryView对象
 @param leftIndex 正在滚动中，相对位置处于左边的index
 @param rightIndex 正在滚动中，相对位置处于右边的index
 @param ratio 从左往右计算的百分比
 */
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;

@end

@interface JXCategoryBaseView : UIView

@property (nonatomic, strong, readonly) JXCategoryCollectionView *collectionView;

@property (nonatomic, strong) NSArray <JXCategoryBaseCellModel *> *dataSource;

@property (nonatomic, weak) id<JXCategoryViewDelegate> delegate;

/**
 高封装度的列表容器，使用该类可以让列表拥有完成的生命周期、自动同步defaultSelectedIndex、自动调用reloadData。
 */
@property (nonatomic, weak) id<JXCategoryViewListContainer> listContainer;

/**
 推荐使用封装度更高的listContainer属性。如果使用contentScrollView请参考`LoadDataListCustomViewController`使用示例。
 */
@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, assign) NSInteger defaultSelectedIndex;   //修改初始化的时候默认选择的index

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, assign, getter=isContentScrollViewClickTransitionAnimationEnabled) BOOL contentScrollViewClickTransitionAnimationEnabled;    //点击cell进行contentScrollView切换时是否需要动画。默认为YES

@property (nonatomic, assign) CGFloat contentEdgeInsetLeft;     //整体内容的左边距，默认JXCategoryViewAutomaticDimension（等于cellSpacing）

@property (nonatomic, assign) CGFloat contentEdgeInsetRight;    //整体内容的右边距，默认JXCategoryViewAutomaticDimension（等于cellSpacing）

@property (nonatomic, assign) CGFloat cellWidth;    //默认JXCategoryViewAutomaticDimension

@property (nonatomic, assign) CGFloat cellWidthIncrement;    //cell宽度补偿。默认：0

@property (nonatomic, assign) CGFloat cellSpacing;    //cell之间的间距，默认20

@property (nonatomic, assign, getter=isAverageCellSpacingEnabled) BOOL averageCellSpacingEnabled;     //当collectionView.contentSize.width小于JXCategoryBaseView的宽度，是否将cellSpacing均分。默认为YES。

//cell宽度是否缩放
@property (nonatomic, assign, getter=isCellWidthZoomEnabled) BOOL cellWidthZoomEnabled;     //默认为NO

@property (nonatomic, assign, getter=isCellWidthZoomScrollGradientEnabled) BOOL cellWidthZoomScrollGradientEnabled;     //手势滚动过程中，是否需要更新cell的宽度。默认为YES

@property (nonatomic, assign) CGFloat cellWidthZoomScale;    //默认1.2，cellWidthZoomEnabled为YES才生效

@property (nonatomic, assign, getter=isSelectedAnimationEnabled) BOOL selectedAnimationEnabled;    //是否开启点击或代码选中动画。默认为NO。自定义的cell选中动画需要自己实现。（仅点击或调用selectItemAtIndex选中才有效，滚动选中无效）

@property (nonatomic, assign) NSTimeInterval selectedAnimationDuration;     //cell选中动画的时间。默认0.25

/**
 选中目标index的item

 @param index 目标index
 */
- (void)selectItemAtIndex:(NSInteger)index;

/**
 初始化的时候无需调用。比如页面初始化之后，根据网络接口异步回调回来数据，重新配置categoryView，需要调用该方法进行刷新。
 */
- (void)reloadData;

/**
 重新配置categoryView但是不需要reload listContainer。特殊情况是该方法。
 */
- (void)reloadDataWithoutListContainer;

/**
 刷新指定的index的cell
 内部会触发`- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index`方法进行cellModel刷新

 @param index 指定cell的index
 */
- (void)reloadCellAtIndex:(NSInteger)index;

@end



@interface JXCategoryBaseView (UISubclassingBaseHooks)

/**
 获取目标cell当前的frame，反应当前真实的frame受到cellWidthSelectedZoomScale的影响。
 */
- (CGRect)getTargetCellFrame:(NSInteger)targetIndex;

/**
 获取目标cell的选中时的frame，其他cell的状态都当做普通状态处理。
 */
- (CGRect)getTargetSelectedCellFrame:(NSInteger)targetIndex selectedType:(JXCategoryCellSelectedType)selectedType;
- (void)initializeData NS_REQUIRES_SUPER;
- (void)initializeViews NS_REQUIRES_SUPER;

/**
 reloadData方法调用，重新生成数据源赋值到self.dataSource
 */
- (void)refreshDataSource;

/**
 reloadData方法调用，根据数据源重新刷新状态；
 */
- (void)refreshState NS_REQUIRES_SUPER;

/**
 选中某个item时，刷新将要选中与取消选中的cellModel

 @param selectedCellModel 将要选中的cellModel
 @param unselectedCellModel 取消选中的cellModel
 */
- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel NS_REQUIRES_SUPER;

/**
 关联的contentScrollView的contentOffset发生了改变

 @param contentOffset 偏移量
 */
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset NS_REQUIRES_SUPER;

/**
 选中某一个item的时候调用，该方法用于子类重载。
 如果外部要选中某个index，请使用`- (void)selectItemAtIndex:(NSUInteger)index;`

 @param index 选中的index
 @param selectedType JXCategoryCellSelectedType
 @return 返回值为NO，表示触发内部某些判断（点击了同一个cell），子类无需后续操作。
 */
- (BOOL)selectCellAtIndex:(NSInteger)index selectedType:(JXCategoryCellSelectedType)selectedType NS_REQUIRES_SUPER;

/**
 reloadData时，返回每个cell的宽度

 @param index 目标index
 @return cellWidth
 */
- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index;

/**
 返回自定义cell的class

 @return cell class
 */
- (Class)preferredCellClass;

/**
 refreshState时调用，重置cellModel的状态

 @param cellModel 待重置的cellModel
 @param index cellModel在数组中的index
 */
- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index NS_REQUIRES_SUPER;

@end
