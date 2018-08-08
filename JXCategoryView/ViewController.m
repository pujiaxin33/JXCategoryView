//
//  ViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/3/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ViewController.h"
#import "JXCategoryTitleView.h"

#define WindowsSize [UIScreen mainScreen].bounds.size
#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface ViewController () <JXCategoryViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    NSArray *titles = @[@"000000000", @"11111", @"2222",@"333333333", @"4444", @"5555555", @"666666", @"777", @"88", @"9999999", @"10101010101", @"1212121212", @"131313",];

    CGFloat width = WindowsSize.width;
    CGFloat height = WindowsSize.height - 64 - 50;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+50, width, height)];
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(width*titles.count, height);
    [self.view addSubview:scrollView];
    for (int i = 0; i < titles.count; i ++) {
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
        itemView.backgroundColor = COLOR_WITH_RGB(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0, 1);
        [scrollView addSubview:itemView];
    }

    JXCategoryTitleView *view = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 64, WindowsSize.width, 50)];
    view.titles = titles;
    view.delegate = self;
    view.contentScrollView = scrollView;
    view.defaultSelectedIndex = 2;
    view.lineStyle = JXCategoryLineStyle_IQIYI;
    view.indicatorLineWidth = 20;
    //    view.indicatorViewScrollEnabled = NO;
    //    view.titleColorGradientEnabled = NO;
    //    view.indicatorLineViewShowEnabled = NO;
//    view.backEllipseLayerShowEnabled = YES;
    [self.view addSubview:view];
    [view reloadDatas];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
