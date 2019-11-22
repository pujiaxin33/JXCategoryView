//
//  JXCategoryIndicatorSpringBackgroundView.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/20.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorSpringBackgroundView.h"

@implementation JXCategoryIndicatorSpringBackgroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.indicatorHeight = 20;
        self.scrollAnimationDuration = 0.5;
    }
    return self;
}

- (void)jx_selectedCell:(JXCategoryIndicatorParamsModel *)model {
    CGFloat width = [self indicatorWidthValue:model.selectedCellFrame];
    CGFloat height = [self indicatorHeightValue:model.selectedCellFrame];
    CGFloat x = model.selectedCellFrame.origin.x + (model.selectedCellFrame.size.width - width)/2;
    CGFloat y = (model.selectedCellFrame.size.height - height)/2;
    CGRect toFrame = CGRectMake(x, y, width, height);

    if (self.isScrollEnabled) {
        [UIView animateWithDuration:self.scrollAnimationDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.frame = toFrame;
        } completion:nil];
    }else {
        self.frame = toFrame;
    }
}

@end
