//
//  CellCustomizeViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "CellCustomizeViewController.h"
#import "TitleViewController.h"
#import "NumberViewController.h"
#import "TitleImageViewController.h"
#import "ImageViewController.h"
#import "DotViewController.h"
#import "AttributeViewViewController.h"

@implementation CellCustomizeViewController

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

    if ([title isEqualToString:@"颜色渐变"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        titleCategoryView.indicators = @[lineView];
        titleCategoryView.titleColorGradientEnabled = YES;
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"大小缩放"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.titleLabelZoomEnabled = YES;
        titleCategoryView.titleLabelZoomScale = 1.3;
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"大小缩放+底部锚点"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.titleLabelZoomEnabled = YES;
        titleCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
//        titleCategoryView.titleLabelVerticalOffset = 5;
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"大小缩放+底部锚点+视觉对齐"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.titleLabelZoomEnabled = YES;
        titleCategoryView.titleLabelZoomScale = 1.85;
        titleCategoryView.cellWidthZoomEnabled = YES;
        titleCategoryView.cellWidthZoomScale = 1.85;
        titleCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
        titleCategoryView.selectedAnimationEnabled = YES;
        titleCategoryView.titleLabelZoomSelectedVerticalOffset = 3;
        //        titleCategoryView.titleLabelVerticalOffset = 5;
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"大小缩放+顶部锚点"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;

        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.titleLabelZoomEnabled = YES;
        titleCategoryView.titleLabelZoomScale = 1.3;
        titleCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleTop;
//        titleCategoryView.titleLabelVerticalOffset = 5;

        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"大小缩放+字体粗细"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.titleLabelZoomEnabled = YES;
        titleCategoryView.titleLabelZoomScale = 1.3;
        titleCategoryView.titleLabelStrokeWidthEnabled = YES;
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"大小缩放+点击动画"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.titleLabelZoomEnabled = YES;
        titleCategoryView.titleLabelZoomScale = 1.3;
        titleCategoryView.titleLabelStrokeWidthEnabled = YES;
        titleCategoryView.selectedAnimationEnabled = YES;
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"大小缩放+Cell宽度缩放"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.titleLabelZoomEnabled = YES;
        titleCategoryView.titleLabelZoomScale = 1.3;
        titleCategoryView.titleLabelStrokeWidthEnabled = YES;
        titleCategoryView.selectedAnimationEnabled = YES;
        titleCategoryView.cellWidthZoomEnabled = YES;
        titleCategoryView.cellWidthZoomScale = 1.3;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = 20;
        titleCategoryView.indicators = @[lineView];

        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"Cell图片样式"]) {

        ImageViewController *testVC = [[ImageViewController alloc] init];
        testVC.title = title;
        JXCategoryImageView *imageCategoryView = (JXCategoryImageView *)testVC.categoryView;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        imageCategoryView.indicators = @[lineView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"Cell数字样式"]) {

        NumberViewController *numberVC = [[NumberViewController alloc] init];
        numberVC.title = title;
        [self.navigationController pushViewController:numberVC animated:YES];

    }else if ([title isEqualToString:@"Cell红点样式"]) {

        DotViewController *dotVC = [[DotViewController alloc] init];
        dotVC.title = title;
        [self.navigationController pushViewController:dotVC animated:YES];

    }else if ([title isEqualToString:@"Cell Title&图片样式"]) {

        TitleImageViewController *imageVC = [[TitleImageViewController alloc] init];
        imageVC.title = title;
        [self.navigationController pushViewController:imageVC animated:YES];

    }else if ([title isEqualToString:@"多行文本"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        titleCategoryView.titleColorGradientEnabled = YES;
        //暂不支持自动换行，需要自行插入换行符\n
        titleCategoryView.titleNumberOfLines = 2;
        testVC.titles = @[@"螃蟹\ncrab", @"麻辣小龙虾\nlobster", @"苹果\napple", @"营养胡萝卜\ncarrot", @"葡萄\ngrape", @"美味西瓜\nwatermelon", @"香蕉\nbanana", @"香甜菠萝\npineapple", @"鸡肉\nchicken", @"鱼\nfish", @"海星\nstarfish"];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"多行富文本"]) {

        AttributeViewViewController *vc = [[AttributeViewViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];

    }else if ([title isEqualToString:@"Cell背景色渐变"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.cellBackgroundColorGradientEnabled = YES;
        titleCategoryView.cellSpacing = 0;
        titleCategoryView.cellWidthIncrement = 20;
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"分割线"]) {

        TitleViewController *testVC = [[TitleViewController alloc] init];
        testVC.title = title;
        JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        titleCategoryView.indicators = @[lineView];
        titleCategoryView.separatorLineShowEnabled = YES;
        [self.navigationController pushViewController:testVC animated:YES];

    }
}

@end
