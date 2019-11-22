//
//  SegmentedControlViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "SegmentedControlViewController.h"
#import "JXCategoryTitleView.h"

@interface SegmentedControlViewController ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation SegmentedControlViewController

- (void)viewDidLoad {
    self.titles = @[@"螃蟹", @"苹果", @"胡萝卜", @"葡萄", ];

    [super viewDidLoad];

    CGFloat totalItemWidth = self.view.bounds.size.width - 30*2;
    self.myCategoryView.layer.cornerRadius = 15;
    self.myCategoryView.layer.masksToBounds = YES;
    self.myCategoryView.layer.borderColor = [UIColor redColor].CGColor;
    self.myCategoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.cellWidth = totalItemWidth/self.titles.count;
    self.myCategoryView.titleColor = [UIColor redColor];
    self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
    self.myCategoryView.titleLabelMaskEnabled = YES;

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 30;
    backgroundView.indicatorWidthIncrement = 0;
    backgroundView.indicatorColor = [UIColor redColor];
    self.myCategoryView.indicators = @[backgroundView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat totalItemWidth = self.view.bounds.size.width - 30*2;
    self.myCategoryView.frame = CGRectMake(30, 10, totalItemWidth, 30);
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 50;
}

@end
