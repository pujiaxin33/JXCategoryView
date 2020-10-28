//
//  BackgroundImageViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "BackgroundImageViewController.h"
#import "JXCategoryTitleView.h"

@interface BackgroundImageViewController ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation BackgroundImageViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titles = @[@"周杰伦", @"王力宏", @"林俊杰", @"潘玮柏", @"陶吉吉", @"薛之谦", @"五月天", @"毛不易"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"最佳男歌手们";
    
    // 初始化分页菜单视图
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColorGradientEnabled = YES;

    // 初始化指示器视图
    JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
    indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"light"];
    indicatorImageView.indicatorImageViewSize = CGSizeMake(50, 50);
    self.myCategoryView.indicators = @[indicatorImageView];
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

@end
