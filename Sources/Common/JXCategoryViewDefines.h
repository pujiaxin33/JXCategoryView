//
//  JXCategoryViewDefines.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static const CGFloat JXCategoryViewAutomaticDimension = -1;

typedef NS_ENUM(NSUInteger, JXCategoryComponentPosition) {
    JXCategoryComponentPosition_Bottom,
    JXCategoryComponentPosition_Top,
};

typedef NS_ENUM(NSUInteger, JXCategoryCellClickedPosition) {
    JXCategoryCellClickedPosition_Left,
    JXCategoryCellClickedPosition_Right,
};
