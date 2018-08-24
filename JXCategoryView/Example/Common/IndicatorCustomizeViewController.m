//
//  IndicatorCustomizeViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "IndicatorCustomizeViewController.h"
#import "TitleViewController.h"
#import "JXCategoryView.h"
#import "IndicatorImageViewViewController.h"
#import "BackgroundImageViewController.h"
#import "FootballViewController.h"
#import "JXCategoryIndicatorDotLineView.h"

@interface IndicatorCustomizeViewController ()

@end

@implementation IndicatorCustomizeViewController

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

    if (indexPath.row == 11) {
        //IndicatorImageView底部
        IndicatorImageViewViewController *indicatorImageViewVC = [[IndicatorImageViewViewController alloc] init];
        indicatorImageViewVC.title = title;
        [self.navigationController pushViewController:indicatorImageViewVC animated:YES];
        return;
    }else if (indexPath.row == 12) {
        //IndicatorImageView cell背景
        BackgroundImageViewController *backgroundImageVC = [[BackgroundImageViewController alloc] init];
        backgroundImageVC.title = title;
        [self.navigationController pushViewController:backgroundImageVC animated:YES];
        return;
    }else if (indexPath.row == 13) {
        //足球滚动
        FootballViewController *footballVC = [[FootballViewController alloc] init];
        footballVC.title = title;
        [self.navigationController pushViewController:footballVC animated:YES];
        return;
    }

    TitleViewController *testVC = [[TitleViewController alloc] init];
    testVC.title = title;
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;

    switch (indexPath.row) {
        case 0:
        {
            //固定宽度
            testVC.isNeedIndicatorPositionChangeItem = YES;
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
            lineView.indicatorLineWidth = 20;
            titleCategoryView.indicators = @[lineView];
        }
            break;
        case 1:
        {
            //与cell等宽
            testVC.isNeedIndicatorPositionChangeItem = YES;
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
            lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
            titleCategoryView.indicators = @[lineView];
        }
            break;
        case 2:
        {
            //京东
            testVC.isNeedIndicatorPositionChangeItem = YES;
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
            lineView.indicatorLineWidth = 20;
            lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
            titleCategoryView.indicators = @[lineView];
        }
            break;
        case 3:
        {
            //爱奇艺
            testVC.isNeedIndicatorPositionChangeItem = YES;
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
            lineView.indicatorLineWidth = 20;
            lineView.lineStyle = JXCategoryIndicatorLineStyle_IQIYI;
            titleCategoryView.indicators = @[lineView];
        }
            break;
        case 4:
        {
            //qq红点
            testVC.isNeedIndicatorPositionChangeItem = YES;
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorBallView *ballView = [[JXCategoryIndicatorBallView alloc] init];
            titleCategoryView.indicators = @[ballView];
        }
            break;
        case 5:
        {
            //三角形
            testVC.isNeedIndicatorPositionChangeItem = YES;
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorTriangleView *triangleView = [[JXCategoryIndicatorTriangleView alloc] init];
            titleCategoryView.indicators = @[triangleView];
        }
            break;
        case 6:
        {
            //椭圆形
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.backgroundViewHeight = 20;
            backgroundView.backgroundViewCornerRadius = JXCategoryViewAutomaticDimension;
            titleCategoryView.indicators = @[backgroundView];
        }
            break;
        case 7:
        {
            //阴影
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.backgroundViewHeight = 20;
            backgroundView.backgroundViewCornerRadius = JXCategoryViewAutomaticDimension;
            backgroundView.layer.shadowColor = [UIColor redColor].CGColor;
            backgroundView.layer.shadowRadius = 3;
            backgroundView.layer.shadowOffset = CGSizeMake(3, 4);
            backgroundView.layer.shadowOpacity = 0.6;
            titleCategoryView.indicators = @[backgroundView];
        }
            break;
        case 8:
        {
            //长方形
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.backgroundViewHeight = JXCategoryViewAutomaticDimension;
            backgroundView.backgroundViewCornerRadius = 0;
            titleCategoryView.indicators = @[backgroundView];
        }
            break;
        case 9:
        {
            //文字遮罩有背景
            titleCategoryView.titleColorGradientEnabled = NO;
            titleCategoryView.titleLabelMaskEnabled = YES;

            JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.backgroundViewWidthIncrement = 10;
            backgroundView.backgroundViewHeight = 20;
            titleCategoryView.indicators = @[backgroundView];
        }
            break;
        case 10:
        {
            //文字遮罩无背景
            titleCategoryView.titleColorGradientEnabled = NO;
            titleCategoryView.titleLabelMaskEnabled = YES;

            JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.backgroundViewWidthIncrement = 10;
            backgroundView.backgroundViewHeight = 20;
            backgroundView.alpha = 0;
            titleCategoryView.indicators = @[backgroundView];
        }
            break;
        case 14:
        {
            //混合使用
            titleCategoryView.titleColorGradientEnabled = NO;
            titleCategoryView.titleLabelMaskEnabled = YES;
            
            JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
            JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
            backgroundView.backgroundViewHeight = 20;

            titleCategoryView.indicators = @[backgroundView, lineView];
        }
            break;
        case 15:
        {
            //indicator自定义-点线效果
            testVC.isNeedIndicatorPositionChangeItem = YES;
            titleCategoryView.titleColorGradientEnabled = YES;
            JXCategoryIndicatorDotLineView *lineView = [[JXCategoryIndicatorDotLineView alloc] init];
            titleCategoryView.indicators = @[lineView];
        }
            break;

        default:
            break;
    }
    [self.navigationController pushViewController:testVC animated:YES];
}

@end
