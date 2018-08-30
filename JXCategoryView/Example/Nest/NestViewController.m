//
//  NestViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "NestViewController.h"
#import "JXCategoryTitleView.h"
#import "TitleViewController.h"

@interface NestViewController ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation NestViewController

- (void)viewDidLoad {
    _titles = @[@"主题一", @"主题二", @"主题三", ];

    [super viewDidLoad];

    self.myCategoryView.titles = self.titles;

    self.categoryView.frame = CGRectMake(0, 0, 180, 30);
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

- (CGFloat)preferredCategoryViewHeight {
    return 0;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleView class];
}

- (Class)preferredListViewControllerClass {
    return [TitleViewController class];
}

- (void)configListViewController:(UIViewController *)controller index:(NSUInteger)index {
    TitleViewController *listController = (TitleViewController *)controller;
    listController.shouldHandleScreenEdgeGesture = NO;
    if (index == 0) {
        listController.titles = @[@"香蕉", @"苹果", @"荔枝"];
    }else if(index == 1) {
        listController.titles = @[@"冰淇淋", @"可乐"];
    }else if (index == 2) {
        listController.titles = @[@"火锅", @"砂锅", @"干锅"];
    }

    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)listController.categoryView;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc ]init];
    titleCategoryView.indicators = @[lineView];
}

@end
