# JXCategoryListContainerView使用说明

## 特性

- 高度封装contentScrollView逻辑，只需少量代码即可完成列表容器逻辑；
- 列表懒加载，当通过滚动、点击选中显示某个列表的时候，才进行列表初始化，性能更优；
- 支持设置didAppearPercent。滚动距离超过一页的多少百分比，就认为切换了页面。默认0.5（即滚动超过了半屏，就认为翻页了）。范围0~1，开区间不包括0和1


## `JXCategoryListContainerViewDelegate`代理方法

```
/**
 返回list的数量

 @param listContainerView 列表的容器视图
 @return list的数量
 */
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView;

/**
 根据index初始化对应的遵从JXCategoryListContentViewDelegate协议的list，注意是初始化哟，要new一个新的实例！！！

 @param listContainerView 列表的容器视图
 @param index 目标下标
 @return 新的遵从JXCategoryListContentViewDelegate协议的list实例
 */
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index;
```

## `JXCategoryListContentViewDelegate`代理方法

列表需要实现该协议

```
/**
 如果列表是VC，就返回VC.view
 如果列表是View，就返回View自己

 @return 返回列表视图
 */
- (UIView *)listView;

@optional

/**
 可选实现，列表逻辑层面显示的时候调用
 */
- (void)listDidAppear;
/**
 可选实现，列表逻辑层面消失的时候调用
 */
- (void)listDidDisappear;
```

## 注意事项

必须要调用JXCategoryListContainerView的下列两个方法
```
//必须调用，请按照demo示例那样调用
- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex;

//必须调用，请按照demo示例那样调用（注意是是点击选中的回调，不是其他回调）
- (void)didClickSelectedItemAtIndex:(NSInteger)index;
```

## 示例

请参考`LoadDataListContainerViewController`类

