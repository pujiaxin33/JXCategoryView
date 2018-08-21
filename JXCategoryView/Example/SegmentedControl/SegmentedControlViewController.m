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
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation SegmentedControlViewController

- (void)viewDidLoad {
    _titles = @[@"螃蟹", @"苹果", @"胡萝卜", @"葡萄", ];

    [super viewDidLoad];

    self.categoryView.frame = CGRectMake(30, 10, WindowsSize.width - 30*2, 30);
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
    return 50;
}

@end
