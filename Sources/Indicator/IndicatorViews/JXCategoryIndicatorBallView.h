//
//  JXCategoryIndicatorBallView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/21.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorBallView : JXCategoryIndicatorComponentView

//球的尺寸。默认：CGSizeMake(15, 15)
@property (nonatomic, assign) CGSize ballViewSize;
//球的X轴偏移量。默认：20
@property (nonatomic, assign) CGFloat ballScrollOffsetX;
//球的颜色值。默认为[UIColor redColor]
@property (nonatomic, strong) UIColor *ballViewColor;

@end
