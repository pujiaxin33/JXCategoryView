//
//  ImageViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ImageViewController.h"
#import "JXCategoryImageView.h"
#import "ImageSettingViewController.h"

@interface ImageViewController () <JXCategoryViewDelegate, ImageSettingViewControllerDelegate>
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryImageView *myCategoryView;
@end

@implementation ImageViewController

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
    self.myCategoryView.imageType = JXCategoryImageType_LeftImage;
    self.myCategoryView.indicatorLineWidth = 20;
}

- (JXCategoryImageView *)myCategoryView {
    return (JXCategoryImageView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.titles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryImageView class];
}

- (void)didSettingClicked {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ImageSettingViewController *imageSettingVC = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([ImageSettingViewController class])];
    imageSettingVC.imageType = self.myCategoryView.imageType;
    imageSettingVC.delegate = self;
    [self.navigationController pushViewController:imageSettingVC animated:YES];
}

#pragma mark - ImageSettingViewControllerDelegate

- (void)imageSettingVCDidSelectedImageType:(JXCategoryImageType)imageType {
    self.myCategoryView.imageType = imageType;
    [self.categoryView reloadDatas];
}

@end
