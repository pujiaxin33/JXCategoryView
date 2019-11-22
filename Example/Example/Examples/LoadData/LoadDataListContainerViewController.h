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

@interface LoadDataListContainerViewController : LoadDataBaseViewController <JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

NS_ASSUME_NONNULL_END
