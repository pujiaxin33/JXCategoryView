//
//  ImageViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ImageViewController.h"
#import "JXCategoryImageView.h"

@interface ImageViewController ()
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) JXCategoryImageView *myCategoryView;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    _imageNames = @[@"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon"];

    [super viewDidLoad];

    NSArray *selectedImageNames = @[@"crab_selected", @"lobster_selected", @"apple_selected", @"carrot_selected", @"grape_selected", @"watermelon_selected"];

    self.myCategoryView.imageNames = self.imageNames;
    self.myCategoryView.selectedImageNames = selectedImageNames;
    self.myCategoryView.imageZoomEnabled = YES;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = 20;
    self.myCategoryView.indicators = @[lineView];
}

- (JXCategoryImageView *)myCategoryView {
    return (JXCategoryImageView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.imageNames.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryImageView class];
}

@end
