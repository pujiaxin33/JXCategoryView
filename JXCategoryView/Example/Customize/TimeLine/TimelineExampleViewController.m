//
//  TimelineExampleViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/23.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "TimelineExampleViewController.h"
#import "JXCategoryTimelineView.h"

@interface TimelineExampleViewController ()
@property (nonatomic, strong) JXCategoryTimelineView *myCategoryView;
@end

@implementation TimelineExampleViewController

- (void)viewDidLoad {
    NSArray <NSString *> *status = @[@"已开抢", @"已开抢", @"已开抢", @"抢购中", @"即将开抢", @"即将开抢", @"即将开抢", @"即将开抢"];
    NSArray <NSString *> *times = @[@"10:00", @"11:00", @"12:00", @"13:00", @"14:00", @"15:00", @"16:00", @"17:00", ];
    self.titles = status;  //主要是为了父类创建列表，实际使用不要参考这个写法。

    [super viewDidLoad];

    self.myCategoryView.backgroundColor = [UIColor blackColor];
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.timeTitles = times;
    self.myCategoryView.titleLabelVerticalOffset = 13;
    self.myCategoryView.titleColorGradientEnabled = YES;
    //设置底部状态
    self.myCategoryView.titleColor = [UIColor lightGrayColor];
    self.myCategoryView.titleSelectedColor = [UIColor blackColor];
    self.myCategoryView.titleFont = [UIFont systemFontOfSize:10];
    self.myCategoryView.titleSelectedFont = [UIFont systemFontOfSize:10];
    //设置顶部时间
    self.myCategoryView.timeTitleFont = [UIFont boldSystemFontOfSize:13];
    self.myCategoryView.timeTitleSelectedFont = [UIFont boldSystemFontOfSize:15];
    self.myCategoryView.timeTitleNormalColor = [UIColor lightGrayColor];
    self.myCategoryView.timeTitleSelectedColor = [UIColor whiteColor];

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 16;
    backgroundView.indicatorCornerRadius = 8;
    backgroundView.verticalMargin = -13;
    backgroundView.indicatorColor = [UIColor whiteColor];
    self.myCategoryView.indicators = @[backgroundView];
}

- (JXCategoryTimelineView *)myCategoryView {
    return (JXCategoryTimelineView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTimelineView alloc] init];
}

@end
