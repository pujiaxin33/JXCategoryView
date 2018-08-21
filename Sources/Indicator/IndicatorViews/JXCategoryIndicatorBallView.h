//
//  JXCategoryIndicatorBallView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/21.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorBallView : JXCategoryIndicatorComponentView

@property (nonatomic, assign) CGSize ballViewSize;  //默认：

@property (nonatomic, assign) CGFloat ballScrollOffsetX;

@property (nonatomic, strong) UIColor *ballViewColor;   //默认为[UIColor redColor]

@end
