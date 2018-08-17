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
    self.frame = CGRectMake(x, self.superview.bounds.size.height - self.indicatorLineViewHeight, selectedLineWidth, self.indicatorLineViewHeight);
}

- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame isLeftCellSelected:(BOOL)isLeftCellSelected percent:(CGFloat)percent {

    CGFloat targetLineViewX = leftCellFrame.origin.x;
    CGFloat targetLineWidth = [self getIndicatorLineViewWidth:leftCellFrame];

    if (percent == 0) {
        targetLineViewX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetLineWidth)/2.0;
    }else {
        CGFloat leftLineWidth = targetLineWidth;
        CGFloat rightLineWidth = [self getIndicatorLineViewWidth:rightCellFrame];

        CGFloat leftLineViewX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftLineWidth)/2;
        CGFloat rightLineViewX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightLineWidth)/2;

        if (self.lineStyle == JXCategoryIndicatorLineStyle_Normal) {
            targetLineViewX = [JXCategoryFactory interpolationFrom:leftLineViewX to:rightLineViewX percent:percent];

            if (self.indicatorLineWidth == JXCategoryViewAutomaticDimension) {
                targetLineWidth = [JXCategoryFactory interpolationFrom:leftCellFrame.size.width to:rightCellFrame.size.width percent:percent];
            }
        }else if (self.lineStyle == JXCategoryIndicatorLineStyle_JD) {
            CGFloat maxWidth = rightLineViewX - leftLineViewX + rightLineWidth;
            //前50%，只增加width；后50%，移动x并减小width
            if (percent <= 0.5) {
                targetLineViewX = leftLineViewX;
                targetLineWidth = [JXCategoryFactory interpolationFrom:leftLineWidth to:maxWidth percent:percent*2];
            }else {
                targetLineViewX = [JXCategoryFactory interpolationFrom:leftLineViewX to:rightLineViewX percent:(percent - 0.5)*2];
                targetLineWidth = [JXCategoryFactory interpolationFrom:maxWidth to:rightLineWidth percent:(percent - 0.5)*2];
            }
        }else if (self.lineStyle == JXCategoryIndicatorLineStyle_IQIYI) {
            //前50%，增加width，并少量移动x；后50%，少量移动x并减小width
            CGFloat offsetX = self.lineScrollOffsetX;//x的少量偏移量
            CGFloat maxWidth = rightLineViewX - leftLineViewX + rightLineWidth - offsetX*2;
            if (percent <= 0.5) {
                targetLineViewX = [JXCategoryFactory interpolationFrom:leftLineViewX to:leftLineViewX + offsetX percent:percent*2];;
                targetLineWidth = [JXCategoryFactory interpolationFrom:leftLineWidth to:maxWidth percent:percent*2];
            }else {
                targetLineViewX = [JXCategoryFactory interpolationFrom:(leftLineViewX + offsetX) to:rightLineViewX percent:(percent - 0.5)*2];
                targetLineWidth = [JXCategoryFactory interpolationFrom:maxWidth to:rightLineWidth percent:(percent - 0.5)*2];
            }
        }
    }

    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetLineViewX;
        frame.size.width = targetLineWidth;
        self.frame = frame;
    }
}

- (void)jx_selectedCell:(CGRect)cellFrame isLeftCellSelected:(BOOL)isLeftCellSelected {
    CGFloat targetLineWidth = [self getIndicatorLineViewWidth:cellFrame];
    CGRect toFrame = CGRectMake(cellFrame.origin.x + (cellFrame.size.width - targetLineWidth)/2.0, self.superview.bounds.size.height - self.indicatorLineViewHeight, targetLineWidth, self.indicatorLineViewHeight);
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
