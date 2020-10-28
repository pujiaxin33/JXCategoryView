//
//  NumberViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "NumberViewController.h"
#import "JXCategoryNumberView.h"

@interface NumberViewController () <JXCategoryViewDelegate>
@property (nonatomic, strong) NSArray *numbers;
@property (nonatomic, strong) JXCategoryNumberView *myCategoryView;
@end

@implementation NumberViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadNumbers)];
    self.navigationItem.rightBarButtonItem = reloadItem;

    _numbers = @[@0, @111111, @5, @10, @2, @100, @66, @999, @33, @33, @11];

    self.myCategoryView.titles = self.titles;
    self.myCategoryView.counts = self.numbers;
    self.myCategoryView.numberLabelOffset = CGPointMake(5, 2);
    self.myCategoryView.numberStringFormatterBlock = ^NSString *(NSInteger number) {
        if (number > 999) {
            return @"999+";
        }
        return [NSString stringWithFormat:@"%ld", (long)number];
    };

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.myCategoryView.indicators = @[lineView];
}

- (JXCategoryNumberView *)myCategoryView {
    return (JXCategoryNumberView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryNumberView alloc] init];
}

- (void)reloadNumbers {
    self.numbers = @[@33, @33, @33, @33, @33, @33, @33, @33, @33, @33, @33];
    self.myCategoryView.counts = self.numbers;
    
    int x = arc4random()%15;
    int y = arc4random()%10;
    
    self.myCategoryView.numberLabelOffset = CGPointMake(x, y);
    [self.myCategoryView reloadDataWithoutListContainer];
}


@end
