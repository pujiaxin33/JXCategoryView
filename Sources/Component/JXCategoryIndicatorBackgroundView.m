//
//  JXCategoryIndicatorBackgroundView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorBackgroundView.h"
#import "JXCategoryFactory.h"

@implementation JXCategoryIndicatorBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundViewWidth = JXCategoryViewAutomaticDimension;
        _backgroundViewHeight = 20;
        _backgroundViewCornerRadius = JXCategoryViewAutomaticDimension;
        _backgroundViewColor = [UIColor lightGrayColor];
        _backgroundViewWidthIncrement = 10;
    }
    return self;
}

#pragma mark - JXCategoryComponentProtocol

- (void)jx_refreshState:(CGRect)selectedCellFrame {
    self.layer.cornerRadius = [self getBackgroundViewCornerRadius];
    self.backgroundColor = self.backgroundViewColor;

    CGFloat width = [self getBackgroundViewWidth:selectedCellFrame];
    CGFloat x = selectedCellFrame.origin.x + (selectedCellFrame.size.width - width)/2;
    CGFloat y = (selectedCellFrame.size.height - self.backgroundViewHeight)/2;
    self.frame = CGRectMake(x, y, width, self.backgroundViewHeight);
}

- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(JXCategoryCellClickedPosition)selectedPosition percent:(CGFloat)percent {

    CGFloat targetX = leftCellFrame.origin.x;
    CGFloat targetWidth = [self getBackgroundViewWidth:leftCellFrame];

    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = [self getBackgroundViewWidth:rightCellFrame];

        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;

        targetX = [JXCategoryFactory interpolationFrom:leftX to:rightX percent:percent];

        if (self.backgroundViewWidth == JXCategoryViewAutomaticDimension) {
            targetWidth = [JXCategoryFactory interpolationFrom:leftWidth to:rightWidth percent:percent];
        }
    }

    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
        CGFloat y = (leftCellFrame.size.height - self.backgroundViewHeight)/2;
        self.frame = CGRectMake(targetX, y, targetWidth, self.backgroundViewHeight);
    }
}

- (void)jx_selectedCell:(CGRect)cellFrame clickedRelativePosition:(JXCategoryCellClickedPosition)clickedRelativePosition {
    CGFloat width = [self getBackgroundViewWidth:cellFrame];
    CGFloat x = cellFrame.origin.x + (cellFrame.size.width - width)/2;
    CGFloat y = (cellFrame.size.height - self.backgroundViewHeight)/2;
    CGRect toFrame = CGRectMake(x, y, width, self.backgroundViewHeight);

    if (self.scrollEnabled) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {
        }];
    }else {
        self.frame = toFrame;
    }
}

#pragma mark - Private

- (CGFloat)getBackgroundViewWidth:(CGRect)cellFrame
{
    if (self.backgroundViewWidth == JXCategoryViewAutomaticDimension) {
        return cellFrame.size.width  + self.backgroundViewWidthIncrement;
    }
    return self.backgroundViewWidth + self.backgroundViewWidthIncrement;
}

- (CGFloat)getBackgroundViewCornerRadius {
    if (self.backgroundViewCornerRadius == JXCategoryViewAutomaticDimension) {
        return self.backgroundViewHeight/2;
    }
    return self.backgroundViewCornerRadius;
}

@end
