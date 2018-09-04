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
@property (nonatomic, assign) JXCategoryTitleImageType currentType;
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
    self.myCategoryView.imageZoomEnabled = YES;
    self.myCategoryView.imageZoomScale = 1.3;
    self.myCategoryView.averageCellWidthEnabled = NO;

    [self configCategoryViewWithType:JXCategoryTitleImageType_LeftImage];

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

- (CGFloat)preferredCategoryViewHeight {
    return 60;
}

- (void)didSettingClicked {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TitleImageSettingViewController *imageSettingVC = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([TitleImageSettingViewController class])];
    imageSettingVC.imageType = self.currentType;
    imageSettingVC.delegate = self;
    [self.navigationController pushViewController:imageSettingVC animated:YES];
}

- (void)configCategoryViewWithType:(JXCategoryTitleImageType)imageType {
    self.currentType = imageType;
    if ((NSInteger)imageType == 100) {
        NSMutableArray *types = [NSMutableArray array];
        for (int i = 0; i < self.titles.count; i++) {
            if (i == 2) {
                [types addObject:@(JXCategoryTitleImageType_OnlyImage)];
            }else if (i == 4) {
                [types addObject:@(JXCategoryTitleImageType_LeftImage)];
            }else {
                [types addObject:@(JXCategoryTitleImageType_OnlyTitle)];
            }
        }
        self.myCategoryView.imageTypes = types;
    }else {
        NSMutableArray *types = [NSMutableArray array];
        for (int i = 0; i < self.titles.count; i++) {
            [types addObject:@(imageType)];
        }
        self.myCategoryView.imageTypes = types;
    }
    [self.categoryView reloadData];
}

#pragma mark - TitleImageSettingViewControllerDelegate

- (void)titleImageSettingVCDidSelectedImageType:(JXCategoryTitleImageType)imageType {
    [self configCategoryViewWithType:imageType];
}

@end
