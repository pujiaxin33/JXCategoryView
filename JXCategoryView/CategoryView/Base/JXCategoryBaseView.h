//
//  JXCategoryView.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryCollectionView.h"
@class JXCategoryBaseView;
@class JXCategoryBaseCellModel;

extern const CGFloat JXCategoryViewAutomaticDimension;

@protocol JXCategoryViewDelegate <NSObject>

@optional
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface JXCategoryBaseView : UIView

@property (nonatomic, strong) JXCategoryCollectionView *collectionView;

@property (nonatomic, strong) NSArray <JXCategoryBaseCellModel *>*dataSource;

@property (nonatomic, weak) id<JXCategoryViewDelegate>delegate;

@property (nonatomic, strong) UIScrollView *contentScrollView;    //需要关联的contentScrollView

@property (nonatomic, assign) NSInteger defaultSelectedIndex;   //修改初始化的时候默认选择的index

@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, assign) CGFloat cellWidth;    //默认JXCategoryViewAutomaticDimension

@property (nonatomic, assign) CGFloat cellSpacing;    //cell之间的间距

@property (nonatomic, assign) BOOL averageCellWidthEnabled;     //当cell内容总宽度小于JXCategoryBaseView的宽度，是否将cellWidth均分。默认为YES。

- (void)reloadDatas;    //初始化的时候无需调用。初始化之后更新其他配置属性，需要调用该方法，进行刷新。

#pragma mark - Subclass use

- (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent;

- (CGRect)getTargetCellFrame:(NSInteger)targetIndex;

#pragma mark - Subclass Override

- (void)initializeDatas NS_REQUIRES_SUPER;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)refreshDatas NS_REQUIRES_SUPER;

//用户点击了某个item，刷新选中与取消选中的cellModel
- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel NS_REQUIRES_SUPER;

//关联的contentScrollView的contentOffset发生了改变
- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset NS_REQUIRES_SUPER;

//点击某一个item，或者contentScrollView滚动到某一个item的时候调用。根据selectIndex刷新选中状态。返回值为NO，表示触发内部某些判断（点击了同一个cell），子类无需后续操作。
- (BOOL)selectItemWithIndex:(NSInteger)index NS_REQUIRES_SUPER;

//reloadData时，返回每个cell的宽度
- (CGFloat)preferredCellWidthWithIndex:(NSInteger)index;

- (Class)preferredCellClass;

//refreshDatas时调用，重置cellModel的状态
- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index;

@end
