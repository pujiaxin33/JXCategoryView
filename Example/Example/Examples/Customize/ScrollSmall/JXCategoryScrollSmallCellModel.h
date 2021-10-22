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

@property (nonatomic, copy) NSString *timeTitle;

@property (nonatomic, strong) UIColor *timeTitleNormalColor;

@property (nonatomic, strong) UIColor *timeTitleSelectedColor;

@property (nonatomic, strong) UIFont *timeTitleFont;

@property (nonatomic, strong) UIFont *timeTitleSelectedFont;

@property (nonatomic, assign) CGFloat bottomAlpha;

@end

NS_ASSUME_NONNULL_END
