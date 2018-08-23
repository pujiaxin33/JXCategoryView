//
//  JXCategoryBaseCellModel.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryBaseCellModel.h"

@implementation JXCategoryBaseCellModel

- (CGFloat)cellWidth {
    if (_cellWidthZoomEnabled) {
        return _cellWidth * _cellWidthZoomScale;
    }
    return _cellWidth;
}

@end
