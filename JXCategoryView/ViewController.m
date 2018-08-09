//
//  ViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/3/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ViewController.h"
#import "JXCategoryTitleView.h"
#import "TitleViewController.h"
#import "ImageViewController.h"
#import "NumberViewController.h"
#import "SegmentedControlViewController.h"
#import "BackgroundImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = @"";
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            title = [(UILabel *)subview text];
        }
    }
    if (indexPath.row == 4) {
        //指示器ImageView
        BackgroundImageViewController *backgroundImageVC = [[BackgroundImageViewController alloc] init];
        backgroundImageVC.title = title;
        [self.navigationController pushViewController:backgroundImageVC animated:YES];
        return;
    }else if (indexPath.row == 7) {
        //图片
        ImageViewController *imageVC = [[ImageViewController alloc] init];
        imageVC.title = title;
        [self.navigationController pushViewController:imageVC animated:YES];
        return;
    }else if (indexPath.row == 8) {
        //数字
        NumberViewController *numberVC = [[NumberViewController alloc] init];
        numberVC.title = title;
        [self.navigationController pushViewController:numberVC animated:YES];
        return;
    }else if (indexPath.row == 10) {
        //个人主页
        return;
    }else if (indexPath.row == 11) {
        //SegmentedControl
        SegmentedControlViewController *segmentedControlVC = [[SegmentedControlViewController alloc] init];
        segmentedControlVC.title = title;
        [self.navigationController pushViewController:segmentedControlVC animated:YES];
        return;
    }
    TitleViewController *testVC = [[TitleViewController alloc] init];
    testVC.title = title;
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
    titleCategoryView.titleColorGradientEnabled = YES;
    switch (indexPath.row) {
        case 0:
        {
            titleCategoryView.indicatorLineViewShowEnabled = NO;
        }
            break;
        case 1:
        {
            titleCategoryView.indicatorLineViewShowEnabled = NO;
            titleCategoryView.zoomEnabled = YES;
        }
            break;
        case 2:
        {
            titleCategoryView.indicatorLineViewShowEnabled = YES;
        }
            break;
        case 3:
        {
            titleCategoryView.indicatorLineViewShowEnabled = NO;
            titleCategoryView.backgroundEllipseLayerShowEnabled = YES;
        }
            break;
        case 5:
        {
            titleCategoryView.indicatorLineViewShowEnabled = YES;
            titleCategoryView.indicatorLineWidth = 20;
            titleCategoryView.lineStyle = JXCategoryLineStyle_JD;
        }
            break;
        case 6:
        {
            titleCategoryView.indicatorLineViewShowEnabled = YES;
            titleCategoryView.indicatorLineWidth = 20;
            titleCategoryView.lineStyle = JXCategoryLineStyle_IQIYI;
        }
            break;
        case 9:
        {
            //手势处理
        }
            break;
        case 12:
        {
            //SeparatorLine
            titleCategoryView.separatorLineShowEnabled = YES;
        }
            break;

        default:
            break;
    }
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
