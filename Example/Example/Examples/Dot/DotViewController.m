//
//  DotViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "DotViewController.h"
#import "JXCategoryDotView.h"

@interface DotViewController () <JXCategoryViewDelegate>
@property (nonatomic, strong) NSMutableArray *dotStates;
@property (nonatomic, strong) JXCategoryDotView *myCategoryView;
@end

@implementation DotViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *reloadItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(reloadDot)];
    self.navigationItem.rightBarButtonItem = reloadItem;

    _dotStates = @[@NO, @YES, @NO, @NO, @YES, @YES, @YES, @NO, @YES, @YES, @NO].mutableCopy;

    self.myCategoryView.titles = self.titles;
    self.myCategoryView.dotStates = self.dotStates;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.myCategoryView.indicators = @[lineView];
}

- (JXCategoryDotView *)myCategoryView {
    return (JXCategoryDotView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryDotView alloc] init];
}

- (void)reloadDot {
    self.dotStates = @[@NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO].mutableCopy;
    self.myCategoryView.dotStates = self.dotStates;
    [self.myCategoryView reloadDataWithoutListContainer];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);

    if ([self.dotStates[index] boolValue] == YES) {
        self.dotStates[index] = @(NO);
        self.myCategoryView.dotStates = self.dotStates;
        [categoryView reloadCellAtIndex:index];
    }
}

@end
