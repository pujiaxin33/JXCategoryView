//
//  JXCategoryComponentBaseView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@implementation JXCategoryIndicatorComponentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _componentPosition = JXCategoryComponentPosition_Bottom;
        _scrollEnabled = YES;
        _verticalMargin = 0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSAssert(NO, @"Use initWithFrame");
    }
    return self;
}

#pragma mark - JXCategoryComponentProtocol

- (void)jx_refreshState:(CGRect)selectedCellFrame {

}

- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(JXCategoryCellClickedPosition)selectedPosition percent:(CGFloat)percent {
    
}

- (void)jx_selectedCell:(CGRect)cellFrame clickedRelativePosition:(JXCategoryCellClickedPosition)clickedRelativePosition {
    
}

@end
