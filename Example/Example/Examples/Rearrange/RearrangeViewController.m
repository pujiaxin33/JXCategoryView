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
@property (nonatomic, strong) NSMutableDictionary <NSString *, id<JXCategoryListContentViewDelegate>> *listCache;
@end

@implementation RearrangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _listCache = [NSMutableDictionary dictionary];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"重新排序" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemClicked {

    NSMutableArray *tempTitles = self.titles.mutableCopy;
    //删除第二个
    //③同时删除对应缓存的list
    [_listCache removeObjectForKey:self.titles[1]];
    [tempTitles removeObjectAtIndex:1];
    //添加两个
    [tempTitles insertObject:@"添加1" atIndex:1];
    [tempTitles insertObject:@"添加2" atIndex:2];
    //交换第一个和第四个
    [tempTitles exchangeObjectAtIndex:0 withObjectAtIndex:3];
    self.titles = tempTitles.copy;
    self.categoryView.titles = self.titles;
    [self.categoryView reloadData];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    NSString *targetTitle = self.titles[index];
    id<JXCategoryListContentViewDelegate> list = _listCache[targetTitle];
    if (list) {
        //②之前已经初始化了对应的list，就直接返回缓存的list，无需再次初始化
        return list;
    }else {
        LoadDataListContainerListViewController *listVC = [[LoadDataListContainerListViewController alloc] init];
        //①自己缓存已经初始化的列表
        _listCache[targetTitle] = listVC;
        return listVC;
    }
}

@end
