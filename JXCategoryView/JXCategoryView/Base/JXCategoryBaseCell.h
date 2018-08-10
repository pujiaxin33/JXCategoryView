//
//  JXCategoryBaseCell.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryBaseCellModel.h"

@interface JXCategoryBaseCell : UICollectionViewCell

@property (nonatomic, strong) JXCategoryBaseCellModel *cellModel;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)reloadDatas:(JXCategoryBaseCellModel *)cellModel NS_REQUIRES_SUPER;

@end
