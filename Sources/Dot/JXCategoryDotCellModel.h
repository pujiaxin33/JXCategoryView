//
//  JXCategoryDotCellModel.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleCellModel.h"

typedef NS_ENUM(NSUInteger, JXCategoryDotRelativePosition) {
    JXCategoryDotRelativePosition_TopLeft = 0,
    JXCategoryDotRelativePosition_TopRight,
    JXCategoryDotRelativePosition_BottomLeft,
    JXCategoryDotRelativePosition_BottomRight,
};

@interface JXCategoryDotCellModel : JXCategoryTitleCellModel

@property (nonatomic, assign) BOOL dotHidden;
@property (nonatomic, assign) JXCategoryDotRelativePosition relativePosition;
@property (nonatomic, assign) CGSize dotSize;
@property (nonatomic, assign) CGFloat dotCornerRadius;
@property (nonatomic, strong) UIColor *dotColor;
@property (nonatomic, assign) CGPoint dotOffset;

@end
