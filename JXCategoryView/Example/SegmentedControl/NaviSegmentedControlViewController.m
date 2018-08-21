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
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation NaviSegmentedControlViewController

- (void)viewDidLoad {
    _titles = @[@"螃蟹", @"苹果" ];

    [super viewDidLoad];

    self.categoryView.frame = CGRectMake(0, 0, 120, 30);
    self.myCategoryView.layer.cornerRadius = 15;
    self.myCategoryView.layer.masksToBounds = YES;
    self.myCategoryView.layer.borderColor = [UIColor redColor].CGColor;
    self.myCategoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.titleColor = [UIColor redColor];
    self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
    self.myCategoryView.titleLabelMaskEnabled = YES;

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewHeight = 30;
    backgroundView.backgroundViewWidthIncrement = 0;
    backgroundView.backgroundViewColor = [UIColor redColor];
    self.myCategoryView.indicators = @[backgroundView];

    [self.myCategoryView removeFromSuperview];
    self.navigationItem.titleView = self.myCategoryView;
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleView class];
}

- (CGFloat)preferredCategoryViewHeight {
    return 0;
}

@end
