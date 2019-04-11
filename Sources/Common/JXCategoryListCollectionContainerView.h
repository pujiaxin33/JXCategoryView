//
//  JXCategoryListCollectionContainerView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryViewDefines.h"
@class JXCategoryListCollectionContainerView;

@protocol JXCategoryListCollectionContentViewDelegate <NSObject>

/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己

 @return 返回列表视图
 */
- (UIView *)listView;

@optional

/**
 可选实现，列表显示的时候调用
 */
- (void)listDidAppear;

/**
 可选实现，列表消失的时候调用
 */
- (void)listDidDisappear;

@end

@protocol JXCategoryListCollectionContainerViewDataSource <NSObject>
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListCollectionContainerView *)listContainerView;

/**
 根据index初始化一个对应列表实例，需要是遵从`JXCategoryListCollectionContentViewDelegate`协议的对象。
 如果列表是用自定义UIView封装的，就让自定义UIView遵从`JXCategoryListCollectionContentViewDelegate`协议，该方法返回自定义UIView即可。
 如果列表是用自定义UIViewController封装的，就让自定义UIViewController遵从`JXCategoryListCollectionContentViewDelegate`协议，该方法返回自定义UIViewController即可。
 注意：一定要是新生成的实例！！！

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 新的遵从JXCategoryListCollectionContentViewDelegate协议的list实例
 */
- (id<JXCategoryListCollectionContentViewDelegate>)listContainerView:(JXCategoryListCollectionContainerView *)listContainerView initListForIndex:(NSInteger)index;

@optional
/**
 返回自定义UICollectionView Class
 某些特殊情况需要自己处理UICollectionView内部逻辑。比如项目用了FDFullscreenPopGesture，需要处理手势相关代理。

 @param listContainerView JXCategoryListCollectionContainerView
 @return 自定义UICollectionView  Class
 */
- (Class)collectionViewClassInListContainerView:(JXCategoryListCollectionContainerView *)listContainerView;
@end


@interface JXCategoryListCollectionContainerView : UIView

@property (nonatomic, weak) id<JXCategoryListCollectionContainerViewDataSource> dataSource;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, strong, readonly) NSDictionary <NSNumber *, id<JXCategoryListCollectionContentViewDelegate>> *validListDict;   //已经加载过的列表字典。key是index，value是对应的列表
/**
 需要和self.categoryView.defaultSelectedIndex保持一致
 */
@property (nonatomic, assign) NSInteger defaultSelectedIndex;

- (void)reloadData;

@end

