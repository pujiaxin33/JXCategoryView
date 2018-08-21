//
//  JXCategoryComponentBaseView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryIndicatorProtocol.h"
#import "JXCategoryViewDefines.h"

@interface JXCategoryIndicatorComponentView : UIView <JXCategoryIndicatorProtocol>

@property (nonatomic, assign) JXCategoryComponentPosition componentPosition;

@property (nonatomic, assign) BOOL scrollEnabled;   //手势滚动、点击切换的时候，是否允许滚动，默认YES


@end
