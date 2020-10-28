//
//  ViewController.m
//  Example
//
//  Created by jiaxin on 2019/11/22.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "ViewController.h"
#import "IndicatorCustomizeViewController.h"
#import "CellCustomizeViewController.h"
#import "SpecialCustomizeViewController.h"
#import "CustomizationListViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.translucent = NO;
    self.tableView.rowHeight = 44;

    self.title = @"JXCategoryView Demo";

    //测试RTL
//    UIView.appearance.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
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
        case 0: {
            // 指示器样式
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            IndicatorCustomizeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([IndicatorCustomizeViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1: {
            // Cell 样式
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CellCustomizeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([CellCustomizeViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2: {
            // 特殊效果
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SpecialCustomizeViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([SpecialCustomizeViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3: {
            // 自定义效果示例
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            CustomizationListViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:NSStringFromClass([CustomizationListViewController class])];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
