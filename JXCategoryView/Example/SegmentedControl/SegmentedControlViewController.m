//
//  SegmentedControlViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "SegmentedControlViewController.h"
#import "ListViewController.h"
#import "JXCategoryTitleView.h"

#define WindowsSize [UIScreen mainScreen].bounds.size

static const CGFloat categoryViewHeight = 30;

@interface SegmentedControlViewController () <JXCategoryViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@end

@implementation SegmentedControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    NSArray *titles = @[@"螃蟹", @"苹果", @"胡萝卜", @"葡萄", ];

    CGFloat naviHeight = 64;
    if (@available(iOS 11.0, *)) {
        if (WindowsSize.height == 812) {
            naviHeight = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top + 44;
        }
    }
    CGFloat width = WindowsSize.width;
    CGFloat height = WindowsSize.height - naviHeight - categoryViewHeight;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, width, height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width*titles.count, height);
    [self.view addSubview:self.scrollView];

    for (int i = 0; i < titles.count; i ++) {
        ListViewController *listVC = [[ListViewController alloc] init];
        [self addChildViewController:listVC];
        listVC.view.frame = CGRectMake(i*width, 0, width, height);
        [self.scrollView addSubview:listVC.view];
    }

    self.categoryView.frame = CGRectMake(25, 10, WindowsSize.width - 50, categoryViewHeight);
    self.categoryView.layer.cornerRadius = 15;
    self.categoryView.layer.masksToBounds = YES;
    self.categoryView.layer.borderColor = [UIColor redColor].CGColor;
    self.categoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.categoryView.titles = titles;
    self.categoryView.delegate = self;
    self.categoryView.contentScrollView = self.scrollView;
    self.categoryView.cellSpacing = 0;
    self.categoryView.titleColor = [UIColor redColor];
    self.categoryView.titleSelectedColor = [UIColor whiteColor];
    self.categoryView.indicatorLineViewShowEnabled = NO;
    self.categoryView.backEllipseLayerShowEnabled = YES;
    self.categoryView.backEllipseLayerHeight = 30;
    self.categoryView.backEllipseLayerColor = [UIColor redColor];
    [self.view addSubview:self.categoryView];
}

- (JXCategoryTitleView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [[JXCategoryTitleView alloc] init];
    }
    return _categoryView;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

@end
