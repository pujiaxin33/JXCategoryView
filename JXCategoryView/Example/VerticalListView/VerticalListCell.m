//
//  VerticalListCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "VerticalListCell.h"

@implementation VerticalListCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 10;

        _titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.titleLabel];

        _itemImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.itemImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.itemImageView.bounds = CGRectMake(0, 0, 50, 50);
    self.itemImageView.center = CGPointMake(self.bounds.size.width/2, 30);

    self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.itemImageView.frame) + 5, self.bounds.size.width, 30);
}

@end
