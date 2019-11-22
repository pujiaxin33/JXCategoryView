//
//  JXCategoryTitleSortView.h
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/9.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"
#import "JXCategoryTitleSortCellModel.h"
#import "JXCategoryTitleSortCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXCategoryTitleSortView : JXCategoryTitleView
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *uiTypes;//@(index):@(JXCategoryTitleSortUIType)
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *arrowDirections; //@(index):@(JXCategoryTitleSortArrowDirection)
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, UIImage *> *singleImages;//@(index):UIImage
@end

NS_ASSUME_NONNULL_END
