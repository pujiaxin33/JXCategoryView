//
//  JXCategoryIndicatorLineView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorLineView.h"
#import "JXCategoryFactory.h"
#import "JXCategoryViewDefines.h"

@implementation JXCategoryIndicatorLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineStyle = JXCategoryIndicatorLineStyle_Normal;
        _lineScrollOffsetX = 10;
        _indicatorLineViewHeight = 3;
        _indicatorLineWidth = JXCategoryViewAutomaticDimension;
        _indicatorLineViewColor = [UIColor redColor];
        _indicatorLineViewCornerRadius = JXCategoryViewAutomaticDimension;
    }
    return self;
}

#pragma mark - JXCategoryComponentProtocol

- (void)jx_refreshState:(CGRect)selectedCellFrame {
    self.backgroundColor = self.indicatorLineViewColor;
    self.layer.cornerRadius = [self getIndicatorLineViewCornerRadius];

    CGFloat selectedLineWidth = [self getIndicatorLineViewWidth:selectedCellFrame];
    CGFloat x = selectedCellFrame.origin.x + (selectedCellFrame.size.width - selectedLineWidth)/2;
    CGFloat y = self.superview.bounds.size.height - self.indicatorLineViewHeight - self.verticalMargin;
    if (self.componentPosition == JXCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, selectedLineWidth, self.indicatorLineViewHeight);
}

- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(JXCategoryCellClickedPosition)selectedPosition percent:(CGFloat)percent {

    CGFloat targetX = leftCellFrame.origin.x;
    CGFloat targetWidth = [self getIndicatorLineViewWidth:leftCellFrame];

    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = [self getIndicatorLineViewWidth:rightCellFrame];

        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;

        if (self.lineStyle == JXCategoryIndicatorLineStyle_Normal) {
            targetX = [JXCategoryFactory interpolationFrom:leftX to:rightX percent:percent];

            if (self.indicatorLineWidth == JXCategoryViewAutomaticDimension) {
                targetWidth = [JXCategoryFactory interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:percent];
            }
        }else if (self.lineStyle == JXCategoryIndicatorLineStyle_JD) {
            CGFloat maxWidth = rightX - leftX + rightWidth;
            //前50%，只增加width；后50%，移动x并减小width
            if (percent <= 0.5) {
                targetX = leftX;
                targetWidth = [JXCategoryFactory interpolationFrom:leftWidth to:maxWidth percent:percent*2];
            }else {
                targetX = [JXCategoryFactory interpolationFrom:leftX to:rightX percent:(percent - 0.5)*2];
                targetWidth = [JXCategoryFactory interpolationFrom:maxWidth to:rightWidth percent:(percent - 0.5)*2];
            }
        }else if (self.lineStyle == JXCategoryIndicatorLineStyle_IQIYI) {
            //前50%，增加width，并少量移动x；后50%，少量移动x并减小width
            CGFloat offsetX = self.lineScrollOffsetX;//x的少量偏移量
            CGFloat maxWidth = rightX - leftX + rightWidth - offsetX*2;
            if (percent <= 0.5) {
                targetX = [JXCategoryFactory interpolationFrom:leftX to:leftX + offsetX percent:percent*2];;
                targetWidth = [JXCategoryFactory interpolationFrom:leftWidth to:maxWidth percent:percent*2];
            }else {
                targetX = [JXCategoryFactory interpolationFrom:(leftX + offsetX) to:rightX percent:(percent - 0.5)*2];
                targetWidth = [JXCategoryFactory interpolationFrom:maxWidth to:rightWidth percent:(percent - 0.5)*2];
            }
        }
    }

    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetX;
        frame.size.width = targetWidth;
        self.frame = frame;
    }
}

- (void)jx_selectedCell:(CGRect)cellFrame clickedRelativePosition:(JXCategoryCellClickedPosition)clickedRelativePosition isClicked:(BOOL)isClicked {
    CGFloat targetWidth = [self getIndicatorLineViewWidth:cellFrame];
    CGRect toFrame = self.frame;
    toFrame.origin.x = cellFrame.origin.x + (cellFrame.size.width - targetWidth)/2.0;
    toFrame.size.width = targetWidth;

    if (self.scrollEnabled) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {

        }];
    }else {
        self.frame = toFrame;
    }
}

# pragma mark - Private

- (CGFloat)getIndicatorLineViewCornerRadius
{
    if (self.indicatorLineViewCornerRadius == JXCategoryViewAutomaticDimension) {
        return self.indicatorLineViewHeight/2;
    }
    return self.indicatorLineViewCornerRadius;
}

- (CGFloat)getIndicatorLineViewWidth:(CGRect)cellFrame
{
    if (self.indicatorLineWidth == JXCategoryViewAutomaticDimension) {
        return cellFrame.size.width;
    }
    return self.indicatorLineWidth;
}

@end
