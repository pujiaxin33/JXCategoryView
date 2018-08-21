//
//  CellCustomizeViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "CellCustomizeViewController.h"
#import "TitleViewController.h"
#import "NumberViewController.h"
#import "TitleImageViewController.h"
#import "ImageViewController.h"
#import "DotViewController.h"

@interface CellCustomizeViewController ()

@end

@implementation CellCustomizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.tableView.rowHeight = 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = @"";
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            title = [(UILabel *)subview text];
        }
    }


    switch (indexPath.row) {
        case 0:
        {
            //渐变
            TitleViewController *testVC = [[TitleViewController alloc] init];
            testVC.title = title;
            JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
            JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
            titleCategoryView.indicators = @[lineView];
            titleCategoryView.titleColorGradientEnabled = YES;
            [self.navigationController pushViewController:testVC animated:YES];
        }
            break;
        case 1:
        {
            //缩放
            TitleViewController *testVC = [[TitleViewController alloc] init];
            testVC.title = title;
            JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
            JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
            titleCategoryView.indicators = @[lineView];
            titleCategoryView.titleColorGradientEnabled = YES;
            titleCategoryView.zoomEnabled = YES;
            [self.navigationController pushViewController:testVC animated:YES];
        }
            break;
        case 2:
        {
            //cell背景色渐变
            TitleViewController *testVC = [[TitleViewController alloc] init];
            testVC.title = title;
            JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
            titleCategoryView.titleColorGradientEnabled = YES;
            titleCategoryView.cellBackgroundColorGradientEnabled = YES;
            titleCategoryView.cellSpacing = 0;
            titleCategoryView.cellWidthIncrement = 20;
            [self.navigationController pushViewController:testVC animated:YES];
        }
            break;
        case 3:
        {
            //SeparatorLine
            TitleViewController *testVC = [[TitleViewController alloc] init];
            testVC.title = title;
            JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
            JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
            titleCategoryView.indicators = @[lineView];
            titleCategoryView.separatorLineShowEnabled = YES;
            [self.navigationController pushViewController:testVC animated:YES];
        }
            break;
        case 4:
        {
            //图片
            ImageViewController *testVC = [[ImageViewController alloc] init];
            testVC.title = title;
            JXCategoryImageView *imageCategoryView = (JXCategoryImageView *)testVC.categoryView;
            JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
            imageCategoryView.indicators = @[lineView];
            [self.navigationController pushViewController:testVC animated:YES];
        }
            break;
        case 5:
        {
            //数字
            NumberViewController *numberVC = [[NumberViewController alloc] init];
            numberVC.title = title;
            [self.navigationController pushViewController:numberVC animated:YES];
        }
            break;
        case 6:
        {
            //红点
            DotViewController *dotVC = [[DotViewController alloc] init];
            dotVC.title = title;
            [self.navigationController pushViewController:dotVC animated:YES];
        }
            break;
        case 7:
        {
            //title&image
            TitleImageViewController *imageVC = [[TitleImageViewController alloc] init];
            imageVC.title = title;
            [self.navigationController pushViewController:imageVC animated:YES];
        }
            break;

        default:
            break;
    }

}

@end
