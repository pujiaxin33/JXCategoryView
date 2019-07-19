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

typedef void(^JXCategoryCellSelectedAnimationBlock)(CGFloat percent);

typedef NS_ENUM(NSUInteger, JXCategoryComponentPosition) {
    JXCategoryComponentPosition_Bottom,
    JXCategoryComponentPosition_Top,
};

// cell被选中的类型
typedef NS_ENUM(NSUInteger, JXCategoryCellSelectedType) {
    JXCategoryCellSelectedTypeUnknown,          //未知，不是选中（cellForRow方法里面、两个cell过渡时）
    JXCategoryCellSelectedTypeClick,            //点击选中
    JXCategoryCellSelectedTypeCode,             //调用方法`- (void)selectItemAtIndex:(NSInteger)index`选中
    JXCategoryCellSelectedTypeScroll            //通过滚动到某个cell选中
};

typedef NS_ENUM(NSUInteger, JXCategoryTitleLabelAnchorPointStyle) {
    JXCategoryTitleLabelAnchorPointStyleCenter,
    JXCategoryTitleLabelAnchorPointStyleTop,
    JXCategoryTitleLabelAnchorPointStyleBottom,
};

typedef NS_ENUM(NSUInteger, JXCategoryIndicatorScrollStyle) {
    JXCategoryIndicatorScrollStyleSimple,                   //简单滚动，即从当前位置过渡到目标位置
    JXCategoryIndicatorScrollStyleSameAsUserScroll,         //和用户左右滚动列表时的效果一样
};

#define JXCategoryViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)
