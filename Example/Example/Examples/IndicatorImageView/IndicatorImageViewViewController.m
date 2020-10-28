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
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, strong) UIImageView *bgSelectedImageView;
@property (nonatomic, strong) UIImageView *bgUnselectedImageView;
@end

@implementation IndicatorImageViewViewController

#pragma mark - Initialize

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titles = @[@"荷花", @"河流", @"海洋", @"城市" ];
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isNeedIndicatorPositionChangeItem = YES;

    // 初始化分页菜单视图
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColor = [UIColor whiteColor];
    self.myCategoryView.titleSelectedColor = [UIColor redColor];
    self.myCategoryView.titleColorGradientEnabled = YES;
    self.myCategoryView.titleLabelZoomEnabled = YES;

    // 初始化指示器视图
    JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
    indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"boat"];
    self.myCategoryView.indicators = @[indicatorImageView];

    // 选中 cell 的背景图片视图
    CGRect bgImageViewFrame = CGRectMake(0, 0, WindowsSize.width, 100);
    _bgSelectedImageView = [[UIImageView alloc] initWithFrame:bgImageViewFrame];
    self.bgSelectedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgSelectedImageView.image = [self getImageWithIndex:0];
    [self.view addSubview:self.bgSelectedImageView];

    // 未选中 cell 的背景图片视图
    _bgUnselectedImageView = [[UIImageView alloc] initWithFrame:bgImageViewFrame];
    self.bgUnselectedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgUnselectedImageView.image = [self getImageWithIndex:1];
    [self.view addSubview:self.bgUnselectedImageView];

    [self.view sendSubviewToBack:self.bgSelectedImageView];
    [self.view sendSubviewToBack:self.bgUnselectedImageView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(30, 20, WindowsSize.width - 30*2, 60);
}

#pragma mark - Override

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 100;
}

#pragma mark - Private

- (UIImage *)getImageWithIndex:(NSInteger)index {
    NSArray<UIImage *> *images = @[[UIImage imageNamed:@"lotus"],
                                   [UIImage imageNamed:@"river"],
                                   [UIImage imageNamed:@"seaWave"],
                                   [UIImage imageNamed:@"city"]];
    return images[index];
}

#pragma mark - <JXCategoryViewDelegate>

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    // 侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);

    self.bgSelectedImageView.alpha = 1;
    self.bgUnselectedImageView.alpha = 0;
    self.bgSelectedImageView.image = [self getImageWithIndex:index];
}

// 正在滚动中的回调，这里调整背景图片的 alpha 透明度
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    if (self.categoryView.selectedIndex == leftIndex) {
        // 从左往右滑动
        self.bgUnselectedImageView.image = [self getImageWithIndex:rightIndex];
        self.bgSelectedImageView.alpha = 1 - ratio;
        self.bgUnselectedImageView.alpha = ratio;
    }else {
        // 从右往左滑动
        self.bgUnselectedImageView.image = [self getImageWithIndex:leftIndex];
        self.bgSelectedImageView.alpha = ratio;
        self.bgUnselectedImageView.alpha = 1 - ratio;
    }
}

@end
