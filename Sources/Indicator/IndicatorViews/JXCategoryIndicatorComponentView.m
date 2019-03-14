//
//  JXCategoryComponentBaseView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@implementation JXCategoryIndicatorComponentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _componentPosition = JXCategoryComponentPosition_Bottom;
        _scrollEnabled = YES;
        _verticalMargin = 0;
        _scrollAnimationDuration = 0.25;
        _indicatorWidth = JXCategoryViewAutomaticDimension;
        _indicatorWidthIncrement = 0;
        _indicatorHeight = 3;
        _indicatorCornerRadius = JXCategoryViewAutomaticDimension;
        _indicatorColor = [UIColor redColor];
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

- (CGFloat)indicatorWidthValue:(CGRect)cellFrame {
    if (self.indicatorWidth == JXCategoryViewAutomaticDimension) {
        return cellFrame.size.width + self.indicatorWidthIncrement;
    }
    return self.indicatorWidth + self.indicatorWidthIncrement;
}

- (CGFloat)indicatorHeightValue:(CGRect)cellFrame {
    if (self.indicatorHeight == JXCategoryViewAutomaticDimension) {
        return cellFrame.size.height;
    }
    return self.indicatorHeight;
}

- (CGFloat)indicatorCornerRadiusValue:(CGRect)cellFrame {
    if (self.indicatorCornerRadius == JXCategoryViewAutomaticDimension) {
        return [self indicatorHeightValue:cellFrame]/2;
    }
    return self.indicatorCornerRadius;
}

#pragma mark - JXCategoryIndicatorProtocol

- (void)jx_refreshState:(JXCategoryIndicatorParamsModel *)model {

}

- (void)jx_contentScrollViewDidScroll:(JXCategoryIndicatorParamsModel *)model {

}

- (void)jx_selectedCell:(JXCategoryIndicatorParamsModel *)model {
    
}

@end
