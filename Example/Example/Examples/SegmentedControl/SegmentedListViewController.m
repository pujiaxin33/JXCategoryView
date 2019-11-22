//
//  SegmentedListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/13.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "SegmentedListViewController.h"
#import "SegmentedControlViewController.h"
#import "NaviSegmentedControlViewController.h"

@interface SegmentedListViewController ()

@end

@implementation SegmentedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"列表";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SegmentedControlViewController *segmentedVC = [[SegmentedControlViewController alloc] init];
        [self.navigationController pushViewController:segmentedVC animated:YES];
    }else {
        NaviSegmentedControlViewController *segmentedVC = [[NaviSegmentedControlViewController alloc] init];
        [self.navigationController pushViewController:segmentedVC animated:YES];
    }
}

@end
