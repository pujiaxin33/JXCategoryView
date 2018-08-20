//
//  JXCategoryDotView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"
#import "JXCategoryDotCell.h"
#import "JXCategoryDotCellModel.h"

@interface JXCategoryDotView : JXCategoryTitleView

@property (nonatomic, assign) JXCategoryDotRelativePosition relativePosition;   //相对于titleLabel的位置，默认：JXCategoryDotRelativePosition_TopRight

@property (nonatomic, strong) NSArray <NSNumber *> *dotStates;  //@(布尔值)，控制红点是否显示

@property (nonatomic, assign) CGSize dotSize;   //默认：CGSizeMake(10, 10)

@property (nonatomic, assign) CGFloat dotCornerRadius;  //默认：JXCategoryViewAutomaticDimension（self.dotSize.height/2）

@property (nonatomic, strong) UIColor *dotColor;    //默认：[UIColor redColor]

@end
