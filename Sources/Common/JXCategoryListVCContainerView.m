//
//  JXCategoryListContainerView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryListVCContainerView.h"

@interface JXCategoryListVCContainerView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger targetIndex;
@end

@implementation JXCategoryListVCContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    _scrollView = [[UIScrollView alloc] init];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
}

- (void)reloadData {
    [self listVCWillAppear:self.defaultSelectedIndex];
    [self listVCDidAppear:self.defaultSelectedIndex];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.scrollView.frame = self.bounds;
    //根据新的数据源重新添加listView
    for (int i = 0; i < self.listVCArray.count; i ++) {
        UIViewController *listVC = self.listVCArray[i];
        [listVC willMoveToParentViewController:self.parentViewController];
        [self.parentViewController addChildViewController:self.parentViewController];
        [listVC didMoveToParentViewController:self.parentViewController];
        listVC.view.frame = CGRectMake(i*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.scrollView addSubview:listVC.view];
    }

    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*self.listVCArray.count, self.scrollView.bounds.size.height);
}

- (void)setListVCArray:(NSArray<UIViewController *> *)listVCArray {
    for (UIViewController *vc in self.listVCArray) {
        [vc.view removeFromSuperview];
    }
    _listVCArray = listVCArray;

    [self setNeedsLayout];
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex {
    _defaultSelectedIndex = defaultSelectedIndex;

    self.currentIndex = defaultSelectedIndex;
}

- (void)parentVCWillAppear:(BOOL)animated {
    [self listVCWillAppear:self.currentIndex];
}

- (void)parentVCDidAppear:(BOOL)animated {
    [self listVCDidAppear:self.currentIndex];
}

- (void)parentVCWillDisappear:(BOOL)animated {
    [self listVCWillDisappear:self.currentIndex];
}

- (void)parentVCDidDisappear:(BOOL)animated {
    [self listVCDidDisappear:self.currentIndex];
}

- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    NSInteger targetIndex = 0;
    if (ratio > 0.5) {
        targetIndex = leftIndex;
    }else {
        targetIndex = rightIndex;
    }
    if (self.targetIndex != targetIndex) {
        [self listVCWillAppear:targetIndex];
        [self listVCWillDisappear:self.currentIndex];
    }
}

- (void)didScrollSelectedItemAtIndex:(NSInteger)index {
    [self listVCDidDisappear:self.currentIndex];
    [self listVCDidAppear:index];
}

- (void)didClickSelectedItemAtIndex:(NSInteger)index {
    [self listVCWillAppear:index];
    [self listVCWillDisappear:self.currentIndex];

    [self listVCDidDisappear:self.currentIndex];
    [self listVCDidAppear:index];
}

#pragma mark - Private

- (void)listVCWillAppear:(NSInteger)index {
    self.targetIndex = index;

    UIViewController *vc = self.listVCArray[index];
    [vc beginAppearanceTransition:YES animated:YES];
}

- (void)listVCDidAppear:(NSInteger)index {
    self.currentIndex = index;
    UIViewController *vc = self.listVCArray[index];
    [vc endAppearanceTransition];
}

- (void)listVCWillDisappear:(NSInteger)index {
    UIViewController *vc = self.listVCArray[index];
    [vc beginAppearanceTransition:NO animated:YES];
}

- (void)listVCDidDisappear:(NSInteger)index {
    UIViewController *vc = self.listVCArray[index];
    [vc endAppearanceTransition];
}


@end
