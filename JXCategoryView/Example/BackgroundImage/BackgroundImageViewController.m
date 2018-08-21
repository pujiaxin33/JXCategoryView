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
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation BackgroundImageViewController

- (void)viewDidLoad {
    _titles = @[@"周杰伦", @"王力宏", @"林俊杰", @"潘玮柏", @"陶吉吉", @"薛之谦", @"五月天", @"毛不易"];

    [super viewDidLoad];

    self.title = @"最佳男歌手们";

    self.myCategoryView.titles = self.titles;
    self.myCategoryView.titleColorGradientEnabled = YES;

    JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
    indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"light"];
    indicatorImageView.indicatorImageViewSize = CGSizeMake(50, 50);
    self.myCategoryView.indicators = @[indicatorImageView];
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


@end
