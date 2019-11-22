//
//  CustomizationListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/20.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "CustomizationListViewController.h"
#import "AlignmentLineExampleViewController.h"
#import "SpringIndicatorExampleViewController.h"
#import "CountCellExampleViewController.h"
#import "TimelineExampleViewController.h"
#import "SortExampleViewController.h"
#import "TitleBackgroundExampleViewController.h"

@interface CustomizationListViewController ()

@end

@implementation CustomizationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = @"";
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            title = [(UILabel *)subview text];
        }
    }

    if ([title isEqualToString:@"左右对齐指示器"]){
        AlignmentLineExampleViewController *vc = [[AlignmentLineExampleViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"Spring动画指示器"]) {
        SpringIndicatorExampleViewController *vc = [[SpringIndicatorExampleViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"数量富文本cell"]) {
        CountCellExampleViewController *vc = [[CountCellExampleViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"秒杀时间线cell"]) {
        TimelineExampleViewController *vc = [[TimelineExampleViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"京东商品排序cell"]) {
        SortExampleViewController *vc = [[SortExampleViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"title背景cell"]) {
        TitleBackgroundExampleViewController *vc = [[TitleBackgroundExampleViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
