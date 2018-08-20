//
//  ViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/3/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ViewController.h"
#import "IndicatorCustomizeViewController.h"
#import "CellCustomizeViewController.h"
#import "SpecialCustomizeViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.tableView.rowHeight = 44;

    self.title = @"JXCategoryView Demo";
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
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            IndicatorCustomizeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([IndicatorCustomizeViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CellCustomizeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([CellCustomizeViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SpecialCustomizeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([SpecialCustomizeViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
    }
}

@end
