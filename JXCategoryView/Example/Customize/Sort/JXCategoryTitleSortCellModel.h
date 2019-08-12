//
//  JXCategoryTitleSortCellModel.h
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/9.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleCellModel.h"

typedef NS_ENUM(NSUInteger, JXCategoryTitleSortUIType) {
    JXCategoryTitleSortUIType_ArrowBoth,
    JXCategoryTitleSortUIType_ArrowDown,
    JXCategoryTitleSortUIType_ArrowNone,
    JXCategoryTitleSortUIType_SingleImage,
};

typedef NS_ENUM(NSUInteger, JXCategoryTitleSortArrowDirection) {
    JXCategoryTitleSortArrowDirection_Down,
    JXCategoryTitleSortArrowDirection_Up,
    JXCategoryTitleSortArrowDirection_Both,
};

@interface JXCategoryTitleSortCellModel : JXCategoryTitleCellModel

@property (nonatomic, assign) JXCategoryTitleSortUIType uiType;
@property (nonatomic, assign) JXCategoryTitleSortArrowDirection arrowDirection;
@property (nonatomic, strong) UIImage *singleImage;

@end


