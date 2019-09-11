//
//  NestSubjectViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/9/11.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "NestSubjectViewController.h"
#import "JXCategoryTitleView.h"

@interface NestSubjectViewController ()

@property (nonatomic, strong) JXCategoryTitleView *myCategoryView;
@end

@implementation NestSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myCategoryView.titles = self.titles;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc ]init];
    self.myCategoryView.indicators = @[lineView];
}

- (JXCategoryTitleView *)myCategoryView {
    return (JXCategoryTitleView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleView alloc] init];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //作为嵌套的子容器，不需要处理侧滑手势处理。示例demo因为是继承，所以直接覆盖掉该代理方法，达到父类不调用下面一行处理侧滑手势的代码。
//    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

@end
