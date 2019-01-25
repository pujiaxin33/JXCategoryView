//
//  JXCategoryBaseCell.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryBaseCellModel.h"
#import "JXCategoryViewAnimator.h"
#import "JXCategoryViewDefines.h"

@interface JXCategoryBaseCell : UICollectionViewCell

@property (nonatomic, strong, readonly) JXCategoryBaseCellModel *cellModel;
@property (nonatomic, strong, readonly) JXCategoryViewAnimator *animator;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel NS_REQUIRES_SUPER;

- (BOOL)checkCanStartSelectedAnimation:(JXCategoryBaseCellModel *)cellModel;

- (void)addSelectedAnimationBlock:(JXCategoryCellSelectedAnimationBlock)block;

- (void)startSelectedAnimationIfNeeded:(JXCategoryBaseCellModel *)cellModel;
@end
