//
//  TitleImageSettingViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "TitleImageSettingViewController.h"

@interface TitleImageSettingViewController ()

@end

@implementation TitleImageSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    NSUInteger selectedIndex = [self converIndexToImageType:self.imageType];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JXCategoryTitleImageType imageType = [self converIndexToImageType:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(titleImageSettingVCDidSelectedImageType:)]) {
        [self.delegate titleImageSettingVCDidSelectedImageType:imageType];
    }
    [self.navigationController popViewControllerAnimated:true];
}

- (JXCategoryTitleImageType)converIndexToImageType:(NSUInteger)index {
    NSArray <NSNumber *> *imageTypes = @[@(JXCategoryTitleImageType_TopImage),
                            @(JXCategoryTitleImageType_LeftImage),
                            @(JXCategoryTitleImageType_BottomImage),
                            @(JXCategoryTitleImageType_RightImage)];
    return [imageTypes[index] integerValue];
}

- (JXCategoryTitleImageType)converImageTypeToIndex:(JXCategoryTitleImageType)imageType {
    NSArray <NSNumber *> *imageTypes = @[@(JXCategoryTitleImageType_TopImage),
                                         @(JXCategoryTitleImageType_LeftImage),
                                         @(JXCategoryTitleImageType_BottomImage),
                                         @(JXCategoryTitleImageType_RightImage)];
    return [imageTypes indexOfObject:@(imageType)];
}

@end
