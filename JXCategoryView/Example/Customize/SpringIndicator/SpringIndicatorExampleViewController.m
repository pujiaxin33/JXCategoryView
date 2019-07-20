//
//  SpringIndicatorExampleViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/20.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "SpringIndicatorExampleViewController.h"
#import "JXCategoryIndicatorSpringBackgroundView.h"

@interface SpringIndicatorExampleViewController ()

@end

@implementation SpringIndicatorExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    JXCategoryIndicatorSpringBackgroundView *lineView = [[JXCategoryIndicatorSpringBackgroundView alloc] init];
    ((JXCategoryIndicatorView *)self.categoryView).indicators = @[lineView];
}


@end
