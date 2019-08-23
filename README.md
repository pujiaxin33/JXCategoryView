<div align=center><img src="JXCategoryView/Images/JXCategoryView.png" width="405" height="63" /></div>

[![platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic)](#)
[![languages](https://img.shields.io/badge/language-objective--c-blue.svg)](#) 
[![cocoapods](https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic)](https://cocoapods.org/pods/JXCategoryView)
[![support](https://img.shields.io/badge/support-ios%208%2B-orange.svg)](#) 

A powerful and easy to use category view (segmentedcontrol, segmentview, pagingview, pagerview, pagecontrol) (腾讯新闻、今日头条、QQ音乐、网易云音乐、京东、爱奇艺、腾讯视频、淘宝、天猫、简书、微博等所有主流APP分类切换滚动视图)

与其他的同类三方库对比的优点：
- 使用协议封装指示器逻辑，可以为所欲为的自定义指示器效果；
- 提供更加全面丰富、高度自定义的效果；
- 使用子类化管理cell样式，逻辑更清晰，扩展更简单；

## Swift版本

如果你在找Swift版本，请点击查看[JXSegmentedView](https://github.com/pujiaxin33/JXSegmentedView)

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
JXCategoryIndicatorLineView、JXCategoryIndicatorImageView、JXCategoryIndicatorBallView、JXCategoryIndicatorTriangleView

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
SegmentedControl<br/>参考[`SegmentedControlViewController`](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/SegmentedControl/SegmentedControlViewController.m)类 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/SegmentedControl.gif" width="343" height="80"> |
导航栏使用<br/>参考[`NaviSegmentedControlViewController`](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/SegmentedControl/NaviSegmentedControlViewController.m)类 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/SegmentedControlNavi.gif" width="343" height="80"> |
嵌套使用<br/>参考[`NestViewController`](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/Nest/NestViewController.m)类 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/Nest.gif" width="343" height="272"> |
个人主页(上下左右滚动、header悬浮)<br/>参考[`PagingViewController`](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/PagingView/Example/PagingViewController.m)类<br/> 更多样式请点击查看[JXPagingView库](https://github.com/pujiaxin33/JXPagingView) |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/UserProfile.gif" width="343" height="562"> |
垂直列表滚动<br/>参考[`VerticalListViewController`](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/VerticalListView/VerticalListViewController.m)类<br/> 高仿腾讯视频<br/>支持UITableView，参考[`VerticalListTableViewController`](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/VerticalListView/VerticalListTableViewController.m)<br/>（背景色异常是录屏软件bug） |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/VerticalList.gif" width="343" height="607"> |
| 垂直缩放(仿网易圈圈、脉脉首页)<br/>参考[`ScrollZoomViewController`](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/ScrollZoomView/ScrollZoomViewController.m)类 | <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/VerticalZoomTitle.gif" width="350" height="306"> |
数据源刷新&列表数据加载<br/>参考[`LoadDataListContainerViewController`](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/LoadData/LoadDataListContainerViewController.m)类 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/LoadData.gif" width="343" height="619"> |

### 自定义效果预览

收录来自其他使用者的自定义示例，这些自定义类只在Demo项目里面，Pod库并没有这些文件。所以，如果你需要使用这些自定义效果，请通过文件导入的方式。

目的：
- 参考学习如何自定义
- 直接修改自定义示例类以快速实现自己的需求

欢迎提PullRequest进行收录你的自定义效果。

| 说明 | Gif |
| ----|------|
| Spring动画指示器 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/SpringIndicator.gif" width="336" height="70"> |
| 富文本数量cell |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/CountCell.gif" width="336" height="70"> |
| 左右对齐指示器 |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/AlignmentIndicator.gif" width="336" height="70"> |
| 秒杀时间线cell |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/timeline.gif" width="336" height="70"> |
| 京东商品排序cell |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/JDProductSort.gif" width="336" height="70"> |
| title背景块cell |  <img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/TitleBackgroundExample.gif" width="336" height="70"> |

## 要求

- iOS 8.0+
- Xcode 9+
- Objective-C

## 安装

### 手动

Clone代码，把Sources文件夹拖入项目，#import "JXCategoryView.h"，就可以使用了；

### CocoaPods

```ruby
target '<Your Target Name>' do
    pod 'JXCategoryView'
end
```
先执行`pod repo update`，再执行`pod install`

## 结构图

<img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/JXCategoryViewStructure.png" width="933" height="482">

## 使用

### JXCategoryTitleView使用示例

1.初始化JXCategoryTitleView
```Objective-C
self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, WindowsSize.width, 50)];
self.categoryView.delegate = self;
[self.view addSubview:self.categoryView];
```
2.配置JXCategoryTitleView的属性
```Objective-C
self.categoryView.titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果"...]
self.categoryView.titleColorGradientEnabled = YES;
```

3.添加指示器
```Objective-C
JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
lineView.indicatorLineViewColor = [UIColor redColor];
lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
self.categoryView.indicators = @[lineView];
```

4.实现`JXCategoryViewDelegate`代理

```Objective-C
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index;

//点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;

//滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;

//正在滚动中的回调
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;
```

### `contentScrollView`列表容器使用示例

#### 直接使用UIScrollView自定义

因为代码比较分散，而且代码量也比较多，所有不推荐使用该方法。要正确使用需要注意的地方比较多，尤其对于刚接触iOS的同学来说不太友好。

不直接贴代码了，具体点击[LoadDataListCustomViewController](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/LoadData/LoadDataListCustomViewController.m)查看源代码了解。

作为替代，官方使用&强烈推荐使用下面这种方式👇👇👇。

#### `JXCategoryListContainerView`封装类使用示例

`JXCategoryListContainerView`是对列表视图高度封装的类，具有以下优点：
- 相对于直接使用`UIScrollView`自定义，封装度高、代码集中、使用简单；
- 列表懒加载：当显示某个列表的时候，才进行列表初始化。而不是一次性加载全部列表，性能更优；

1.初始化`JXCategoryListContainerView`
```Objective-C
self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
[self.view addSubview:self.listContainerView];
//关联cotentScrollView，关联之后才可以互相联动！！！
self.categoryView.contentScrollView = self.listContainerView.scrollView;
```

2.实现`JXCategoryListContainerViewDelegate`代理方法
```Objective-C
//返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}
//返回遵从`JXCategoryListContentViewDelegate`协议的实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    return [[ListViewController alloc] init];
}
```

3.列表实现`JXCategoryListContainerViewDelegate`代理方法

不管列表是UIView还是UIViewController都可以，提高使用灵活性，更便于现有的业务接入。
```Objective-C
// 返回列表视图
// 如果列表是VC，就返回VC.view
// 如果列表是View，就返回View自己
- (UIView *)listView {
    return self.view;
}

//可选使用，列表显示的时候调用
- (void)listDidAppear {}

//可选使用，列表消失的时候调用
- (void)listDidDisappear {}
```

4.将关键事件告知`JXCategoryListContainerView`

在下面两个`JXCategoryViewDelegate`代理方法里面调用对应的代码，一定不要忘记这一条❗️❗️❗️
```Objective-C
//传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

//传递scrolling事件给listContainerView，必须调用！！！
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}
```

具体点击[LoadDataListContainerViewController](https://github.com/pujiaxin33/JXCategoryView/blob/master/JXCategoryView/Example/LoadData/LoadDataListContainerViewController.m)查看源代码了解

#### `JXCategoryListCollectionContainerView`封装类使用示例

- 有了`JXCategoryListContainerView`为什么还要`JXCategoryListCollectionContainerView`类呢？
    - 因为`JXCategoryListContainerView`内部使用的是`UIScrollView`，当所有列表都加载出来后，所有的列表都被addSubview到`UIScrollView`上面了。所以，在视图内存这一块会比较大，对于一些列表复杂且数量多的应用，内存表现不太好。

- `JXCategoryListCollectionContainerView`的优势
    - 只有当前显示的列表才会被addSubview，视图内存表现良好；
    - 因为内部使用`UICollectionView`，在api设计上更加简洁；

具体使用示例，点击参看[JXCategoryListCollectionContainerView使用示例](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/JXCategoryListCollectionContainerView%E4%BD%BF%E7%94%A8.md)

## 指示器样式自定义

- 需要继承`JXCategoryIndicatorProtocol`协议，点击参看[JXCategoryIndicatorProtocol](https://github.com/pujiaxin33/JXCategoryView/blob/master/Sources/Common/JXCategoryIndicatorProtocol.h)
- 提供了继承`JXCategoryIndicatorProtocol`协议的基类`JXCategoryIndicatorComponentView`，里面提供了许多基础属性。点击参看[JXCategoryIndicatorComponentView](https://github.com/pujiaxin33/JXCategoryView/blob/master/Sources/Indicator/IndicatorViews/JXCategoryIndicatorComponentView.m)
- 自定义指示器，请参考已实现的指示器视图，多尝试、多思考，再有问题请提Issue或加入反馈QQ群

## Cell自定义

- 任何子类化需求，view、cell、cellModel三个都要子类化，即使某个子类cell什么事情都不做。用于维护继承链，以免以后子类化都不知道要继承谁了；
- 如果你想完全自定义cell里面的内容，那就继承`JXCategoryIndicatorView、JXCategoryIndicatorCell、JXCategoryIndicatorCellModel`，就像`JXCategoryTitleView、JXCategoryTitleCell、JXCategoryTitleCellModel`那样去做；
- 如果你只是在父类进行一些微调，那就继承目标view、cell、cellModel，对cell原有控件微调、或者加入新的控件皆可。就像`JXCategoryTitleImageView系列、JXCategoryTitleAttributeView系列`那样去做；
- Cell自定义，请参考已实现的cell样式，多尝试、多思考，再有问题请提Issue或加入反馈QQ群

## 常见问题和答案

❗️❗️❗️这里面包含了许多常见问题和答案，使用之前请务必浏览此文档，或者遇到问题先看此文档❗️❗️❗️

[常见问题和答案](https://github.com/pujiaxin33/JXCategoryView/blob/master/Document/%E4%BD%BF%E7%94%A8%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A1%B9.md)

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

## 补充

如果刚开始使用`JXCategoryView`，当开发过程中需要支持某种特性时，请务必先搜索使用文档或者源代码。确认是否已经实现支持了想要的特性。请别不要文档和源代码都没有看，就直接提问，这对于大家都是一种时间浪费。如果没有支持想要的特性，欢迎提Issue讨论，或者自己实现提一个PullRequest。

该仓库保持随时更新，对于主流新的分类选择效果会第一时间支持。使用过程中，有任何建议或问题，可以通过以下方式联系我：</br>
邮箱：317437084@qq.com </br>
QQ群： 112440473

<img src="https://github.com/pujiaxin33/JXExampleImages/blob/master/JXCategoryView/JXCategoryViewQQGroupTwo.JPG" width="300" height="411">

喜欢就star❤️一下吧

## License

JXCategoryView is released under the MIT license.
