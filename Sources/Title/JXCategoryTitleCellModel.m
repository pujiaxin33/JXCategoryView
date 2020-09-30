//
//  JXCategoryTitleCellModel.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleCellModel.h"

@implementation JXCategoryTitleCellModel

- (void)setTitle:(NSString *)title {
    _title = title;

    [self updateNumberSizeWidthIfNeeded];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;

    [self updateNumberSizeWidthIfNeeded];
}

- (void)updateNumberSizeWidthIfNeeded {
    if (self.titleFont) {
        _titleHeight = [self.title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.height;
    }
}

@end
