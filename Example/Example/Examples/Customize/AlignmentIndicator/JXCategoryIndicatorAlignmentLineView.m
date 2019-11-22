//
//  JXCategoryIndicatorAlignmentLineView.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/20.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorAlignmentLineView.h"
#import "JXCategoryFactory.h"

@implementation JXCategoryIndicatorAlignmentLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _alignmentStyle = JXCategoryIndicatorAlignmentStyleLeading;
        self.indicatorHeight = 3;
        self.indicatorWidth = 20;   //不支持JXCategoryViewAutomaticDimension
    }
    return self;
}

#pragma mark - JXCategoryIndicatorProtocol

- (void)jx_refreshState:(JXCategoryIndicatorParamsModel *)model {
    self.backgroundColor = self.indicatorColor;
    self.layer.cornerRadius = [self indicatorCornerRadiusValue:model.selectedCellFrame];

    CGFloat selectedLineWidth = [self indicatorWidthValue:model.selectedCellFrame];
    CGFloat x = model.selectedCellFrame.origin.x;
    if (self.alignmentStyle == JXCategoryIndicatorAlignmentStyleTrailing) {
        x = model.selectedCellFrame.origin.x + model.selectedCellFrame.size.width - selectedLineWidth;
    }
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
    CGFloat targetWidth = [self indicatorWidthValue:leftCellFrame];

    CGFloat leftWidth = targetWidth;
    CGFloat rightWidth = targetWidth;
    CGFloat leftX = leftCellFrame.origin.x;
    CGFloat rightX = rightCellFrame.origin.x;
    if (self.alignmentStyle == JXCategoryIndicatorAlignmentStyleTrailing) {
        leftX = leftCellFrame.origin.x + leftCellFrame.size.width - targetWidth;
        rightX = rightCellFrame.origin.x + rightCellFrame.size.width - targetWidth;
    }

    CGFloat targetX = [JXCategoryFactory interpolationFrom:leftX to:rightX percent:percent];
    if (self.indicatorWidth == JXCategoryViewAutomaticDimension) {
        targetWidth = [JXCategoryFactory interpolationFrom:leftWidth to:rightWidth percent:percent];
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
    CGRect targetIndicatorFrame = self.frame;
    CGFloat targetIndicatorWidth = [self indicatorWidthValue:model.selectedCellFrame];
    targetIndicatorFrame.origin.x = model.selectedCellFrame.origin.x;
    if (self.alignmentStyle == JXCategoryIndicatorAlignmentStyleTrailing) {
        targetIndicatorFrame.origin.x = model.selectedCellFrame.origin.x + model.selectedCellFrame.size.width - targetIndicatorWidth;
    }
    targetIndicatorFrame.size.width = targetIndicatorWidth;
    if (self.isScrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.frame = targetIndicatorFrame;
        } completion: nil];
    }else {
        self.frame = targetIndicatorFrame;
    }
}

@end
