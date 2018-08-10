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
#import "IndicatorImageViewViewController.h"
#import "FootballViewController.h"

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
    if (indexPath.row == 3) {
        //指示器IndicatorImageView
        IndicatorImageViewViewController *indicatorImageViewVC = [[IndicatorImageViewViewController alloc] init];
        indicatorImageViewVC.title = title;
        [self.navigationController pushViewController:indicatorImageViewVC animated:YES];
        return;
    }else if (indexPath.row == 5) {
        //指示器ImageView
        BackgroundImageViewController *backgroundImageVC = [[BackgroundImageViewController alloc] init];
        backgroundImageVC.title = title;
        [self.navigationController pushViewController:backgroundImageVC animated:YES];
        return;
    }else if (indexPath.row == 8) {
        //图片
        ImageViewController *imageVC = [[ImageViewController alloc] init];
        imageVC.title = title;
        [self.navigationController pushViewController:imageVC animated:YES];
        return;
    }else if (indexPath.row == 9) {
        //数字
        NumberViewController *numberVC = [[NumberViewController alloc] init];
        numberVC.title = title;
        [self.navigationController pushViewController:numberVC animated:YES];
        return;
    }else if (indexPath.row == 10) {
        //个人主页
        return;
    }else if (indexPath.row == 12) {
        //SegmentedControl
        SegmentedControlViewController *segmentedControlVC = [[SegmentedControlViewController alloc] init];
        segmentedControlVC.title = title;
        [self.navigationController pushViewController:segmentedControlVC animated:YES];
        return;
    }else if (indexPath.row == 14) {
        //足球滚动
        FootballViewController *footballVC = [[FootballViewController alloc] init];
        footballVC.title = title;
        [self.navigationController pushViewController:footballVC animated:YES];
        return;
    }
    TitleViewController *testVC = [[TitleViewController alloc] init];
    testVC.title = title;
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
    titleCategoryView.titleColorGradientEnabled = YES;
    titleCategoryView.indicatorLineViewShowEnabled = NO;
    switch (indexPath.row) {
        case 0:
        {
            //渐变
        }
            break;
        case 1:
        {
            //缩放
            titleCategoryView.zoomEnabled = YES;
        }
            break;
        case 2:
        {
            //指示器LineView
            titleCategoryView.indicatorLineViewShowEnabled = YES;
        }
            break;
        case 4:
        {
            //指示器BackgroundEllipseLayer
            titleCategoryView.backgroundEllipseLayerShowEnabled = YES;
        }
            break;
        case 6:
        {
            //京东
            titleCategoryView.indicatorLineViewShowEnabled = YES;
            titleCategoryView.indicatorLineWidth = 20;
            titleCategoryView.lineStyle = JXCategoryLineStyle_JD;
        }
            break;
        case 7:
        {
            //爱奇艺
            titleCategoryView.indicatorLineViewShowEnabled = YES;
            titleCategoryView.indicatorLineWidth = 20;
            titleCategoryView.lineStyle = JXCategoryLineStyle_IQIYI;
        }
            break;
        case 11:
        {
            //手势处理
        }
            break;
        case 13:
        {
            //SeparatorLine
            titleCategoryView.indicatorLineViewShowEnabled = YES;
            titleCategoryView.separatorLineShowEnabled = YES;
        }
            break;

        default:
            break;
    }
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
