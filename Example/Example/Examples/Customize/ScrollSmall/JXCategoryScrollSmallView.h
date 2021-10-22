//
//  JXCategoryScrollSmallView.h
//  Example
//
//  Created by tony on 2021/10/22.
//  Copyright © 2021 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JXCategoryTitleView.h"
#import "JXCategoryScrollSmallCell.h"
#import "JXCategoryScrollSmallCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXCategoryScrollSmallView : JXCategoryTitleView
@property (nonatomic, strong) NSArray <NSString *> *statusTitles;
@property (nonatomic, strong) UIColor *timeTitleNormalColor;
@property (nonatomic, strong) UIColor *timeTitleSelectedColor;
@property (nonatomic, strong) UIFont *timeTitleFont;
@property (nonatomic, strong) UIFont *timeTitleSelectedFont;
@property (nonatomic, assign) CGFloat bottomAlpha;
- (void)refreshBottomAlpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
