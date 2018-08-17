//
//  JXCategoryIndicatorImageView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryComponentBaseView.h"

@interface JXCategoryIndicatorImageView : JXCategoryComponentBaseView

@property (nonatomic, strong, readonly) UIImageView *indicatorImageView;

@property (nonatomic, assign) BOOL indicatorImageViewRollEnabled;      //默认NO

@property (nonatomic, assign) CGSize indicatorImageViewSize;

@end
