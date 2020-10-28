//
//  VerticalSectionHeaderView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "VerticalSectionHeaderView.h"

@implementation VerticalSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];

        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(16, (self.bounds.size.height - self.titleLabel.bounds.size.height)/2, 200, self.titleLabel.bounds.size.height);
}

@end
