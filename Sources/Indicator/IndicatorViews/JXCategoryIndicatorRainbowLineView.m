//
//  JXCategoryIndicatorRainbowLineView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/13.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorRainbowLineView.h"
#import "JXCategoryFactory.h"

@implementation JXCategoryIndicatorRainbowLineView

- (void)jx_refreshState:(JXCategoryIndicatorParamsModel *)model {
    [super jx_refreshState:model];

    UIColor *color = self.indicatorColors[model.selectedIndex];
    self.backgroundColor = color;
}

- (void)jx_contentScrollViewDidScroll:(JXCategoryIndicatorParamsModel *)model {
    [super jx_contentScrollViewDidScroll:model];

    UIColor *leftColor = self.indicatorColors[model.leftIndex];
    UIColor *rightColor = self.indicatorColors[model.rightIndex];
    UIColor *color = [JXCategoryFactory interpolationColorFrom:leftColor to:rightColor percent:model.percent];
    self.backgroundColor = color;
}

- (void)jx_selectedCell:(JXCategoryIndicatorParamsModel *)model {
    [super jx_selectedCell:model];

    UIColor *color = self.indicatorColors[model.selectedIndex];
    self.backgroundColor = color;
}


@end
