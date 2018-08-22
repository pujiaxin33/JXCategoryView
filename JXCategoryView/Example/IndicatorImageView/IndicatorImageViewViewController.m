//
//  IndicatorImageViewViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "IndicatorImageViewViewController.h"
#import "JXCategoryTitleView.h"

@interface IndicatorImageViewViewController () <JXCategoryViewDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) UIImageView *bgSelectedImageView;
@property (nonatomic, strong) UIImageView *bgUnselectedImageView;
@end

@implementation IndicatorImageViewViewController

- (void)viewDidLoad {
    _titles = @[@"荷花", @"河流", @"海洋", @"城市", ];
    self.isNeedIndicatorPositionChangeItem = YES;

    [super viewDidLoad];

    self.categoryView.frame = CGRectMake(30, 20, WindowsSize.width - 30*2, 60);
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColor = [UIColor whiteColor];
    self.myCategoryView.titleSelectedColor = [UIColor redColor];
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.titleLabelZoomEnabled = YES;

    JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
    indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"boat"];
    self.myCategoryView.indicators = @[indicatorImageView];

    CGRect bgImageViewFrame = CGRectMake(0, 0, WindowsSize.width, 100);
    _bgSelectedImageView = [[UIImageView alloc] initWithFrame:bgImageViewFrame];
    self.bgSelectedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgSelectedImageView.image = [self getImageWithIndex:0];
    [self.view addSubview:self.bgSelectedImageView];

    _bgUnselectedImageView = [[UIImageView alloc] initWithFrame:bgImageViewFrame];
    self.bgUnselectedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgUnselectedImageView.image = [self getImageWithIndex:1];
    [self.view addSubview:self.bgUnselectedImageView];

    [self.view sendSubviewToBack:self.bgSelectedImageView];
    [self.view sendSubviewToBack:self.bgUnselectedImageView];
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
    return 100;
}

- (UIImage *)getImageWithIndex:(NSInteger)index {
    NSArray <UIImage *> *images = @[[UIImage imageNamed:@"lotus"],
                        [UIImage imageNamed:@"river"],
                        [UIImage imageNamed:@"seaWave"],
                        [UIImage imageNamed:@"city"]];
    return images[index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    if (self.categoryView.selectedIndex == leftIndex) {
        //从左往右滑动
        self.bgUnselectedImageView.image = [self getImageWithIndex:rightIndex];
        self.bgSelectedImageView.alpha = 1 - ratio;
        self.bgUnselectedImageView.alpha = ratio;
    }else {
        //从右往左滑动
        self.bgUnselectedImageView.image = [self getImageWithIndex:leftIndex];
        self.bgSelectedImageView.alpha = ratio;
        self.bgUnselectedImageView.alpha = 1 - ratio;
    }
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);

    self.bgSelectedImageView.alpha = 1;
    self.bgUnselectedImageView.alpha = 0;
    self.bgSelectedImageView.image = [self getImageWithIndex:index];
}

@end
