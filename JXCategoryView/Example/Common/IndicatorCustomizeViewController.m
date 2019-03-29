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
#import "JXGradientView.h"

@interface IndicatorCustomizeViewController ()

@end

@implementation IndicatorCustomizeViewController

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

    TitleViewController *testVC = [[TitleViewController alloc] init];
    testVC.title = title;
    JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)testVC.categoryView;

    if ([title isEqualToString:@"LineView固定长度"]) {

        testVC.isNeedIndicatorPositionChangeItem = YES;
        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = 20;
        titleCategoryView.indicators = @[lineView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"LineView与Cell同宽"]) {

        testVC.isNeedIndicatorPositionChangeItem = YES;
        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        //可以试试宽度补偿
//        lineView.indicatorWidthIncrement = 10;
        titleCategoryView.indicators = @[lineView];
        [self.navigationController pushViewController:testVC animated:YES];
        
    }else if ([title isEqualToString:@"LineView延长style"]) {

        testVC.isNeedIndicatorPositionChangeItem = YES;
        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        //也可以试试固定宽度
//        lineView.indicatorWidth = 20;
        lineView.lineStyle = JXCategoryIndicatorLineStyle_Lengthen;
        titleCategoryView.indicators = @[lineView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"LineView延长+偏移style"]) {

        testVC.isNeedIndicatorPositionChangeItem = YES;
        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        //也可以试试固定宽度
//        lineView.indicatorWidth = 20;
        lineView.lineStyle = JXCategoryIndicatorLineStyle_LengthenOffset;
        titleCategoryView.indicators = @[lineView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"DotLineView点线效果"]) {

        testVC.isNeedIndicatorPositionChangeItem = YES;
        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorDotLineView *lineView = [[JXCategoryIndicatorDotLineView alloc] init];
        titleCategoryView.indicators = @[lineView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"RainbowLineView彩虹效果"]) {

        testVC.isNeedIndicatorPositionChangeItem = YES;
        JXCategoryIndicatorRainbowLineView *lineView = [[JXCategoryIndicatorRainbowLineView alloc] init];
        NSArray *colors = @[[UIColor redColor],
                            [UIColor yellowColor],
                            [UIColor blueColor],
                            [UIColor orangeColor],
                            [UIColor purpleColor],
                            [UIColor cyanColor],
                            [UIColor magentaColor],
                            [UIColor grayColor],
                            [UIColor redColor],
                            [UIColor yellowColor],
                            [UIColor blueColor],];
        lineView.indicatorColors = colors;
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        titleCategoryView.indicators = @[lineView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"BallView QQ小红点"]) {

        testVC.isNeedIndicatorPositionChangeItem = YES;
        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorBallView *ballView = [[JXCategoryIndicatorBallView alloc] init];
        titleCategoryView.indicators = @[ballView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"TriangleView三角形"]) {

        testVC.isNeedIndicatorPositionChangeItem = YES;
        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorTriangleView *triangleView = [[JXCategoryIndicatorTriangleView alloc] init];
        titleCategoryView.indicators = @[triangleView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"BackgroundView椭圆形"]) {

        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorHeight = 20;
        backgroundView.indicatorCornerRadius = JXCategoryViewAutomaticDimension;
        titleCategoryView.indicators = @[backgroundView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"BackgroundView椭圆形+阴影"]) {

        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorHeight = 20;
        backgroundView.indicatorCornerRadius = JXCategoryViewAutomaticDimension;
        backgroundView.layer.shadowColor = [UIColor redColor].CGColor;
        backgroundView.layer.shadowRadius = 3;
        backgroundView.layer.shadowOffset = CGSizeMake(3, 4);
        backgroundView.layer.shadowOpacity = 0.6;
        titleCategoryView.indicators = @[backgroundView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"BackgroundView长方形"]) {

        titleCategoryView.titleColorGradientEnabled = YES;
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorHeight = JXCategoryViewAutomaticDimension;
        backgroundView.indicatorCornerRadius = 0;
        titleCategoryView.indicators = @[backgroundView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"BackgroundView遮罩有背景"]) {

        titleCategoryView.titleColorGradientEnabled = NO;
        titleCategoryView.titleLabelMaskEnabled = YES;

        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorWidthIncrement = 10;
        backgroundView.indicatorHeight = 20;
        titleCategoryView.indicators = @[backgroundView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"BackgroundView遮罩无背景"]) {

        titleCategoryView.titleColorGradientEnabled = NO;
        titleCategoryView.titleLabelMaskEnabled = YES;

        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorWidthIncrement = 10;
        backgroundView.indicatorHeight = 20;
        backgroundView.alpha = 0;
        titleCategoryView.indicators = @[backgroundView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"BackgroundView渐变色"]) {

        titleCategoryView.titleColorGradientEnabled = YES;
        titleCategoryView.titleSelectedColor = [UIColor whiteColor];
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];

        //相当于把JXCategoryIndicatorBackgroundView当做视图容器，你可以在上面添加任何想要的效果
        JXGradientView *gradientView = [JXGradientView new];
        gradientView.gradientLayer.endPoint = CGPointMake(1, 0);
        gradientView.gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:90.0/255 green:215.0/255 blue:202.0/255 alpha:1].CGColor, (__bridge id)[UIColor colorWithRed:122.0/255 green:232.0/255 blue:169.0/255 alpha:1].CGColor,];
        //设置gradientView布局和JXCategoryIndicatorBackgroundView一样
        gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [backgroundView addSubview:gradientView];

        backgroundView.indicatorHeight = 20;
        backgroundView.indicatorCornerRadius = 0;
        titleCategoryView.indicators = @[backgroundView];
        [self.navigationController pushViewController:testVC animated:YES];

    }else if ([title isEqualToString:@"ImageView底部"]) {

        IndicatorImageViewViewController *indicatorImageViewVC = [[IndicatorImageViewViewController alloc] init];
        indicatorImageViewVC.title = title;
        [self.navigationController pushViewController:indicatorImageViewVC animated:YES];

    }else if ([title isEqualToString:@"ImageView Cell背景"]) {

        BackgroundImageViewController *backgroundImageVC = [[BackgroundImageViewController alloc] init];
        backgroundImageVC.title = title;
        [self.navigationController pushViewController:backgroundImageVC animated:YES];

    }else if ([title isEqualToString:@"ImageView足球滚动"]) {

        FootballViewController *footballVC = [[FootballViewController alloc] init];
        footballVC.title = title;
        [self.navigationController pushViewController:footballVC animated:YES];

    }else if ([title isEqualToString:@"混合使用"]) {

        titleCategoryView.titleColorGradientEnabled = NO;
        titleCategoryView.titleLabelMaskEnabled = YES;

        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
        backgroundView.indicatorHeight = 20;

        titleCategoryView.indicators = @[backgroundView, lineView];
        [self.navigationController pushViewController:testVC animated:YES];
        
    }
}

@end
