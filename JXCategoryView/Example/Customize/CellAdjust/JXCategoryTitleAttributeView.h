//
//  JXCategoryTitleAttributeView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"
#import "JXCategoryTitleAttributeCell.h"
#import "JXCategoryTitleAttributeCellModel.h"

@interface JXCategoryTitleAttributeView : JXCategoryTitleView

//@property (nonatomic, assign) NSInteger titleNumberOfLines;
@property (nonatomic, strong) NSArray <NSAttributedString *> *attributeTitles;
@property (nonatomic, strong) NSArray <NSAttributedString *> *selectedAttributeTitles;

@end
