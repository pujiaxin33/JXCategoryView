//
//  AlignmentLineExampleViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/20.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "AlignmentLineExampleViewController.h"
#import "JXCategoryIndicatorAlignmentLineView.h"

@interface AlignmentLineExampleViewController ()

@property (nonatomic, assign) JXCategoryIndicatorAlignmentStyle currentStyle;

@end

@implementation AlignmentLineExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentStyle = JXCategoryIndicatorAlignmentStyleLeading;
    [self refreshNaviRightItem];

    JXCategoryIndicatorAlignmentLineView *lineView = [[JXCategoryIndicatorAlignmentLineView alloc] init];
    lineView.indicatorWidth = 20;
    ((JXCategoryIndicatorView *)self.categoryView).indicators = @[lineView];
}

- (void)refreshNaviRightItem {
    NSString *naviItemTitle = @"";
    if (self.currentStyle == JXCategoryIndicatorAlignmentStyleLeading) {
        naviItemTitle = @"左对齐";
    }else {
        naviItemTitle = @"右对齐";
    }
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:naviItemTitle style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemClicked {
    if (self.currentStyle == JXCategoryIndicatorAlignmentStyleLeading) {
        self.currentStyle = JXCategoryIndicatorAlignmentStyleTrailing;
    }else {
        self.currentStyle = JXCategoryIndicatorAlignmentStyleLeading;
    }
    JXCategoryIndicatorView *componentView = (JXCategoryIndicatorView *)self.categoryView;
    for (JXCategoryIndicatorComponentView *view in componentView.indicators) {
        if ([view isKindOfClass:[JXCategoryIndicatorAlignmentLineView class]]) {
            ((JXCategoryIndicatorAlignmentLineView *)view).alignmentStyle = self.currentStyle;
        }
    }
    [componentView reloadData];
    [self refreshNaviRightItem];
}

@end
