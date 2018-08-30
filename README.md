<div align=center><img src="JXCategoryView/Images/JXCategoryView.png" width="405" height="63" /></div>

[![platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic)](#)
[![languages](https://img.shields.io/badge/language-objective--c-blue.svg)](#) 
[![cocoapods](https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic)](https://cocoapods.org/pods/JXCategoryView)
[![support](https://img.shields.io/badge/support-ios%208%2B-orange.svg)](#) 

[There is an English version of README here. just click it！](https://github.com/pujiaxin33/JXCategoryView/blob/master/README-English.md)

A powerful and easy to use category view (segmentedcontrol, segmentview, pagingview, pagerview, pagecontrol) (腾讯新闻、今日头条、QQ音乐、网易云音乐、京东、爱奇艺、腾讯视频、淘宝、天猫、简书、微博等所有主流APP分类切换滚动视图)

与其他的同类三方库对比的优点：
- 使用POP(Protocol Oriented Programming面对协议编程)封装指示器逻辑，可以为所欲为的自定义指示器效果；
- 提供更加全面丰富的效果，交互更加顺畅；
- 使用子类化管理cell样式，逻辑更清晰，扩展更简单；

## 效果预览

### 指示器效果预览

说明 | Gif |
----|------|
LineView  |  <img src="JXCategoryView/Images/LineView.gif" width="343" height="80"> |
LineView京东风格  |  <img src="JXCategoryView/Images/JDLineStyle.gif" width="343" height="80"> |
LineView爱奇艺风格  |  <img src="JXCategoryView/Images/IQIYILineStyle.gif" width="343" height="80"> |
BallView QQ黏性红点  |  <img src="JXCategoryView/Images/QQBall.gif" width="343" height="84"> |
TriangleView 三角形底部  |  <img src="JXCategoryView/Images/TriangleBottom.gif" width="343" height="80"> |
TriangleView 三角形顶部  |  <img src="JXCategoryView/Images/TriangleTop.gif" width="343" height="80"> |
BackgroundView椭圆形  |  <img src="JXCategoryView/Images/BackgroundEllipseLayer.gif" width="343" height="80"> |
BackgroundView椭圆形+阴影  |  <img src="JXCategoryView/Images/BackgroundViewShadow.gif" width="343" height="80"> |
BackgroundView长方形  |  <img src="JXCategoryView/Images/Rectangle.gif" width="343" height="80"> |
BackgroundView遮罩有背景  |  <img src="JXCategoryView/Images/TitleMask.gif" width="343" height="80"> |
BackgroundView遮罩无背景  |  <img src="JXCategoryView/Images/TitleMaskNoBackgroundView.gif" width="343" height="80"> |
ImageView底部(小船)  |  <img src="JXCategoryView/Images/IndicatorImageView.gif" width="343" height="137"> |
ImageView背景(最佳男歌手)  |  <img src="JXCategoryView/Images/BackgroundImageView.gif" width="343" height="80"> |
ImageView滚动效果(足球)  |  <img src="JXCategoryView/Images/Football.gif" width="343" height="135"> |
混合使用 |  <img src="JXCategoryView/Images/Mixed.gif" width="343" height="80"> |
indicator自定义-点线效果 |  <img src="JXCategoryView/Images/IndicatorCustomizeGuide.gif" width="343" height="80"> |

JXCategoryIndicatorLineView、JXCategoryIndicatorImageView、JXCategoryIndicatorBallView、JXCategoryIndicatorTriangleView均支持上下位置切换。

### Cell样式效果预览

说明 | Gif |
----|------|
颜色渐变  |  <img src="JXCategoryView/Images/TitleColorGradient.gif" width="343" height="80"> |
大小缩放  |  <img src="JXCategoryView/Images/Zoom.gif" width="343" height="80"> |
Cell背景色渐变  |  <img src="JXCategoryView/Images/CellBackgroundColorGradient.gif" width="343" height="80"> |
分割线 |  <img src="JXCategoryView/Images/SeparatorLine.gif" width="343" height="80"> |
TitleImage_Top |  <img src="JXCategoryView/Images/TitleImageTop.gif" width="343" height="80"> |
TitleImage_Left |  <img src="JXCategoryView/Images/TitleImageLeft.gif" width="343" height="80"> |
TitleImage_Bottom |  <img src="JXCategoryView/Images/TitleImageBottom.gif" width="343" height="80"> |
TitleImage_Right |  <img src="JXCategoryView/Images/TitleImageRight.gif" width="343" height="80"> |
Image |  <img src="JXCategoryView/Images/CellImage.gif" width="343" height="80"> |
数字 |  <img src="JXCategoryView/Images/Number.gif" width="343" height="80"> |
红点 |  <img src="JXCategoryView/Images/CellRedDot.gif" width="343" height="80"> |
自定义-多行+富文本 |  <img src="JXCategoryView/Images/AttributeView.gif" width="343" height="80"> |
腾讯视频效果  |  <img src="JXCategoryView/Images/TXVedio.gif" width="343" height="80">  |

### 特殊效果预览

说明 | Gif |
----|------|
SegmentedControl |  <img src="JXCategoryView/Images/SegmentedControl.gif" width="343" height="80"> |
导航栏使用 |  <img src="JXCategoryView/Images/SegmentedControlNavi.gif" width="343" height="80"> |
嵌套使用 |  <img src="JXCategoryView/Images/Nest.gif" width="343" height="272"> |
个人主页(上下左右滚动、header悬浮) |  <img src="JXCategoryView/Images/UserProfile.gif" width="343" height="562"> |
垂直列表滚动<br/> 高仿腾讯视频<br/>（背景色异常是录屏软件bug） |  <img src="JXCategoryView/Images/VerticalList.gif" width="343" height="607"> |
数据源刷新&列表数据加载 示例 |  <img src="JXCategoryView/Images/LoadData.gif" width="343" height="619"> |


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

`pod install`之前务必`pod repo udpate`一下

## 结构图

<img src="JXCategoryView/Images/JXCategoryViewStructure.png" width="933" height="482">

- 指示器样式自定义：使用POP(Protocol Oriented Programming面对协议编程)封装指示器逻辑，只要遵从`JXCategoryIndicatorProtocol`协议，就可以实现你的指示器效果。参考：JXCategoryIndicatorLineView；
- Cell样式自定义：使用子类化，基类搭建基础，子类实现特殊效果。便于代码管理，功能扩展；参考：JXCategoryNumberView；

## 特殊说明

- 自定义：即使提供了灵活扩展，我的源码也不可能满足所有情况，建议大家可以通过fork仓库，维护自己的一套效果。也可以直接拖入源文件进行修改。
- 个人主页效果：上下左右滚动且HeaderView悬浮的实现，用的是我写的这个库[JXPagingView](https://github.com/pujiaxin33/JXPagingView)。
- 垂直列表滚动：参考demo工程的`VerticalListViewController`，未做功能封装，参考里面的代码做，多注意注释，就可以实现了。

## 常用属性说明

### JXCategoryView常用属性说明

属性     | 说明           |
--------------|---------------|
defaultSelectedIndex    | 默认选中的index，用于初始化时指定选中某个index |
selectedIndex    | 只读属性，当前选中的index |
cellWidth    | cell的宽度，默认：JXCategoryViewAutomaticDimension |
cellSpacing    | cell之间的间距，默认20 |
cellWidthIncrement    | cell宽度的补偿值，默认0 |
averageCellWidthEnabled    | 当cell内容总宽度小于JXCategoryBaseView的宽度，是否将cellWidth均分。默认为YES。 |
contentScrollView    | 需要关联的contentScrollView，内部监听`contentOffset` |

### Cell样式常用属性说明

属性     | 说明           |
--------------|---------------|
titleColor    | titleLabel未选中颜色 默认：[UIColor blackColor] |
titleSelectedColor    | titleLabel选中颜色 默认：[UIColor redColor] |
titleFont    | titleLabel的字体 默认：[UIFont systemFontOfSize:15] |
titleColorGradientEnabled    | title的颜色是否渐变过渡 默认：NO |
titleLabelMaskEnabled    | titleLabel是否遮罩过滤 默认：NO |
titleLabelZoomEnabled    | titleLabel是否缩放 默认：NO |
titleLabelZoomScale    | citleLabel缩放比例 默认：1.2 |
imageZoomEnabled    | imageView是否缩放 默认：NO |
imageZoomScale    | imageView缩放比例 默认：1.2 |
separatorLineShowEnabled    | cell分割线是否展示 默认：NO (颜色、宽高可以设置) |
JXCategoryTitleImageType    | 图片所在位置：上面、左边、下面、右边 默认：左边 |

### 指示器常用属性说明

属性     | 说明           |
--------------|---------------|
JXCategoryIndicatorComponentView.componentPosition    | 指示器的位置 默认：Bottom |
JXCategoryIndicatorComponentView.scrollEnabled    | 手势滚动、点击切换的时候，是否允许滚动，默认YES |
JXCategoryIndicatorLineView.lineStyle    | 普通、京东、爱奇艺效果 默认：Normal |
JXCategoryIndicatorLineView.lineScrollOffsetX    | 爱奇艺效果专用，line滚动时x的偏移量，默认为10； |
JXCategoryIndicatorLineView.indicatorLineWidth   | 默认JXCategoryViewAutomaticDimension（与cellWidth相等） |
JXCategoryIndicatorLineView.indicatorLineViewHeight    | 默认：3 |
JXCategoryIndicatorLineView.indicatorLineViewCornerRadius    | 默认JXCategoryViewAutomaticDimension （等于self.indicatorLineViewHeight/2） |
JXCategoryIndicatorLineView.indicatorLineViewColor    | 默认为[UIColor redColor]  |
JXCategoryIndicatorTriangleView.triangleViewSize   | 默认：CGSizeMake(14, 10)  |
JXCategoryIndicatorTriangleView.triangleViewColor    | 默认为[UIColor redColor]  |
JXCategoryIndicatorImageView.indicatorImageView    | 设置image |
JXCategoryIndicatorImageView.indicatorImageViewRollEnabled    | 是否允许滚动，默认：NO |
JXCategoryIndicatorImageView.indicatorImageViewSize    | 默认：CGSizeMake(30, 20)  |
JXCategoryIndicatorBackgroundView.backgroundViewWidth    | 默认JXCategoryViewAutomaticDimension（与cellWidth相等） |
JXCategoryIndicatorBackgroundView.backgroundViewWidthIncrement    | 宽度增量补偿，因为backgroundEllipseLayer一般会比实际内容大一些。默认10 |
JXCategoryIndicatorBackgroundView.backgroundViewHeight    | 默认JXCategoryViewAutomaticDimension（与cell高度相等） |
JXCategoryIndicatorBackgroundView.backgroundViewCornerRadius    | 默认JXCategoryViewAutomaticDimension(即backgroundViewHeight/2) |
JXCategoryIndicatorBackgroundView.backgroundViewColor    | 默认为[UIColor redColor] |
JXCategoryIndicatorBallView.ballViewSize    | 默认：CGSizeMake(15, 15) |
JXCategoryIndicatorBallView.ballScrollOffsetX    | 小红点的偏移量 默认：20 |
JXCategoryIndicatorBallView.ballViewColor    | 默认为[UIColor redColor] |

可以多个IndicatorView搭配使用，但是效果需要自己把控，效果不是越多越好。参考混合使用；

## 使用

```
self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, WindowsSize.width, categoryViewHeight)];
self.categoryView.delegate = self;
self.categoryView.contentScrollView = self.scrollView;
//------指示器属性配置------//
//lineView
JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//triangleView
JXCategoryIndicatorTriangleView *triangleView = [[JXCategoryIndicatorTriangleView alloc] init];
lineView.indicatorLineWidth = 20;
//ballView
JXCategoryIndicatorBallView *ballView = [[JXCategoryIndicatorBallView alloc] init];
//backgroundView
JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];

titleCategoryView.indicators = @[lineView, triangleView, ballView, backgroundView];

[self.view addSubview:self.categoryView];
```

- 单个cell刷新：比如红点示例里面，调用`- (void)reloadCell:(NSUInteger)index`
- 所有状态重置：数据源、属性配置有变动时（比如从服务器拉取回来数据），需要调用`reloadDatas`方法刷新状态。

### 指示器样式自定义

仓库自带：`JXCategoryIndicatorLineView、JXCategoryIndicatorTriangleView、JXCategoryIndicatorImageView、JXCategoryIndicatorBackgroundView、JXCategoryIndicatorBallView`

主要实现的方法：
- 继承JXCategoryIndicatorComponentView，内部遵从了`JXCategoryIndicatorProtocol`协议；
- 实现协议方法，自定义效果：
    - `- (void)jx_refreshState:(CGRect)selectedCellFrame`初始化或reloadDatas，重置状态；
    - `- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(JXCategoryCellClickedPosition)selectedPosition percent:(CGFloat)percent` contentScrollView在进行手势滑动时，处理指示器跟随手势变化UI逻辑；
    - `- (void)jx_selectedCell:(CGRect)cellFrame clickedRelativePosition:(JXCategoryCellClickedPosition)clickedRelativePosition`根据选中的某个cell，处理过渡效果；
    
具体实例：参考demo工程里面的`JXCategoryIndicatorDotLineView`

### Cell子类化注意事项

仓库自带：`JXCategoryTitleView、JXCategoryTitleImageView、JXCategoryNumberView、JXCategoryDotView、JXCategoryImageView`

主要实现的方法：
- `- (Class)preferredCellClass`返回自定义的cell；
- `- (void)refreshDataSource`刷新数据源，使用自定义的cellModel；
- `- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index `初始化、reloadDatas时对数据源重置；
- `- (CGFloat)preferredCellWidthWithIndex:(NSInteger)index`根据cell的内容返回对应的宽度；
- `- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel`cell选中时进行状态刷新；
- `- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio`cell左右滚动切换的时候，进行状态刷新；

具体实例：参考demo工程里面的`JXCategoryTitleAttributeView`

#### 继承提示

- 任何子类化，view、cell、cellModel三个都要子类化，即使某个子类cell什么事情都不做。用于维护继承链，以免以后子类化都不知道要继承谁了；
- 如果你先完全自定义cell里面的内容，那就继承`JXCategoryIndicatorView、JXCategoryIndicatorCell、JXCategoryIndicatorCellModel`，就像`JXCategoryTitleView、JXCategoryTitleCell、JXCategoryTitleCellModel`那样去做；
- 如果你只是在父类进行一些微调，那就继承目标view、cell、cellModel，对cell原有控件微调、或者加入新的控件皆可。就像`JXCategoryTitleImageView系列、JXCategoryTitleAttributeView系列`那样去做；

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

## 更新记录

- 2018.8.21 发布1.0.0版本，更新内容：使用POP（面向协议编程）重构指示器视图；[迁移指南](https://github.com/pujiaxin33/JXCategoryView/blob/master/Migration/1.0.0.md)
- 2018.8.22 发布1.0.1版本，更新内容：删除zoomEnabled,新增titleLabelZoomEnabled、imageZoomEnabled;
- 2018.8.23 发布1.0.2版本，更新内容：添加cellWidthZoomEnabled实现腾讯视频效果;
- 2018.8.24 发布1.0.3版本，更新内容：添加垂直列表滚动效果、指示器添加verticalMargin属性、JXCategoryViewDelegate代理方法优化;

## 补充

该仓库保持随时更新，对于主流新的分类选择效果会第一时间支持。使用过程中，有任何建议或问题，可以通过以下方式联系我：</br>
邮箱：317437084@qq.com </br>
QQ群： 112440151

<img src="https://note.youdao.com/yws/public/resource/c6fa96a65e424afcf7f6304ddf5c283a/xmlnote/WEBRESOURCE625c5369d52b2852d33e6e7887d7b5ab/2800" width="300" height="411">

喜欢就star❤️一下吧

## License

JXCategoryView is released under the MIT license.
