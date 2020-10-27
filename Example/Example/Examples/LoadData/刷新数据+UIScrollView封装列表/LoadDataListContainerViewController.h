//
//  LoadDataListContainerViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadDataBaseViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"

NS_ASSUME_NONNULL_BEGIN

/// 特殊效果 - 刷新数据+UIScrollView封装列表
@interface LoadDataListContainerViewController : LoadDataBaseViewController <JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

NS_ASSUME_NONNULL_END
