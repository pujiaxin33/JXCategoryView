//
//  JXCategoryComponentBaseView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryComponentBaseView.h"

@implementation JXCategoryComponentBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollEnabled = YES;
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

- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame isLeftCellSelected:(BOOL)isLeftCellSelected percent:(CGFloat)percent {

}

- (void)jx_selectedCell:(CGRect)cellFrame isLeftCellSelected:(BOOL)isLeftCellSelected{
    
}

@end
