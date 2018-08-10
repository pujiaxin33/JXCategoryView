//
//  JXCategoryNumberView.h
//  DQGuess
//
//  Created by jiaxin on 2018/4/9.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryTitleView.h"
#import "JXCategoryNumberCell.h"
#import "JXCategoryNumberCellModel.h"

@interface JXCategoryNumberView : JXCategoryTitleView

/**
 需要与titles的count对应
 */
@property (nonatomic, strong) NSArray <NSNumber *> *counts;

@end
