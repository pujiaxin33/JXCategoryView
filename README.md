# JXCategoryView
A powerful and easy to use category view (segment view, segment control, page view, scroll viewcontroller) (腾讯新闻、网易新闻、今日头条、QQ音乐、京东、爱奇艺等所有主流APP分类切换滚动视图)

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
指示器足球  |  <img src="JXCategoryView/Images/Football.gif" width="343" height="135"> |
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
个人主页 |  <img src="JXCategoryView/Images/UserProfile.gif" width="343" height="562"> |

## 要求
- iOS 8.0+
- Xcode 8+
- Objective-C

## 安装
### 手动
Clone代码，把JXCategoryView文件夹投入项目，#import "JXCategoryView.h"

### CocoaPods

## 结构图

<img src="JXCategoryView/Images/JXCategoryViewStructure.png" width="1326" height="410">

- JXCategoryComponentView、JXCategoryBackgroundImageView、JXCategoryLineStyleView完成指示器效果；
  - 如果要自定义指示器效果，选择其中一个继承，但是需要修改继承链，比如你继承JXCategoryComponentView实现XXView，那么之前继承于它的JXCategoryBackgroundImageView就要继承于XXView，不然XXView的效果不能得到传递；
- JXCategoryTitleView、JXCategoryTitleImageView、JXCategoryNumberView完成cell显示自定义；
  - 如果要自定义cell样式，选择其中一个继承，并修改cell样式；

## 常用属性说明
属性     | 说明           |
--------------|---------------|
titles    | 所有的标题 |
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

### 侧滑手势

首先，在viewDidAppear加上下面代码：
```
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}
```

#### 系统默认返回Item
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

## License
JXCategoryView is released under the MIT license.
