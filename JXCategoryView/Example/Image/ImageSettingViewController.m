//
//  ImageSettingViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ImageSettingViewController.h"

@interface ImageSettingViewController ()

@end

@implementation ImageSettingViewController

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
    JXCategoryImageType imageType = [self converIndexToImageType:indexPath.row];
    if ([self.delegate respondsToSelector:@selector(imageSettingVCDidSelectedImageType:)]) {
        [self.delegate imageSettingVCDidSelectedImageType:imageType];
    }
    [self.navigationController popViewControllerAnimated:true];
}

- (JXCategoryImageType)converIndexToImageType:(NSUInteger)index {
    NSArray <NSNumber *> *imageTypes = @[@(JXCategoryImageType_OnlyImage),
                            @(JXCategoryImageType_TopImage),
                            @(JXCategoryImageType_LeftImage),
                            @(JXCategoryImageType_BottomImage),
                            @(JXCategoryImageType_RightImage)];
    return [imageTypes[index] integerValue];
}

- (JXCategoryImageType)converImageTypeToIndex:(JXCategoryImageType)imageType {
    NSArray <NSNumber *> *imageTypes = @[@(JXCategoryImageType_OnlyImage),
                                         @(JXCategoryImageType_TopImage),
                                         @(JXCategoryImageType_LeftImage),
                                         @(JXCategoryImageType_BottomImage),
                                         @(JXCategoryImageType_RightImage)];
    return [imageTypes indexOfObject:@(imageType)];
}

@end
