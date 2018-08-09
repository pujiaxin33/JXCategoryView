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
    _titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];

    [super viewDidLoad];

    self.myCategoryView.titles = self.titles;
    self.myCategoryView.backgroundImageViewShowEnabled = YES;
    self.myCategoryView.backgroundImageView.image = [UIImage imageNamed:@"basket"];
    self.myCategoryView.backgroundImageViewSize = CGSizeMake(50, 50);
    self.myCategoryView.indicatorLineViewShowEnabled = NO;
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
