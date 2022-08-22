<div align=center><img src="Example/Example/Images/JXCategoryView.png" width="405" height="63" /></div>

[![platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic)](#)
[![languages](https://img.shields.io/badge/language-objective--c-blue.svg)](#) 
[![cocoapods](https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic)](https://cocoapods.org/pods/JXCategoryView)
[![support](https://img.shields.io/badge/support-ios%208%2B-orange.svg)](#) 

A powerful and easy to use category view (segmentedcontrol, segmentview, pagingview, pagerview, pagecontrol) (腾讯新闻、今日头条、QQ 音乐、网易云音乐、京东、爱奇艺、腾讯视频、淘宝、天猫、简书、微博等所有主流 APP 分类切换滚动视图)

与其他的同类三方库对比的优点：
- 使用协议封装指示器逻辑，可以随心所欲地自定义指示器效果；
- 提供更加全面丰富、高度自定义的效果；
- 使用子类化管理 cell 样式，逻辑更清晰，扩展更简单；
- 高度封装列表容器，使用便捷，完美支持列表的生命周期调用；

## Swift版本

如果你在找 Swift 版本，请点击查看 [JXSegmentedView](https://github.com/pujiaxin33/JXSegmentedView)。

## 效果预览

### 指示器效果预览

说明 | Gif |
----|------|
LineView  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/LineView.gif" width="343" height="80"> |
LineView延长  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/JDLineStyle.gif" width="343" height="80"> |
LineView延长+偏移  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/IQIYILineStyle.gif" width="343" height="80"> |
LineView🌈彩虹风格  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/RainbowLineView.gif" width="343" height="80"> |
DotLineView点线效果 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/IndicatorCustomizeGuide.gif" width="334" height="88"> |
BallView QQ黏性红点  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/QQBall.gif" width="343" height="84"> |
TriangleView 三角形底部  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TriangleBottom.gif" width="343" height="80"> |
TriangleView 三角形顶部  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TriangleTop.gif" width="343" height="80"> |
BackgroundView椭圆形  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/BackgroundEllipseLayer.gif" width="343" height="80"> |
BackgroundView椭圆形+阴影  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/BackgroundViewShadow.gif" width="343" height="80"> |
BackgroundView长方形  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/Rectangle.gif" width="343" height="80"> |
BackgroundView遮罩有背景  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleMask.gif" width="343" height="80"> |
BackgroundView遮罩无背景  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleMaskNoBackgroundView.gif" width="343" height="80"> |
BackgroundView渐变色  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/GradientBGIndicatorView.gif" width="350" height="80"> |
ImageView底部(小船)  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/IndicatorImageView.gif" width="343" height="137"> |
ImageView背景(最佳男歌手)  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/BackgroundImageView.gif" width="343" height="80"> |
ImageView滚动效果(足球)  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/Football.gif" width="343" height="135"> |
混合使用 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/Mixed.gif" width="343" height="80"> |

以下均支持上下位置切换：
`JXCategoryIndicatorLineView`、`JXCategoryIndicatorImageView`、`JXCategoryIndicatorBallView`、`JXCategoryIndicatorTriangleView`

### Cell样式效果预览

说明 | Gif |
----|------|
颜色渐变  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleColorGradient.gif" width="343" height="80"> |
大小缩放  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleZoom.gif" width="350" height="80"> |
大小缩放+底部锚点  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleLabelAnchorBottom.gif" width="350" height="80"> |
大小缩放+顶部锚点  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleLabelAnchorTop.gif" width="350" height="80"> |
大小缩放+字体粗细  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleZoomStrokeWidth.gif" width="350" height="80"> |
大小缩放+点击动画  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleZoomSelectedAnimation.gif" width="350" height="80"> |
大小缩放+cell宽度缩放  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleZoomCellWidth.gif" width="350" height="80"> |
TitleImage_Top |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleImageTop.gif" width="343" height="80"> |
TitleImage_Left |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleImageLeft.gif" width="343" height="80"> |
TitleImage_Bottom |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleImageBottom.gif" width="343" height="80"> |
TitleImage_Right |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleImageRight.gif" width="343" height="80"> |
cell图文混用 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/CellMixed.gif" width="343" height="90"> |
Image |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/CellImage.gif" width="343" height="80"> |
数字 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/Number.gif" width="343" height="80"> |
红点 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/CellRedDot.gif" width="343" height="80"> |
多行文本 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/MultiLineText.gif" width="350" height="80"> |
多行富文本 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/AttributeView.gif" width="343" height="80"> |
Cell背景色渐变  |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/CellBackgroundColorGradient.gif" width="343" height="80"> |
分割线 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/SeparatorLine.gif" width="343" height="80"> |

### 特殊效果预览

说明 | Gif |
----|------|
数据源过少<br/> averageCellSpacingEnabled默认为YES |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/averageCellSpacingEnabledYES.gif" width="343" height="80"> |
数据源过少<br/> averageCellSpacingEnabled为NO |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/averageCellSpacingEnabledNO.gif" width="343" height="80"> |
SegmentedControl<br/>参考[`SegmentedControlViewController`](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/SegmentedControl/SegmentedControlViewController.m)类 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/SegmentedControl.gif" width="343" height="80"> |
导航栏使用<br/>参考[`NaviSegmentedControlViewController`](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/SegmentedControl/NaviSegmentedControlViewController.m)类 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/SegmentedControlNavi.gif" width="343" height="80"> |
嵌套使用<br/>参考[`NestViewController`](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/Nest/NestViewController.m)类 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/Nest.gif" width="343" height="272"> |
个人主页(上下左右滚动、header悬浮)<br/>参考[`PagingViewController`](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/PagingView/Example/PagingViewController.m)类<br/> 更多样式请点击查看[JXPagingView库](https://github.com/pujiaxin33/JXPagingView) |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/UserProfile.gif" width="343" height="562"> |
垂直列表滚动<br/>参考[`VerticalListViewController`](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/VerticalListView/VerticalListViewController.m)类<br/> 高仿腾讯视频<br/>支持UITableView，参考[`VerticalListTableViewController`](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/VerticalListView/VerticalListTableViewController.m)<br/>（背景色异常是录屏软件bug） |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/VerticalList.gif" width="343" height="607"> |
| 垂直缩放(仿网易圈圈、脉脉首页)<br/>参考[`ScrollZoomViewController`](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/ScrollZoom/ScrollZoomViewController.m)类 | <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/VerticalZoomTitle.gif" width="350" height="306"> |
数据源刷新&列表数据加载<br/>参考[`LoadDataListContainerViewController`](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/LoadData/LoadDataListContainerViewController.m)类 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/LoadData.gif" width="343" height="619"> |
上下滚动隐藏导航栏 | <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/ScrollUp.gif" width="336" height="354"> |
京东首页-滚动渐变变小 | <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/jingdo_scroll_small.gif" width="305" height="599"> |

### 自定义效果预览

收录来自其他使用者的自定义示例，这些自定义类只在 Demo 项目里面，Pod 库并没有这些文件。所以，如果你需要使用这些自定义效果，请通过文件导入的方式。

目的：
- 参考学习如何自定义；
- 直接修改自定义示例类以快速实现自己的需求。

欢迎提 PullRequest 进行收录你的自定义效果。

| 说明 | Gif |
| ----|------|
| Spring动画指示器 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/SpringIndicator.gif" width="336" height="70"> |
| 富文本数量cell |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/CountCell.gif" width="336" height="70"> |
| 左右对齐指示器 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/AlignmentIndicator.gif" width="336" height="70"> |
| 秒杀时间线cell |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/timeline.gif" width="336" height="70"> |
| 京东商品排序cell |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/JDProductSort.gif" width="336" height="70"> |
| title背景块cell |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleBackgroundExample.gif" width="336" height="70"> |

## 要求

- iOS 9.0+
- Xcode 9+
- Objective-C

## 安装

### 手动

Clone 代码，把 Sources 文件夹拖入项目，`#import "JXCategoryView.h"` 就可以使用了。

### CocoaPods

```ruby
target '<Your Target Name>' do
    pod 'JXCategoryView'
end
```
先执行 `pod repo update`，再执行 `pod install`。

## 结构图

<img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/JXCategoryViewStructure.png" width="933" height="482">

## 使用

### JXCategoryTitleView 使用示例

1. 初始化 `JXCategoryTitleView`：
```Objective-C
self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, WindowsSize.width, 50)];
self.categoryView.delegate = self;
[self.view addSubview:self.categoryView];
```

2. 配置 `JXCategoryTitleView` 的属性：
```Objective-C
self.categoryView.titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果"...];
self.categoryView.titleColorGradientEnabled = YES;
```

3. 添加指示器：
```Objective-C
JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
lineView.indicatorColor = [UIColor redColor];
lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
self.categoryView.indicators = @[lineView];
```

4. 实现 `JXCategoryViewDelegate` 代理（可选）
```Objective-C
// 点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

// 点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;

// 滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;

// 正在滚动中的回调
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;
```

### 列表容器使用示例

#### `JXCategoryListContainerView` 封装类使用示例

`JXCategoryListContainerView` 是对列表视图高度封装的类，具有以下优点：

- 相对于直接使用 `UIScrollView` 自定义，封装度高、代码集中、使用简单；
- 列表懒加载：当显示某个列表的时候，才进行列表初始化。而不是一次性加载全部列表，性能更优；
- 支持列表的 `willAppear`、`didAppear`、`willDisappear`、`didDisappear` 生命周期方法调用；

1. 初始化 `JXCategoryListContainerView` 并关联到 `categoryView`：
```Objective-C
self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
[self.view addSubview:self.listContainerView];
// 关联到 categoryView
self.categoryView.listContainer = self.listContainerView;
```

2. 实现 `JXCategoryListContainerViewDelegate` 代理方法：
```Objective-C
// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
// 根据下标 index 返回对应遵守并实现 `JXCategoryListContentViewDelegate` 协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return [[ListViewController alloc] init];
}
```

3. 列表实现 `JXCategoryListContentViewDelegate` 代理方法
不管列表是 `UIView` 还是 `UIViewController` 都可以，提高使用灵活性，更便于现有的业务接入。
```Objective-C
// 返回列表视图
// 如果列表是 VC，就返回 VC.view
// 如果列表是 View，就返回 View 自己
- (UIView *)listView {
    return self.view;
}
```


具体点击 [LoadDataListContainerViewController](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/LoadData/LoadDataListContainerViewController.m) 查看源代码了解

#### 直接使用 UIScrollView 自定义

因为代码量较多且分散，所有不推荐使用该方法。要正确使用需要注意的地方比较多，尤其对于刚接触 iOS 的同学来说不太友好。

不直接贴代码了，具体点击 [LoadDataListCustomViewController](https://github.com/pujiaxin33/JXCategoryView/tree/master/Example/Example/Examples/LoadData/LoadDataListCustomViewController.m) 查看源代码了解。


## 常见问题和答案

❗️❗️❗️这里面包含了许多常见问题和答案，使用之前请务必浏览此文档，或者遇到问题先看此文档❗️❗️❗️

[常见问题和答案总文档](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md)

- [个人主页效果更丰富的示例:JXPagingView](https://github.com/pujiaxin33/JXPagingView)
- [侧滑手势处理](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BE%A7%E6%BB%91%E6%89%8B%E5%8A%BF%E5%A4%84%E7%90%86.md)
- [列表的生命周期方法处理](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E5%88%97%E8%A1%A8%E7%9A%84%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F%E6%96%B9%E6%B3%95%E5%A4%84%E7%90%86.md)
- [`JXCategoryListContainerType`的`scrollView`和`collectionView`对比](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#jxcategorylistcontainertype%E7%9A%84scrollview%E5%92%8Ccollectionview%E5%AF%B9%E6%AF%94)
- [cell左滑删除](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#cell%E5%B7%A6%E6%BB%91%E5%88%A0%E9%99%A4)
- [`FDFullscreenPopGesture`等全屏手势处理](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E5%85%A8%E5%B1%8F%E6%89%8B%E5%8A%BF%E5%A4%84%E7%90%86.md)
- [JXCategoryView数据源刷新](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#jxcategoryview%E6%95%B0%E6%8D%AE%E6%BA%90%E5%88%B7%E6%96%B0)
- [`reloadDataWithoutListContainer`方法使用说明](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#reloaddatawithoutlistcontainer%E6%96%B9%E6%B3%95%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E)
- [listContainer或contentScrollView关联说明](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#listcontainer%E6%88%96contentscrollview%E5%85%B3%E8%81%94%E8%AF%B4%E6%98%8E)
- [点击切换列表的动画控制](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E7%82%B9%E5%87%BB%E5%88%87%E6%8D%A2%E5%88%97%E8%A1%A8%E7%9A%84%E5%8A%A8%E7%94%BB%E6%8E%A7%E5%88%B6)
- [列表cell点击跳转示例](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E5%88%97%E8%A1%A8cell%E7%82%B9%E5%87%BB%E8%B7%B3%E8%BD%AC%E7%A4%BA%E4%BE%8B)
- [列表调用`presentViewController`方法](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E5%88%97%E8%A1%A8%E8%B0%83%E7%94%A8presentviewcontroller%E6%96%B9%E6%B3%95)
- [代码选中指定index](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E4%BB%A3%E7%A0%81%E9%80%89%E4%B8%AD%E6%8C%87%E5%AE%9Aindex)
- [JXCategoryView.collectionView高度取整说明](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#jxcategoryviewcollectionview%E9%AB%98%E5%BA%A6%E5%8F%96%E6%95%B4%E8%AF%B4%E6%98%8E)
- [对父VC的automaticallyAdjustsScrollViewInsets属性设置为NO](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E5%AF%B9%E7%88%B6vc%E7%9A%84automaticallyadjustsscrollviewinsets%E5%B1%9E%E6%80%A7%E8%AE%BE%E7%BD%AE%E4%B8%BAno)
- [`JXCategoryListContainerView`内部使用`UIViewController`当做列表容器使用说明](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#jxcategorylistcontainerview%E5%86%85%E9%83%A8%E4%BD%BF%E7%94%A8uiviewcontroller%E5%BD%93%E5%81%9A%E5%88%97%E8%A1%A8%E5%AE%B9%E5%99%A8%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E)
- [使用多行文本](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E4%BD%BF%E7%94%A8%E5%A4%9A%E8%A1%8C%E6%96%87%E6%9C%AC)
- [列表容器禁止左右滑动](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E5%88%97%E8%A1%A8%E5%AE%B9%E5%99%A8%E7%A6%81%E6%AD%A2%E5%B7%A6%E5%8F%B3%E6%BB%91%E5%8A%A8)
- [单个cell刷新 ](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E5%8D%95%E4%B8%AAcell%E5%88%B7%E6%96%B0)
- [点击item时指示器和列表滚动时效果一致](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E7%82%B9%E5%87%BBitem%E6%97%B6%E6%8C%87%E7%A4%BA%E5%99%A8%E5%92%8C%E5%88%97%E8%A1%A8%E6%BB%9A%E5%8A%A8%E6%97%B6%E6%95%88%E6%9E%9C%E4%B8%80%E8%87%B4)
- [自定义建议](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md#%E8%87%AA%E5%AE%9A%E4%B9%89%E5%BB%BA%E8%AE%AE)

## 指示器样式自定义

- 需要继承 `JXCategoryIndicatorProtocol` 协议，点击参看 [JXCategoryIndicatorProtocol](https://github.com/pujiaxin33/JXCategoryView/blob/master/Sources/Common/JXCategoryIndicatorProtocol.h)；
- 提供了继承 `JXCategoryIndicatorProtocol` 协议的基类 `JXCategoryIndicatorComponentView`，里面提供了许多基础属性。点击参看 [JXCategoryIndicatorComponentView](https://github.com/pujiaxin33/JXCategoryView/blob/master/Sources/Indicator/IndicatorViews/JXCategoryIndicatorComponentView.m)；
- 自定义指示器，请参考已实现的指示器视图，多尝试、多思考，再有问题请提 Issue 或加入反馈 QQ 群。

## Cell 自定义

- 任何子类化需求，view、cell、cellModel 三个都要子类化，即使某个子类 cell 什么事情都不做。用于维护继承链，以免以后子类化都不知道要继承谁了；
- 如果你想完全自定义 cell 里面的内容，那就继承 `JXCategoryIndicatorView`、`JXCategoryIndicatorCell、`JXCategoryIndicatorCellModel`，就像`JXCategoryTitleView`、`JXCategoryTitleCell、`JXCategoryTitleCellModel`那样去做；
- 如果你只是在父类进行一些微调，那就继承目标 view、cell、cellModel，对 cell 原有控件微调、或者加入新的控件皆可。就像 `JXCategoryTitleImageView` 系列、`JXCategoryTitleAttributeView` 系列那样去做；
- Cell 自定义，请参考已实现的 cell 样式，多尝试、多思考，再有问题请提 Issue 或加入反馈 QQ 群

## 常用属性说明

[常用属性说明文档地址](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E5%B8%B8%E7%94%A8%E5%B1%9E%E6%80%A7%E8%AF%B4%E6%98%8E.md)

## 更新记录

- 2018.8.21 发布1.0.0版本，更新内容：使用POP（面向协议编程）重构指示器视图；[迁移指南](https://github.com/pujiaxin33/JXCategoryView/blob/master/Migration/1.0.0.md)
- 2018.8.22 发布1.0.1版本，更新内容：删除zoomEnabled,新增titleLabelZoomEnabled、imageZoomEnabled;
- 2018.8.23 发布1.0.2版本，更新内容：添加cellWidthZoomEnabled实现腾讯视频效果;
- 2018.8.24 发布1.0.3版本，更新内容：添加垂直列表滚动效果、指示器添加verticalMargin属性、JXCategoryViewDelegate代理方法优化;
- 2018.9.4 发布1.0.4版本，更新内容：修复bug、添加cell图文混用示例;
- 2018.12.19 发布1.1.7版本，更新内容：添加`JXCategoryListContainerView`，高度封装列表逻辑，支持懒加载列表，提升初始化性能；
- 2019.1.24 发布1.2.2版本，更新内容：非兼容更新接口`- (BOOL)selectCellAtIndex:(NSInteger)index selectedType:(JXCategoryCellSelectedType)selectedType`，自定义有用到该接口的请及时更新。
- 2019.6.21 发布1.3.13版本，更新内容：将`JXCategoryListCollectionContainerView.dataSource`移动到m实现文件，添加`- (instancetype)initWithDataSource:(id<JXCategoryListCollectionContainerViewDataSource>)dataSource`初始化方法。
- 2019.7.20 发布1.3.16版本，删除代理方法`- (void)categoryView:(JXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index;`，请使用`contentScrollViewClickTransitionAnimationEnabled`属性。`JXCategoryTitleVerticalZoomView`进行了重构，内容左边距只需要使用`contentEdgeLeft`属性即可。
- 2019.9.11 发布1.4.0版本，删除一波被标记为弃用的属性和方法；完善列表的生命周期方法的调用；`JXCategoryListCollectionContainerView`类新增和必须要调用`- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex`和`- (void)didClickSelectedItemAtIndex:(NSInteger)index`两个方法。
- 2019.9.19 发布1.5.0版本，重构列表容器，具体修改请参考[1.5.0版本迁移指南](https://github.com/pujiaxin33/JXCategoryView/blob/master/Migration/1.5.0%E7%89%88%E6%9C%AC%E8%BF%81%E7%A7%BB%E6%8C%87%E5%8D%97.md)

## 补充

如果刚开始使用`JXCategoryView`，当开发过程中需要支持某种特性时，请务必先搜索使用文档或者源代码。确认是否已经实现支持了想要的特性。请别不要文档和源代码都没有看，就直接提问，这对于大家都是一种时间浪费。如果没有支持想要的特性，欢迎提Issue讨论，或者自己实现提一个PullRequest。

该仓库保持随时更新，对于主流新的分类选择效果会第一时间支持。使用过程中，有任何建议或问题，可以通过以下方式联系我：</br>
邮箱：317437084@qq.com </br>
QQ群： 112440473

<img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/JXCategoryViewQQGroupTwo.JPG" width="300" height="411">

喜欢就star❤️一下吧

## License

JXCategoryView is released under the MIT license.
