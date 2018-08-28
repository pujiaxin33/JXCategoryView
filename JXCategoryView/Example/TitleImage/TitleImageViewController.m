//
//  ImageViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "TitleImageViewController.h"
#import "JXCategoryTitleImageView.h"
#import "TitleImageSettingViewController.h"

@interface TitleImageViewController () <JXCategoryViewDelegate, TitleTitleImageSettingViewControllerDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryTitleImageView *myCategoryView;
@end

@implementation TitleImageViewController

- (void)viewDidLoad {
    _titles = @[@"螃蟹", @"小龙虾", @"苹果", @"胡萝卜", @"葡萄", @"西瓜"];

    [super viewDidLoad];

    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(didSettingClicked)];
    self.navigationItem.rightBarButtonItem = settingItem;

    NSArray *imageNames = @[@"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon"];
    NSArray *selectedImageNames = @[@"crab_selected", @"lobster_selected", @"apple_selected", @"carrot_selected", @"grape_selected", @"watermelon_selected"];

    self.myCategoryView.titles = self.titles;
    self.myCategoryView.imageNames = imageNames;
    self.myCategoryView.selectedImageNames = selectedImageNames;
    self.myCategoryView.imageType = JXCategoryTitleImageType_LeftImage;
    self.myCategoryView.imageZoomEnabled = YES;
    self.myCategoryView.imageZoomScale = 1.3;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = 20;
    self.myCategoryView.indicators = @[lineView];
}

- (JXCategoryTitleImageView *)myCategoryView {
    return (JXCategoryTitleImageView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleImageView class];
}

- (void)didSettingClicked {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TitleImageSettingViewController *imageSettingVC = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([TitleImageSettingViewController class])];
    imageSettingVC.imageType = self.myCategoryView.imageType;
    imageSettingVC.delegate = self;
    [self.navigationController pushViewController:imageSettingVC animated:YES];
}

#pragma mark - TitleImageSettingViewControllerDelegate

- (void)titleImageSettingVCDidSelectedImageType:(JXCategoryTitleImageType)imageType {
    self.myCategoryView.imageType = imageType;
    [self.categoryView reloadData];
}

@end
