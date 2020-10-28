//
//  NaviSegmentedControlViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/13.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "NaviSegmentedControlViewController.h"
#import "JXCategoryTitleView.h"

@interface NaviSegmentedControlViewController ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation NaviSegmentedControlViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titles = @[@"螃蟹", @"苹果"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myCategoryView.frame = CGRectMake(0, 0, 120, 30);
    self.myCategoryView.layer.cornerRadius = 15;
    self.myCategoryView.layer.masksToBounds = YES;
    self.myCategoryView.layer.borderColor = [UIColor redColor].CGColor;
    self.myCategoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.cellWidth = 120/2;
    self.myCategoryView.titleColor = [UIColor redColor];
    self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
    self.myCategoryView.titleLabelMaskEnabled = YES;

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 30;
    backgroundView.indicatorWidthIncrement = 0;
    backgroundView.indicatorColor = [UIColor redColor];
    self.myCategoryView.indicators = @[backgroundView];

    [self.myCategoryView removeFromSuperview];
    self.navigationItem.titleView = self.myCategoryView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.myCategoryView.frame = CGRectMake(0, 0, 120, 30);
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 0;
}

@end
