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
#import "ListViewController.h"

#define WindowsSize [UIScreen mainScreen].bounds.size

static const CGFloat categoryViewHeight = 50;

@interface ImageViewController () <JXCategoryViewDelegate, ImageSettingViewControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) JXCategoryImageView *categoryView;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(didSettingClicked)];
    self.navigationItem.rightBarButtonItem = settingItem;

    NSArray *titles = @[@"螃蟹", @"小龙虾", @"苹果", @"胡萝卜", @"葡萄", @"西瓜"];
    NSArray *imageNames = @[@"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon"];
    NSArray *selectedImageNames = @[@"crab_selected", @"lobster_selected", @"apple_selected", @"carrot_selected", @"grape_selected", @"watermelon_selected"];

    CGFloat naviHeight = 64;

    if (@available(iOS 11.0, *)) {
        if (WindowsSize.height == 812) {
            naviHeight = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top + 44;
        }
    }
    CGFloat width = WindowsSize.width;
    CGFloat height = WindowsSize.height - naviHeight - categoryViewHeight;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, categoryViewHeight, width, height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(width*titles.count, height);
    [self.view addSubview:self.scrollView];

    for (int i = 0; i < titles.count; i ++) {
        ListViewController *listVC = [[ListViewController alloc] init];
        [self addChildViewController:listVC];
        listVC.view.frame = CGRectMake(i*width, 0, width, height);
        [self.scrollView addSubview:listVC.view];
    }

    self.categoryView = [[JXCategoryImageView alloc] initWithFrame:CGRectMake(0, 0, WindowsSize.width, categoryViewHeight)];
    self.categoryView.titles = titles;
    self.categoryView.imageNames = imageNames;
    self.categoryView.selectedImageNames = selectedImageNames;
    self.categoryView.imageType = JXCategoryImageType_LeftImage;
    self.categoryView.delegate = self;
    self.categoryView.contentScrollView = self.scrollView;
    self.categoryView.indicatorLineWidth = 20;
    [self.view addSubview:self.categoryView];
}

- (void)didSettingClicked {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ImageSettingViewController *imageSettingVC = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([ImageSettingViewController class])];
    imageSettingVC.imageType = self.categoryView.imageType;
    imageSettingVC.delegate = self;
    [self.navigationController pushViewController:imageSettingVC animated:YES];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
}

#pragma mark - ImageSettingViewControllerDelegate

- (void)imageSettingVCDidSelectedImageType:(JXCategoryImageType)imageType {
    self.categoryView.imageType = imageType;
    [self.categoryView reloadDatas];
}

@end
