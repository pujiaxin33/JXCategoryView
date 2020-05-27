//
//  ScrollUpNavigationBar.m
//  Example
//
//  Created by jiaxin on 2020/5/22.
//  Copyright © 2020 jiaxin. All rights reserved.
//

#import "ScrollUpNavigationBar.h"
#import "UIWindow+JXSafeArea.h"

@interface ScrollUpNavigationBar()
@property (nonatomic, strong) UIStackView *stack;
@property (nonatomic, strong) UIView *line;
@end

@implementation ScrollUpNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _stack = [[UIStackView alloc] init];
        self.stack.axis = UILayoutConstraintAxisHorizontal;
        self.stack.distribution = UIStackViewDistributionEqualCentering;
        [self addSubview:self.stack];

        UIButton *back = [UIButton buttonWithType:UIButtonTypeSystem];
        [back setTitle:@"返回" forState:UIControlStateNormal];
        [back addTarget:self action:@selector(didBackClick) forControlEvents:UIControlEventTouchUpInside];
        [self.stack addArrangedSubview:back];

        UILabel *title = [[UILabel alloc] init];
        title.text = @"ScrollUp示例";
        title.textColor = [UIColor blackColor];
        [self.stack addArrangedSubview:title];

        UIButton *right = [UIButton buttonWithType:UIButtonTypeSystem];
        [right setTitle:@"按钮" forState:UIControlStateNormal];
        [self.stack addArrangedSubview:right];

        _line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor blackColor];
        [self addSubview:self.line];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.stack.frame = CGRectMake(20, [UIApplication sharedApplication].keyWindow.jx_layoutInsets.top, self.bounds.size.width - 20*2, 44);
    self.line.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
}

- (void)didBackClick {
    !self.backBlock ?: self.backBlock();
}

@end
