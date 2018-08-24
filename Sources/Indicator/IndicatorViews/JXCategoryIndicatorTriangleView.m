//
//  JXCategoryIndicatorTriangleView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorTriangleView.h"
#import "JXCategoryFactory.h"

@interface JXCategoryIndicatorTriangleView ()
@property (nonatomic, strong) CAShapeLayer *triangleLayer;
@end

@implementation JXCategoryIndicatorTriangleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _triangleViewSize = CGSizeMake(14, 10);
        _triangleViewColor = [UIColor redColor];

        _triangleLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.triangleLayer];
    }
    return self;
}

#pragma mark - JXCategoryComponentProtocol

- (void)jx_refreshState:(CGRect)selectedCellFrame {
    CGFloat x = selectedCellFrame.origin.x + (selectedCellFrame.size.width - self.triangleViewSize.width)/2;
    CGFloat y = self.superview.bounds.size.height - self.triangleViewSize.height - self.verticalMargin;
    if (self.componentPosition == JXCategoryComponentPosition_Top) {
        y = self.verticalMargin;
    }
    self.frame = CGRectMake(x, y, self.triangleViewSize.width, self.triangleViewSize.height);

    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    self.triangleLayer.fillColor = self.triangleViewColor.CGColor;
    self.triangleLayer.frame = self.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (self.componentPosition == JXCategoryComponentPosition_Bottom) {
        [path moveToPoint:CGPointMake(self.bounds.size.width/2, 0)];
        [path addLineToPoint:CGPointMake(0, self.bounds.size.height)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
    }else {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
        [path addLineToPoint:CGPointMake(self.bounds.size.width/2, self.bounds.size.height)];
    }
    [path closePath];
    self.triangleLayer.path = path.CGPath;
    [CATransaction commit];
}

- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(JXCategoryCellClickedPosition)selectedPosition percent:(CGFloat)percent {

    CGFloat targetWidth = self.triangleViewSize.width;
    CGFloat targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;

    if (percent == 0) {
        targetX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2.0;
    }else {
        CGFloat leftX = leftCellFrame.origin.x + (leftCellFrame.size.width - targetWidth)/2;
        CGFloat rightX = rightCellFrame.origin.x + (rightCellFrame.size.width - targetWidth)/2;
        targetX = [JXCategoryFactory interpolationFrom:leftX to:rightX percent:percent];
    }

    //允许变动frame的情况：1、允许滚动；2、不允许滚动，但是已经通过手势滚动切换一页内容了；
    if (self.scrollEnabled == YES || (self.scrollEnabled == NO && percent == 0)) {
        CGRect frame = self.frame;
        frame.origin.x = targetX;
        self.frame = frame;
    }
}

- (void)jx_selectedCell:(CGRect)cellFrame clickedRelativePosition:(JXCategoryCellClickedPosition)clickedRelativePosition {
    CGRect toFrame = self.frame;
    toFrame.origin.x = cellFrame.origin.x + (cellFrame.size.width - self.triangleViewSize.width)/2;
    if (self.scrollEnabled) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = toFrame;
        } completion:^(BOOL finished) {
        }];
    }else {
        self.frame = toFrame;
    }
}

@end
