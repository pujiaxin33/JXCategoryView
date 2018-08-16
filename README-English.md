<div align=center><img src="JXCategoryView/Images/JXCategoryView.png" width="405" height="63" /></div>

[![platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic)](#)
[![languages](https://img.shields.io/badge/language-objective--c-blue.svg)](#) 
[![cocoapods](https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic)](https://cocoapods.org/pods/JXCategoryView)
[![support](https://img.shields.io/badge/support-ios%208%2B-orange.svg)](#) 

A powerful and easy to use category view (segmentedcontrol, pagingview, pagerview, pagecontrol, scrollview)

Advantages compared to other similar tripartite libraries:
- The effect is more comprehensive and more convenient to use;
- Using subclass management code, the logic is clearer and the function expansion is simpler;

## Preview

Description | Gif |
----|------|
TitleColorGradient  |  <img src="JXCategoryView/Images/TitleColorGradient.gif" width="343" height="80"> |
Zoom  |  <img src="JXCategoryView/Images/Zoom.gif" width="343" height="80"> |
IndicatorLineView  |  <img src="JXCategoryView/Images/LineView.gif" width="343" height="80"> |
IndicatorLineViewStyle_JD  |  <img src="JXCategoryView/Images/JDLineStyle.gif" width="343" height="80"> |
IndicatorLineViewStyle_IQIYI  |  <img src="JXCategoryView/Images/IQIYILineStyle.gif" width="343" height="80"> |
IndicatorEllipseLayer  |  <img src="JXCategoryView/Images/BackgroundEllipseLayer.gif" width="343" height="80"> |
IndicatorEllipseLayerMask  |  <img src="JXCategoryView/Images/TitleMask.gif" width="343" height="80"> |
IndicatorImageView(boat)  |  <img src="JXCategoryView/Images/IndicatorImageView.gif" width="343" height="137"> |
IndicatorImageViewRotate(football)  |  <img src="JXCategoryView/Images/Football.gif" width="343" height="135"> |
IndicatorBackgroundImageView(basket) |  <img src="JXCategoryView/Images/BackgroundImageView.gif" width="343" height="80"> |
SegmentedControl |  <img src="JXCategoryView/Images/SegmentedControl.gif" width="343" height="80"> |
NavigationUse |  <img src="JXCategoryView/Images/SegmentedControlNavi.gif" width="343" height="80"> |
SeparatorLine |  <img src="JXCategoryView/Images/SeparatorLine.gif" width="343" height="80"> |
TitleImage_Top |  <img src="JXCategoryView/Images/TitleImageTop.gif" width="343" height="80"> |
TitleImage_Left |  <img src="JXCategoryView/Images/TitleImageLeft.gif" width="343" height="80"> |
TitleImage_Bottom |  <img src="JXCategoryView/Images/TitleImageBottom.gif" width="343" height="80"> |
TitleImage_Right |  <img src="JXCategoryView/Images/TitleImageRight.gif" width="343" height="80"> |
TitleImage_OnlyImage |  <img src="JXCategoryView/Images/TitleImageOnlyImage.gif" width="343" height="80"> |
Custom-number |  <img src="JXCategoryView/Images/Number.gif" width="343" height="80"> |
UserProfile(Scroll up and down、header suspension) |  <img src="JXCategoryView/Images/UserProfile.gif" width="343" height="562"> |

## Requirements

- iOS 8.0+
- Xcode 9+
- Objective-C

## Installation

### Manual

Clone code, drag the Sources folder into the project, #import "JXCategoryView.h", you can use it;

### CocoaPods

```ruby
target '<Your Target Name>' do
    pod 'JXCategoryView'
end
```

## Structure

<img src="JXCategoryView/Images/JXCategoryViewStructure.png" width="1326" height="400">

- Learning the subclassing idea of `MJRefresh`: the base class builds the foundation, and the subclass achieves special effects. Easy code management and function expansion;
- JXCategoryComponentView, JXCategoryBackgroundImageView, JXCategoryLineStyleView complete indicator effect;
  - If you want to customize the indicator effect, select one of this inheritance, but you need to modify the inheritance chain. For example, if you inherit JXCategoryComponentView and implement XXView, then the JXCategoryBackgroundImageView that inherits from it will inherit from XXView, otherwise the effect of XXView cannot be passed.
- JXCategoryTitleView, JXCategoryTitleImageView, JXCategoryNumberView complete cell display customization;
  - If you want to customize the cell style, select one of this inheritance and modify the cell style;
- **Special instructions: ** Even if flexible extensions are provided, my source code will not be able to satisfy all situations. It is recommended that you can maintain your own set of effects through the fork repository. You can also drag directly into the source file to modify it.
- Personal homepage effect: Used this library I wrote.[JXPagingView](https://github.com/pujiaxin33/JXPagingView)。

## Common attribute description

Multiple attributes can be used in any combination, but the effect needs to be controlled by yourself. 

Attribute | Description |
--------------|---------------|
defaultSelectedIndex | The default selected index, used to specify an index when initializing |
selectedIndex | read-only property, currently selected index |
cellWidth | cell width, default: JXCategoryViewAutomaticDimension |
cellSpacing | spacing between cells, default 20 |
averageCellWidthEnabled | Whether the cellWidth is evenly divided when the total width of the cell content is less than the width of the JXCategoryBaseView. The default is YES. |
contentScrollView | The associated contentScrollView, internal KVO `contentOffset` |
titleColor | titleLabel unselected color Default: [UIColor blackColor] |
titleSelectedColor | titleLabel selected color Default: [UIColor redColor] |
titleFont | titleLabel's font Default: [UIFont systemFontOfSize:15] |
titleColorGradientEnabled | The color of the title is a gradual transition Default: NO |
titleLabelMaskEnabled | titleLabel mask filtering Default: NO |
JXCategoryLineStyle | IndicatorLineViewStyle Default: None |
JXCategoryTitleImageType | Image location: top, left, bottom, right Default: left |
backgroundContainerView | A container that holds a background indicator view, such as backgroundEllipseLayer, backgroundImageView |
indicatorLineViewShowEnabled | Whether to display the IndicatorLineView Default: YES (color, width and height can be set)|
indicatorImageViewShowEnabled | Whether the IndicatorImageView is displayed Default: NO (indicatorImageView is public, width and height can be set)|
indicatorImageViewRollEnabled | Whether the IndicatorImageView is rotating (football) Default: NO |
backgroundEllipseLayerShowEnabled | Whether the indicator backgroundEllipseLayer is displayed Default: NO (color, width, height, fillet, width compensation can be set) |
zoomEnabled | cell is zoomed Default: NO |
zoomScale | cell scaling Default: 1.2 |
separatorLineShowEnabled | The separator line between cells Default: NO (color, width and height can be set) |
backgroundImageViewShowEnabled | whether backgroundImageView is displayed Default: NO (backgroundImageView is public, width and height can be set) |


## Usage

```
self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, WindowsSize.width, categoryViewHeight)];
self.categoryView.delegate = self;
self.categoryView.contentScrollView = self.scrollView;
//------Configure various attributes ------//
[self.view addSubview:self.categoryView];
```
When the data source and attribute configuration change (such as pulling data back from the server), you need to call the `reloadDatas` method to refresh the state.

### Subclassing considerations

Any subclassing, view, cell, and cellModel must be subclassed, even if a subclass cell does nothing. Used to maintain the inheritance chain, so as not to know who to inherit after subclassing

#### Subclassing cell style

The main overload method, reference: `JXCategoryTitleView, JXCategoryTitleImageView, JXCategoryNumberView`
- `- (Class)preferredCellClass` returns a custom cell class;
- `- (void)refreshDataSource` refresh the data source, using a custom cellModel;
- `- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index `Reset the data source when initializing and reloadDatas;
- `- (CGFloat) preferredCellWidthWithIndex:(NSInteger)index` returns the corresponding width according to the contents of the cell;
- `- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel`cell is refreshed when selected;
- `- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio`When the left and right scrolling is switched, the cellModel state is refreshed;

#### Indicator Style Customization

Reference: `JXCategoryComponentView, JXCategoryBackgroundImageView, JXCategoryLineStyleView`
- The background indicator view is customized and added to the `backgroundContainerView` (such as backgroundEllipseLayer, backgroundImageView);
- Bottom indicator customization,  collectionView add it (such as indicatorLineView, indicatorImageView);
- `- (void)refreshState` overload, refresh indicator status according to properties;
- `- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset`overload, refreshing the indicator state according to the scrolling progress;
- `- (BOOL)selectItemWithIndex:(NSInteger)index`overload, the indicator refresh logic when  clicked;

### ScreenEdgeGesture

First, add the following code to viewDidAppear:
```
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}
```

#### System returns items by default

- Click processing:
```
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
```

#### Custom navigation bar returns Item

- Set the proxy: self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
- Implement the proxy method:
```
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
```
- Click processing:
```
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}
```

### contentScrollView

- Flexible layout: JXCategoryView is not strongly associated with contentScrollView, you can even don't set this property as a simple SegmentedControl. There is no requirement for layout between them. You can put JXCategoryView into the navigation bar, UITableViewSectionHeader and so on.
- Click processing: Because of full decoupling, in the JXCategoryView clickback call, you need to add the following code to scroll the content:
```
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width*index, 0) animated:YES];
}
```

## Supplement

The resposity is kept up to date and will be supported for the first time in the popular new effect. During the use, if you have any suggestions or questions, you can contact me by:</br>
E-mail: 317437084@qq.com </br>
QQ group: 112440151

If you like just star❤️ it.

## License

JXCategoryView is released under the MIT license.
