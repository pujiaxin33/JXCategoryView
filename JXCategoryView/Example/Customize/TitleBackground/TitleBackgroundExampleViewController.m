//
//  TitleBackgroundExampleViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/16.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "TitleBackgroundExampleViewController.h"
#import "JXCategoryTitleBackgroundView.h"

@interface TitleBackgroundExampleViewController ()
@property (nonatomic, strong) JXCategoryTitleBackgroundView *myCategoryView;
@end

@implementation TitleBackgroundExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    self.myCategoryView.titles = self.titles;
}

- (JXCategoryTitleBackgroundView *)myCategoryView {
    return (JXCategoryTitleBackgroundView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleBackgroundView alloc] init];
}

@end
