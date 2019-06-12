//
//  RearrangeViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/6/12.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "RearrangeViewController.h"
#import "LoadDataListContainerListViewController.h"

@interface RearrangeViewController ()

@end

@implementation RearrangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"重新排序" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemClicked {
    //请务必正确实现①②③④个点
    NSString *currentSelectedTitle = self.titles[self.categoryView.selectedIndex];
    NSMutableArray *tempTitles = self.titles.mutableCopy;
    //测试数据，交换第一个和第三个
    [tempTitles exchangeObjectAtIndex:0 withObjectAtIndex:2];
    self.titles = tempTitles.copy;
    //计算出之前选中的title，在排序之后的index
    NSUInteger newSelectedIndex = [self.titles indexOfObject:currentSelectedTitle];
    //①
    //self.categoryView reloadData之后需要定位到新的选中位置
    self.categoryView.defaultSelectedIndex = newSelectedIndex;
    //②
    //categoryView依然通过最新的titles重新初始化
    [self.categoryView reloadData];

    //③
    //但是listContainerView不能调用reloadData，因为reloadData之后列表会重新创建。所以需要调用rearrangeList方法，会将已经初始化的列表按照最新的titles排序显示。
    //但是必须要实现`- (NSUInteger)listContainerView:(JXCategoryListContainerView *)listContainerView rearrangeList:(id<JXCategoryListContentViewDelegate>)list `代理方法，根据最新的titles返回对应的index
    [self.listContainerView rearrangeList];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (NSUInteger)listContainerView:(JXCategoryListContainerView *)listContainerView rearrangeList:(id<JXCategoryListContentViewDelegate>)list {
    LoadDataListContainerListViewController *listVC = (LoadDataListContainerListViewController *)list;
    //④
    //这个时候的self.titles是重新排序之后的数据
    //这里通过self.titles获取到最新的index，只是一个思路，你可以有其他的方法算出最新的index
    return [self.titles indexOfObject:listVC.itemTitle];
}

@end
