//
//  JXCategoryCell.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryCellModel.h"

@interface JXCategoryCell : UICollectionViewCell

@property (nonatomic, strong) JXCategoryCellModel *cellModel;
- (void)refreshUI;

@end
