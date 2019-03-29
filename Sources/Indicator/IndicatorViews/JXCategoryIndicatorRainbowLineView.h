//
//  JXCategoryIndicatorRainbowLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/13.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorLineView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 会无视JXCategoryIndicatorLineView的indicatorColor属性，以indicatorColors为准
 */
@interface JXCategoryIndicatorRainbowLineView : JXCategoryIndicatorLineView

//数量需要与cell的数量相等。没有提供默认值，必须要赋值该属性。categoryView在reloadData的时候，也要一并更新该属性，不然会出现数组越界。
@property (nonatomic, strong) NSArray <UIColor *> *indicatorColors;

@end

NS_ASSUME_NONNULL_END
