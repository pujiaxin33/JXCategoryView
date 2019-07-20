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

/**
 继承于`JXCategoryTitleView`的titleColor、titleSelectedColor、titleColorGradientEnabled、titleFont、titleSelectedFont属性失效，相关属性依赖于attributeTitles和selectedAttributeTitles。

 */
@interface JXCategoryTitleAttributeView : JXCategoryTitleView

@property (nonatomic, strong) NSArray <NSAttributedString *> *attributeTitles;
@property (nonatomic, strong) NSArray <NSAttributedString *> *selectedAttributeTitles;

@end
