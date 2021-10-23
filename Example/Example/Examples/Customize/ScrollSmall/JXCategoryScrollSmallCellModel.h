//
//  JXCategoryScrollSmallCellModel.h
//  Example
//
//  Created by tony on 2021/10/22.
//  Copyright © 2021 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXCategoryTitleCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXCategoryScrollSmallCellModel : JXCategoryTitleCellModel

@property (nonatomic, copy) NSString *bottomTitle;

@property (nonatomic, strong) UIColor *bottomTitleNormalColor;

@property (nonatomic, strong) UIColor *bottomTitleSelectedColor;

@property (nonatomic, strong) UIFont *bottomTitleFont;

@property (nonatomic, strong) UIFont *bottomTitleSelectedFont;

@property (nonatomic, assign) CGFloat bottomAlpha;

@end

NS_ASSUME_NONNULL_END
