# JXCategoryListCollectionContainerView使用

`JXCategoryListCollectionContainerView`是对列表视图高度封装的类，具有以下优点：
- 相对于直接使用`UIScrollView`自定义，封装度高、代码集中、使用简单；
- 列表懒加载：当显示某个列表的时候，才进行列表初始化。而不是一次性加载全部列表，性能更优；

1.初始化`JXCategoryListCollectionContainerView`
```Objective-C
self.listContainerView = [[JXCategoryListCollectionContainerView alloc] initWithDataSource:self];
[self.view addSubview:self.listContainerView];
//关联cotentScrollView，关联之后才可以互相联动！！！
self.categoryView.contentScrollView = self.listContainerView.collectionView;
```

2.实现`JXCategoryListContainerViewDelegate`代理方法
```Objective-C
//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListCollectionContainerView *)listContainerView {
    return self.titles.count;
}
//返回遵从`JXCategoryListContentViewDelegate`协议的实例
- (id<JXCategoryListCollectionContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    LoadDataListCollectionListViewController *listVC = [[LoadDataListCollectionListViewController alloc] init];
    listVC.naviController = self.navigationController;
    return listVC;
}
```

3.列表实现`JXCategoryListCollectionContentViewDelegate`代理方法

不管列表是UIView还是UIViewController都可以，提高使用灵活性，更便于现有的业务接入。
```Objective-C
// 返回列表视图
// 如果列表是VC，就返回VC.view
// 如果列表是View，就返回View自己
- (UIView *)listView {
    return self.view;
}
```

4.将关键事件告知`JXCategoryListContainerView`

在下面两个`JXCategoryViewDelegate`代理方法里面调用对应的代码，一定不要忘记这一条❗️❗️❗️
```Objective-C
//传递点击选中事件给listContainerView，必须调用！！！是点击选中回调方法，而不是滚动选中和通用选中方法，请注意辨别❗️❗️❗️
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

//传递scrolling事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}
```

具体点击[LoadDataListCollectionViewController](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/LoadData/LoadDataListCollectionViewController.m)查看源代码了解