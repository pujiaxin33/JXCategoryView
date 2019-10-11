//
//  NestViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "NestViewController.h"
#import "JXCategoryTitleView.h"
#import "NestSubjectViewController.h"

@interface NestViewController ()
@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation NestViewController

- (void)viewDidLoad {
    self.titles = @[@"主题一", @"主题二", @"主题三", ];

    [super viewDidLoad];

    self.myCategoryView.titles = self.titles;
    self.myCategoryView.frame = CGRectMake(0, 0, 180, 30);
    self.myCategoryView.layer.cornerRadius = 15;
    self.myCategoryView.layer.masksToBounds = YES;
    self.myCategoryView.layer.borderColor = [UIColor redColor].CGColor;
    self.myCategoryView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    self.myCategoryView.titles = self.titles;
    self.myCategoryView.cellSpacing = 0;
    self.myCategoryView.titleColor = [UIColor redColor];
    self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
    self.myCategoryView.titleLabelMaskEnabled = YES;

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 30;
    backgroundView.indicatorWidthIncrement = 20;
    backgroundView.indicatorColor = [UIColor redColor];
    self.myCategoryView.indicators = @[backgroundView];

    [self.myCategoryView removeFromSuperview];
    self.navigationItem.titleView = self.myCategoryView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.myCategoryView.frame = CGRectMake(0, 0, 180, 30);
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (CGFloat)preferredCategoryViewHeight {
    return 0;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    NestSubjectViewController *list = [[NestSubjectViewController alloc] init];
    if (index == 0) {
        list.titles = @[@"香蕉", @"苹果", @"荔枝"];
    }else if(index == 1) {
        list.titles = @[@"冰淇淋", @"可乐"];
    }else if (index == 2) {
        list.titles = @[@"火锅", @"砂锅", @"干锅"];
    }
    return list;
}

#pragma mark - JXCategoryListContainerViewDelegate

- (void)listContainerViewDidScroll:(UIScrollView *)scrollView{
    if ([self isKindOfClass:[NestViewController class]]) {
        CGFloat index = scrollView.contentOffset.x/scrollView.bounds.size.width;
        CGFloat absIndex = fabs(index - self.currentIndex);
        if (absIndex >= 1) {
            //”快速滑动的时候，只响应最外层VC持有的scrollView“，说实话，完全可以不用处理这种情况。如果你们的产品经理坚持认为这是个问题，就把这块代码加上吧。
            //嵌套使用的时候，最外层的VC持有的scrollView在翻页之后，就断掉一次手势。解决快速滑动的时候，只响应最外层VC持有的scrollView。子VC持有的scrollView却没有响应
            self.listContainerView.scrollView.panGestureRecognizer.enabled = NO;
            self.listContainerView.scrollView.panGestureRecognizer.enabled = YES;
            _currentIndex = floor(index);
        }
    }
}

@end
