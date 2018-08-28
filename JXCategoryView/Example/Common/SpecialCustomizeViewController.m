//
//  SpecialCustomizeViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "SpecialCustomizeViewController.h"
#import "SegmentedControlViewController.h"
#import "NaviSegmentedControlViewController.h"
#import "NestViewController.h"
#import "VerticalListViewController.h"
#import "PagingViewController.h"
#import "LoadDataViewController.h"

@interface SpecialCustomizeViewController ()

@end

@implementation SpecialCustomizeViewController

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
            //个人主页
            PagingViewController *pagingVC = [[PagingViewController alloc] init];
            pagingVC.title = title;
            [self.navigationController pushViewController:pagingVC animated:YES];
        }
            break;
        case 1:
        {
            //segmentedControl
            SegmentedControlViewController *segmentedVC = [[SegmentedControlViewController alloc] init];
            segmentedVC.title = title;
            [self.navigationController pushViewController:segmentedVC animated:YES];
        }
            break;
        case 2:
        {
            //导航栏
            NaviSegmentedControlViewController *segmentedVC = [[NaviSegmentedControlViewController alloc] init];
            segmentedVC.title = title;
            [self.navigationController pushViewController:segmentedVC animated:YES];
        }
            break;
        case 3:
        {
            //嵌套使用
            NestViewController *vc = [[NestViewController alloc] init];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            //垂直列表滚动
            VerticalListViewController *vc = [[VerticalListViewController alloc] init];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            //数据源刷新&列表数据加载
            LoadDataViewController *vc = [[LoadDataViewController alloc] init];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
    }
}

@end
