//
//  JXCategoryIndicatorScrollZoomLineView.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/9/19.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorScrollZoomLineView.h"

@implementation JXCategoryIndicatorScrollZoomLineView

- (void)jx_refreshState:(JXCategoryIndicatorParamsModel *)model {
    //让self.superView的布局更新
    [self.superview.superview setNeedsLayout];
    [self.superview.superview layoutIfNeeded];
    [super jx_refreshState:model];
}

@end
