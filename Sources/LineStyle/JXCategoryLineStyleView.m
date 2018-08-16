//
//  JXCategoryLineStyleView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryLineStyleView.h"

@implementation JXCategoryLineStyleView

- (void)initializeDatas {
    [super initializeDatas];

    _lineScrollOffsetX = 10;
}

- (void)setLineStyle:(JXCategoryLineStyle)lineStyle {
    _lineStyle = lineStyle;

    self.indicatorViewPanGestureManualEnabled = (lineStyle != JXCategoryLineStyle_None);
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    [super contentOffsetOfContentScrollViewDidChanged:contentOffset];

    if (!self.indicatorViewPanGestureManualEnabled) {
        return;
    }

    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;

    if (!(self.indicatorViewScrollEnabled == YES ||
        (self.indicatorViewScrollEnabled == NO && remainderRatio == 0))) {
        return;
    }

    CGFloat totalXOfIndicatorLineView = self.cellSpacing;
    CGFloat targetindicatorLineWidth = [self getIndicatorLineViewWidthWithIndex:baseIndex];
    CGFloat leftIndicatorLineWidth = targetindicatorLineWidth;
    CGFloat rightIndicatorLineWidth = [self getIndicatorLineViewWidthWithIndex:baseIndex + 1];

    if (self.lineStyle == JXCategoryLineStyle_JD) {
        if (remainderRatio == 0) {
            CGRect cellFrame = [self getTargetCellFrame:baseIndex];
            totalXOfIndicatorLineView = cellFrame.origin.x + (cellFrame.size.width - leftIndicatorLineWidth)/2.0;
        }else {
            CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];
            CGRect rightCellFrame = [self getTargetCellFrame:baseIndex+1];

            CGFloat leftXOfIndicatorLineView = leftCellFrame.origin.x + (leftCellFrame.size.width - leftIndicatorLineWidth)/2;
            CGFloat rightXOfIndicatorLineView = rightCellFrame.origin.x + (rightCellFrame.size.width - rightIndicatorLineWidth)/2;
            CGFloat maxWidth = rightXOfIndicatorLineView - leftXOfIndicatorLineView + rightIndicatorLineWidth;
            //前50%，只增加width；后50%，移动x并减小width
            if (remainderRatio <= 0.5) {
                totalXOfIndicatorLineView = leftXOfIndicatorLineView;
                targetindicatorLineWidth = [self interpolationFrom:leftIndicatorLineWidth to:maxWidth percent:remainderRatio*2];
            }else {
                totalXOfIndicatorLineView = [self interpolationFrom:leftXOfIndicatorLineView to:rightXOfIndicatorLineView percent:(remainderRatio - 0.5)*2];
                targetindicatorLineWidth = [self interpolationFrom:maxWidth to:rightIndicatorLineWidth percent:(remainderRatio - 0.5)*2];
            }
        }
    }else if (self.lineStyle == JXCategoryLineStyle_IQIYI) {
        if (remainderRatio == 0) {
            CGRect cellFrame = [self getTargetCellFrame:baseIndex];
            totalXOfIndicatorLineView = cellFrame.origin.x + (cellFrame.size.width - leftIndicatorLineWidth)/2.0;
        }else {
            CGRect leftCellFrame = [self getTargetCellFrame:baseIndex];
            CGRect rightCellFrame = [self getTargetCellFrame:baseIndex+1];

            CGFloat leftXOfIndicatorLineView = leftCellFrame.origin.x + (leftCellFrame.size.width - leftIndicatorLineWidth)/2;
            CGFloat rightXOfIndicatorLineView = rightCellFrame.origin.x + (rightCellFrame.size.width - rightIndicatorLineWidth)/2;
            //前50%，增加width，并少量移动x；后50%，少量移动x并减小width
            CGFloat offsetX = self.lineScrollOffsetX;//x的少量偏移量
            CGFloat maxWidth = rightXOfIndicatorLineView - leftXOfIndicatorLineView + rightIndicatorLineWidth - offsetX*2;
            if (remainderRatio <= 0.5) {
                totalXOfIndicatorLineView = [self interpolationFrom:leftXOfIndicatorLineView to:leftXOfIndicatorLineView + offsetX percent:remainderRatio*2];;
                targetindicatorLineWidth = [self interpolationFrom:leftIndicatorLineWidth to:maxWidth percent:remainderRatio*2];
            }else {
                totalXOfIndicatorLineView = [self interpolationFrom:(leftXOfIndicatorLineView + offsetX) to:rightXOfIndicatorLineView percent:(remainderRatio - 0.5)*2];
                targetindicatorLineWidth = [self interpolationFrom:maxWidth to:rightIndicatorLineWidth percent:(remainderRatio - 0.5)*2];
            }
        }
    }

    CGRect frame = self.indicatorLineView.frame;
    frame.origin.x = totalXOfIndicatorLineView;
    frame.size.width = targetindicatorLineWidth;
    self.indicatorLineView.frame = frame;
}

@end

