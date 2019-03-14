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
        self.indicatorHeight = 3;
    }
    return self;
}

#pragma mark - JXCategoryIndicatorProtocol

- (void)jx_refreshState:(JXCategoryIndicatorParamsModel *)model {
    self.backgroundColor = self.indicatorColor;
    self.layer.cornerRadius = [self indicatorCornerRadiusValue:model.selectedCellFrame];

    CGFloat selectedLineWidth = [self indicatorWidthValue:model.selectedCellFrame];
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - selectedLineWidth)/2;
    CGFloat y = self.superview.bounds.size.height - [self indicatorHeightValue:model.selectedCellFrame] - self.verticalMargin;
    if (self.componentPosition == JXCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, selectedLineWidth, [self indicatorHeightValue:model.selectedCellFrame]);
}

- (void)jx_contentScrollViewDidScroll:(JXCategoryIndicatorParamsModel *)model {
    CGRect rightCellFrame = model.rightCellFrame;
    CGRect leftCellFrame = model.leftCellFrame;
    CGFloat percent = model.percent;
    CGFloat targetX = leftCellFrame.origin.x;
    CGFloat targetWidth = [self indicatorWidthValue:leftCellFrame];

    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftWidth = targetWidth;
        CGFloat rightWidth = [self indicatorWidthValue:rightCellFrame];

        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - leftWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - rightWidth)/2;

        if (self.lineStyle == JXCategoryIndicatorLineStyle_Normal) {
            targetX = [JXCategoryFactory interpolationFrom:leftX to:rightX percent:percent];

            if (self.indicatorWidth == JXCategoryViewAutomaticDimension) {
                targetWidth = [JXCategoryFactory interpolationFrom:leftWidth to:rightWidth percent:percent];
            }
        }else if (self.lineStyle == JXCategoryIndicatorLineStyle_Lengthen) {
            CGFloat maxWidth = rightX - leftX + rightWidth;
            //前50%，只增加width；后50%，移动x并减小width
            if (percent <= 0.5) {
                targetX = leftX;
                targetWidth = [JXCategoryFactory interpolationFrom:leftWidth to:maxWidth percent:percent*2];
            }else {
                targetX = [JXCategoryFactory interpolationFrom:leftX to:rightX percent:(percent - 0.5)*2];
                targetWidth = [JXCategoryFactory interpolationFrom:maxWidth to:rightWidth percent:(percent - 0.5)*2];
            }
        }else if (self.lineStyle == JXCategoryIndicatorLineStyle_LengthenOffset) {
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
    if (self.isScrollEnabled == YES || (self.isScrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetX;
        frame.size.width = targetWidth;
        self.frame = frame;
    }
}

- (void)jx_selectedCell:(JXCategoryIndicatorParamsModel *)model {
    CGFloat targetWidth = [self indicatorWidthValue:model.selectedCellFrame];
    CGRect toFrame = self.frame;
    toFrame.origin.x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - targetWidth)/2.0;
    toFrame.size.width = targetWidth;

    if (self.isScrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {

        }];
    }else {
        self.frame = toFrame;
    }
}

@end

@implementation JXCategoryIndicatorLineView (JXDeprecated)

@dynamic indicatorLineWidth;
@dynamic indicatorLineViewHeight;
@dynamic indicatorLineViewCornerRadius;
@dynamic indicatorLineViewColor;

- (void)setIndicatorLineWidth:(CGFloat)indicatorLineWidth {
    self.indicatorWidth = indicatorLineWidth;
}

- (CGFloat)indicatorLineWidth {
    return self.indicatorWidth;
}

- (void)setIndicatorLineViewHeight:(CGFloat)indicatorLineViewHeight {
    self.indicatorHeight = indicatorLineViewHeight;
}

- (CGFloat)indicatorLineViewHeight {
    return self.indicatorHeight;
}

- (void)setIndicatorLineViewCornerRadius:(CGFloat)indicatorLineViewCornerRadius {
    self.indicatorCornerRadius = indicatorLineViewCornerRadius;
}

- (CGFloat)indicatorLineViewCornerRadius {
    return self.indicatorCornerRadius;
}

- (void)setIndicatorLineViewColor:(UIColor *)indicatorLineViewColor {
    self.indicatorColor = indicatorLineViewColor;
}

- (UIColor *)indicatorLineViewColor {
    return self.indicatorColor;
}

@end
