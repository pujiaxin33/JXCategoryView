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
#import "LoadDataNormalViewController.h"
#import "LoadDataListVCContainerViewController.h"
#import "LoadDataListContainerViewController.h"

@interface SpecialCustomizeViewController ()

@end

@implementation SpecialCustomizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    //FIXME:部分点击加动画
    //FIXME:多加点个人主页示例
    if ([title isEqualToString:@"个人主页"]) {
        PagingViewController *pagingVC = [[PagingViewController alloc] init];
        pagingVC.title = title;
        [self.navigationController pushViewController:pagingVC animated:YES];
    }else if ([title isEqualToString:@"SegmentedControl效果"]) {
        SegmentedControlViewController *segmentedVC = [[SegmentedControlViewController alloc] init];
        segmentedVC.title = title;
        [self.navigationController pushViewController:segmentedVC animated:YES];
    }else if ([title isEqualToString:@"导航栏使用"]) {
        NaviSegmentedControlViewController *segmentedVC = [[NaviSegmentedControlViewController alloc] init];
        segmentedVC.title = title;
        [self.navigationController pushViewController:segmentedVC animated:YES];
    }else if ([title isEqualToString:@"嵌套使用"]) {
        NestViewController *vc = [[NestViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"垂直列表滚动"]) {
        VerticalListViewController *vc = [[VerticalListViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"刷新数据+ListContainerView"]) {
        LoadDataListContainerViewController *vc = [[LoadDataListContainerViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"刷新数据+列表自定义"]) {
        LoadDataNormalViewController *vc = [[LoadDataNormalViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }

    /*
    //比较老的列表容器封装方法，如果你感兴趣也可以试一下。不过已经被弃用。
    //数据源刷新&列表加载数据（JXCategoryListVCContainerView封装）
    LoadDataListVCContainerViewController *vc = [[LoadDataListVCContainerViewController alloc] init];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
     */
}

@end
