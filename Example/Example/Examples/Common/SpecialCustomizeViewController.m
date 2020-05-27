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
#import "LoadDataListCustomViewController.h"
#import "LoadDataListContainerViewController.h"
#import "LoadDataListCollectionViewController.h"
#import "ScrollZoomViewController.h"
#import "RearrangeViewController.h"
#import "TitleViewController.h"
#import "VerticalListTableViewController.h"
#import "ScrollUpViewController.h"

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
    }else if ([title isEqualToString:@"垂直列表滚动(UICollectionView)"]) {
        VerticalListViewController *vc = [[VerticalListViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"垂直列表滚动(UITableView)"]) {
        VerticalListTableViewController *vc = [[VerticalListTableViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"刷新数据+UIScrollView封装列表"]) {
        LoadDataListContainerViewController *vc = [[LoadDataListContainerViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"刷新数据+UICollectionView封装列表"]) {
        LoadDataListCollectionViewController *vc = [[LoadDataListCollectionViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"刷新数据+列表自定义"]) {
        LoadDataListCustomViewController *vc = [[LoadDataListCustomViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"垂直滚动缩放"]) {
        ScrollZoomViewController *vc = [[ScrollZoomViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"删除、增加、重新排序不重复创建列表"]) {
        RearrangeViewController *vc = [[RearrangeViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"指示器等分屏幕宽度"]) {
        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        testVC.titles = @[@"👈左边", @"右边👉"];
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        titleCategoryView.cellSpacing = 0;
        titleCategoryView.contentEdgeInsetLeft = 0;
        titleCategoryView.contentEdgeInsetRight = 0;
        titleCategoryView.averageCellSpacingEnabled = NO;
        titleCategoryView.cellWidth = [UIScreen mainScreen].bounds.size.width/2;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = [UIScreen mainScreen].bounds.size.width/2;
        titleCategoryView.indicators = @[lineView];
        [self.navigationController pushViewController:testVC animated:YES];
    }else if ([title isEqualToString:@"向上滚动平移"]) {
        ScrollUpViewController *vc = [[ScrollUpViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
