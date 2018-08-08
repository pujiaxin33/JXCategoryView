//
//  ViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/3/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "ImageViewController.h"
#import "NumberViewController.h"

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
    if (indexPath.row == 6) {
        //图片
        ImageViewController *imageVC = [[ImageViewController alloc] init];
        imageVC.title = title;
        [self.navigationController pushViewController:imageVC animated:YES];
        return;
    }else if (indexPath.row == 7) {
        //数字
        NumberViewController *numberVC = [[NumberViewController alloc] init];
        numberVC.title = title;
        [self.navigationController pushViewController:numberVC animated:YES];
        return;
    }else if (indexPath.row == 9) {
        //个人主页

    }
    TestViewController *testVC = [[TestViewController alloc] init];
    testVC.title = title;
    testVC.categoryView.titleColorGradientEnabled = YES;
    switch (indexPath.row) {
        case 0:
        {
            testVC.categoryView.indicatorLineViewShowEnabled = NO;
        }
            break;
        case 1:
        {
            testVC.categoryView.indicatorLineViewShowEnabled = NO;
            testVC.categoryView.zoomEnabled = YES;
        }
            break;
        case 2:
        {
            testVC.categoryView.indicatorLineViewShowEnabled = YES;
        }
            break;
        case 3:
        {
            testVC.categoryView.indicatorLineViewShowEnabled = NO;
            testVC.categoryView.backEllipseLayerShowEnabled = YES;
        }
            break;
        case 4:
        {
            testVC.categoryView.indicatorLineViewShowEnabled = YES;
            testVC.categoryView.indicatorLineWidth = 20;
            testVC.categoryView.lineStyle = JXCategoryLineStyle_JD;
        }
            break;
        case 5:
        {
            testVC.categoryView.indicatorLineViewShowEnabled = YES;
            testVC.categoryView.indicatorLineWidth = 20;
            testVC.categoryView.lineStyle = JXCategoryLineStyle_IQIYI;
        }
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
