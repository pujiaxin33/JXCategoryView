//
//  JXCategoryIndicatorDotLineView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorDotLineView.h"
#import "JXCategoryFactory.h"

@implementation JXCategoryIndicatorDotLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dotSize = CGSizeMake(10, 10);
        _lineWidth = 50;
        _dotLineViewColor = [UIColor redColor];
    }
    return self;
}

#pragma mark - JXCategoryIndicatorProtocol

- (void)jx_refreshState:(JXCategoryIndicatorParamsModel *)model {
    self.backgroundColor = self.dotLineViewColor;
    self.layer.cornerRadius = self.dotSize.height/2;

    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - self.dotSize.width)/2;
    CGFloat y = self.superview.bounds.size.height - self.dotSize.height - self.verticalMargin;
    if (self.componentPosition == JXCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);
}

- (void)jx_contentScrollViewDidScroll:(JXCategoryIndicatorParamsModel *)model {
    CGRect rightCellFrame = model.rightCellFrame;
    CGRect leftCellFrame = model.leftCellFrame;
    CGFloat percent = model.percent;
    CGFloat targetX = 0;
    CGFloat targetWidth = self.dotSize.width;

    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = self.dotSize.width;

        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;
        CGFloat centerX = leftX + (rightX - leftX - self.lineWidth)/2;

        //前50%，移动x，增加宽度；后50%，移动x并减小width
        if (percent <= 0.5) {
            targetX = [JXCategoryFactory interpolationFrom:leftX to:centerX percent:percent*2];
            targetWidth = [JXCategoryFactory interpolationFrom:self.dotSize.width to:self.lineWidth percent:percent*2];
        }else {
            targetX = [JXCategoryFactory interpolationFrom:centerX to:rightX percent:(percent - 0.5)*2];
            targetWidth = [JXCategoryFactory interpolationFrom:self.lineWidth to:self.dotSize.width percent:(percent - 0.5)*2];
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

- (void)jx_selectedCell:(JXCategoryIndicatorParamsModel *)model {
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - self.dotSize.width)/2;
    CGFloat y = self.superview.bounds.size.height - self.dotSize.height - self.verticalMargin;
    if (self.componentPosition == JXCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    CGRect toFrame = CGRectMake(x, y, self.dotSize.width, self.dotSize.height);

    if (self.scrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {

        }];
    }else {
        self.frame = toFrame;
    }
}

@end
