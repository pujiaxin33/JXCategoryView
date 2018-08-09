//
//  JXCategoryBackgroundImageView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryBackgroundImageView.h"

@interface JXCategoryBackgroundImageView()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation JXCategoryBackgroundImageView

- (void)initializeDatas {
    [super initializeDatas];

    _backgroundImageViewShowEnabled = NO;
    _backgroundImageViewSize = CGSizeMake(30, 30);
}

- (void)initializeViews {
    [super initializeViews];

    _backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundImageView.hidden = !self.backgroundImageViewShowEnabled;
    self.backgroundImageView.bounds = CGRectMake(0, 0, self.backgroundImageViewSize.width, self.backgroundImageViewSize.height);
    [self.backgroundContainerView addSubview:self.backgroundImageView];
    UIViewAutoresizing mask = UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleRightMargin;
    self.backgroundImageView.autoresizingMask = mask;
}

- (void)refreshState {
    [super refreshState];

    self.backgroundImageView.hidden = !self.backgroundImageViewShowEnabled;
}



@end
