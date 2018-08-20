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
    _titles = @[@"周杰伦", @"林俊杰", @"潘玮柏", @"陶吉吉", @"孙燕姿", @"周星驰", @"成龙", @"甄子丹"];

    [super viewDidLoad];

    self.myCategoryView.titles = self.titles;

    JXCategoryIndicatorImageView *indicatorImageView = [[JXCategoryIndicatorImageView alloc] init];
    indicatorImageView.indicatorImageView.image = [UIImage imageNamed:@"light"];
    indicatorImageView.indicatorImageViewSize = CGSizeMake(50, 50);
    self.myCategoryView.components = @[indicatorImageView];
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
