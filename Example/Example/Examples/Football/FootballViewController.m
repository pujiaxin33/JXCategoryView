//
//  FootballViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/10.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "FootballViewController.h"

@interface FootballViewController ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation FootballViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titles = @[@"中国U-19", @"中国超级联赛", @"亚足联冠军联赛", @"亚运会足球赛", @"世界杯🎉"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isNeedIndicatorPositionChangeItem = YES;

    // 初始化分页菜单视图
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColorGradientEnabled = YES;

    // 初始化指示器视图
    JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
    // MARK: 开启图片滚动效果
    indicatorImageView.indicatorImageViewRollEnabled = YES;
    indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"football"];
    self.myCategoryView.indicators = @[indicatorImageView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.categoryView.frame = CGRectMake(0, 20, WindowsSize.width, 60);
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return 100;
}

@end
