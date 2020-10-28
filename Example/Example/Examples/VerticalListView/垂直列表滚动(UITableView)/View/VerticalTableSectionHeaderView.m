//
//  VerticalTableSectionHeaderView.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/12.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "VerticalTableSectionHeaderView.h"

@implementation VerticalTableSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];

        self.textLabel.textColor = [UIColor lightGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

@end
