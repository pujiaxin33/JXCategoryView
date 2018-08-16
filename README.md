<div align=center><img src="JXCategoryView/Images/JXCategoryView.png" width="405" height="63" /></div>

[![platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic)](#)
[![languages](https://img.shields.io/badge/language-objective--c-blue.svg)](#) 
[![cocoapods](https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic)](https://cocoapods.org/pods/JXCategoryView)
[![support](https://img.shields.io/badge/support-ios%208%2B-orange.svg)](#) 

[There is an English version of README here. just click it！](https://github.com/pujiaxin33/JXCategoryView/blob/master/README-English.md)

A powerful and easy to use category view (segmentedcontrol, pagingview, pagerview, pagecontrol, scrollview) (腾讯新闻、网易新闻、今日头条、QQ音乐、京东、爱奇艺等所有主流APP分类切换滚动视图)

与其他的同类三方库对比的优点：
- 效果更加全面，使用更加方便；
- 使用子类化管理代码，逻辑更清晰，功能扩展更简单；

## 效果预览

说明 | Gif |
----|------|
颜色渐变  |  <img src="JXCategoryView/Images/TitleColorGradient.gif" width="343" height="80"> |
大小缩放  |  <img src="JXCategoryView/Images/Zoom.gif" width="343" height="80"> |
指示器LineView  |  <img src="JXCategoryView/Images/LineView.gif" width="343" height="80"> |
指示器LineView京东风格  |  <img src="JXCategoryView/Images/JDLineStyle.gif" width="343" height="80"> |
指示器LineView爱奇艺风格  |  <img src="JXCategoryView/Images/IQIYILineStyle.gif" width="343" height="80"> |
指示器EllipseLayer  |  <img src="JXCategoryView/Images/BackgroundEllipseLayer.gif" width="343" height="80"> |
指示器EllipseLayer遮罩  |  <img src="JXCategoryView/Images/TitleMask.gif" width="343" height="80"> |
指示器ImageView(小船)  |  <img src="JXCategoryView/Images/IndicatorImageView.gif" width="343" height="137"> |
指示器滚动效果(足球)  |  <img src="JXCategoryView/Images/Football.gif" width="343" height="135"> |
指示器背景图(菜篮) |  <img src="JXCategoryView/Images/BackgroundImageView.gif" width="343" height="80"> |
SegmentedControl |  <img src="JXCategoryView/Images/SegmentedControl.gif" width="343" height="80"> |
导航栏使用 |  <img src="JXCategoryView/Images/SegmentedControlNavi.gif" width="343" height="80"> |
分割线 |  <img src="JXCategoryView/Images/SeparatorLine.gif" width="343" height="80"> |
TitleImage_Top |  <img src="JXCategoryView/Images/TitleImageTop.gif" width="343" height="80"> |
TitleImage_Left |  <img src="JXCategoryView/Images/TitleImageLeft.gif" width="343" height="80"> |
TitleImage_Bottom |  <img src="JXCategoryView/Images/TitleImageBottom.gif" width="343" height="80"> |
TitleImage_Right |  <img src="JXCategoryView/Images/TitleImageRight.gif" width="343" height="80"> |
TitleImage_OnlyImage |  <img src="JXCategoryView/Images/TitleImageOnlyImage.gif" width="343" height="80"> |
自定义-数字 |  <img src="JXCategoryView/Images/Number.gif" width="343" height="80"> |
个人主页(上下左右滚动、header悬浮) |  <img src="JXCategoryView/Images/UserProfile.gif" width="343" height="562"> |

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

## 结构图

<img src="JXCategoryView/Images/JXCategoryViewStructure.png" width="1326" height="400">

- 学习借鉴了`MJRefresh`的子类化思想：基类搭建基础，子类实现特殊效果。便于代码管理，功能扩展；
- JXCategoryComponentView、JXCategoryBackgroundImageView、JXCategoryLineStyleView完成指示器效果；
  - 如果要自定义指示器效果，选择其中一个继承，但是需要修改继承链，比如你继承JXCategoryComponentView实现XXView，那么之前继承于它的JXCategoryBackgroundImageView就要继承于XXView，不然XXView的效果不能得到传递；
- JXCategoryTitleView、JXCategoryTitleImageView、JXCategoryNumberView完成cell显示自定义；
  - 如果要自定义cell样式，选择其中一个继承，并修改cell样式；
- **特殊说明：** 即使提供了灵活扩展，我的源码也不可能满足所有情况，建议大家可以通过fork仓库，维护自己的一套效果。也可以直接拖入源文件进行修改。
- 个人主页效果：上下左右滚动且HeaderView悬浮的实现，用的是我写的这个库[JXPagingView](https://github.com/pujiaxin33/JXPagingView)。

## 常用属性说明

多个属性可以任意搭配使用，但是效果需要自己把控，效果不是越多越好哟

属性     | 说明           |
--------------|---------------|
defaultSelectedIndex    | 默认选中的index，用于初始化时指定选中某个index |
selectedIndex    | 只读属性，当前选中的index |
cellWidth    | cell的宽度，默认：JXCategoryViewAutomaticDimension |
cellSpacing    | cell之间的间距，默认20 |
averageCellWidthEnabled    | 当cell内容总宽度小于JXCategoryBaseView的宽度，是否将cellWidth均分。默认为YES。 |
contentScrollView    | 需要关联的contentScrollView，内部监听`contentOffset` |
titleColor    | titleLabel未选中颜色 默认：[UIColor blackColor] |
titleSelectedColor    | titleLabel选中颜色 默认：[UIColor redColor] |
titleFont    | titleLabel的字体 默认：[UIFont systemFontOfSize:15] |
titleColorGradientEnabled    | title的颜色是否渐变过渡 默认：NO |
titleLabelMaskEnabled    | titleLabel是否遮罩过滤 默认：NO |
JXCategoryLineStyle    | 京东、爱奇艺效果 默认：None |
JXCategoryTitleImageType    | 图片所在位置：上面、左边、下面、右边 默认：左边 |
backgroundContainerView    | 承载背景指示器视图的容器，比如backgroundEllipseLayer、backgroundImageView |
indicatorLineViewShowEnabled    | 是否显示指示器LineView 默认：YES （颜色、宽高可以设置）|
indicatorImageViewShowEnabled    | 指示器ImageView是否展示 默认：NO （indicatorImageView公开、宽高可以设置）|
indicatorImageViewRollEnabled    | 指示器ImageView是否滚动（足球效果） 默认：NO |
backgroundEllipseLayerShowEnabled    | 指示器backgroundEllipseLayer是否展示 默认：NO (颜色、宽、高、圆角、宽度补偿可以设置) |
zoomEnabled    | cell是否缩放 默认：NO |
zoomScale    | cell缩放比例 默认：1.2 |
separatorLineShowEnabled    | cell分割线是否展示 默认：NO (颜色、宽高可以设置) |
backgroundImageViewShowEnabled    | backgroundImageView是否展示 默认：NO (backgroundImageView公开、宽高可以设置) |


## 使用

```
self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, WindowsSize.width, categoryViewHeight)];
self.categoryView.delegate = self;
self.categoryView.contentScrollView = self.scrollView;
//------配置各类属性------//
[self.view addSubview:self.categoryView];
```
数据源、属性配置有变动时（比如从服务器拉取回来数据），需要调用`reloadDatas`方法刷新状态。

### 子类化注意事项

任何子类化，view、cell、cellModel三个都要子类化，即使某个子类cell什么事情都不做。用于维护继承链，以免以后子类化都不知道要继承谁了

#### 子类化cell样式

主要重载的方法，参考：`JXCategoryTitleView、JXCategoryTitleImageView、JXCategoryNumberView`
- `- (Class)preferredCellClass`返回自定义的cell；
- `- (void)refreshDataSource`刷新数据源，使用自定义的cellModel；
- `- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index `初始化、reloadDatas时对数据源重置；
- `- (CGFloat)preferredCellWidthWithIndex:(NSInteger)index`根据cell的内容返回对应的宽度；
- `- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel`cell选中时进行状态刷新；
- `- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio`cell左右滚动切换的时候，进行状态刷新；

#### 指示器样式自定义

参考：`JXCategoryComponentView、JXCategoryBackgroundImageView、JXCategoryLineStyleView`
- 背景指示器视图自定义，添加到`backgroundContainerView`上面（比如backgroundEllipseLayer、backgroundImageView）；
- 底部指示图自定义，添加collectionView上面（比如indicatorLineView、indicatorImageView）；
- `- (void)refreshState`重载，根据属性刷新指示器状态；
- `- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset`重载，根据滚动进度刷新指示器状态；
- `- (BOOL)selectItemWithIndex:(NSInteger)index`重载，自定义点击的时候指示器刷新逻辑；

### 侧滑手势

首先，在viewDidAppear加上下面代码：
```
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}
```

#### 系统默认返回Item

- 点击处理：
```
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
```

#### 自定义导航栏返回Item

- 设置代理：self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
- 实现代理方法：
```
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
```
- 点击处理：
```
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
```

### contentScrollView

- 布局灵活：JXCategoryView没有与contentScrollView强关联，你甚至可以不设置这个属性，把它当做简单的SegmentedControl。他们之间布局没有任何要求，可以把JXCategoryView放入导航栏、UITableViewSectionHeader等任何你想要的地方。
- 点击处理：因为充分解耦，在JXCategoryView点击回调中，你需要添加如下代码进行内容滚动切换：
```
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
}
```

## 补充

该仓库保持随时更新，对于主流新的分类选择效果会第一时间支持。使用过程中，有任何建议或问题，可以通过以下方式联系我：</br>
邮箱：317437084@qq.com </br>
QQ群： 112440151

<img src="https://note.youdao.com/yws/public/resource/c6fa96a65e424afcf7f6304ddf5c283a/xmlnote/WEBRESOURCE625c5369d52b2852d33e6e7887d7b5ab/2800" width="300" height="411">

喜欢就star❤️一下吧

## License

JXCategoryView is released under the MIT license.
