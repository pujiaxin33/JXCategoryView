//
//  VerticalListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "VerticalListViewController.h"
#import "VerticalListSectionModel.h"
#import "VerticalListCell.h"
#import "VerticalSectionHeaderView.h"
#import "JXCategoryView.h"
#import "VerticalSectionCategoryHeaderView.h"

static const CGFloat VerticalListCategoryViewHeight = 60;   //悬浮categoryView的高度
static const NSUInteger VerticalListPinSectionIndex = 1;    //悬浮固定section的index

@interface VerticalListViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, JXCategoryViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray <VerticalListSectionModel *> *dataSource;
@property (nonatomic, strong) NSArray <NSString *> *headerTitles;
@property (nonatomic, strong) JXCategoryTitleView *pinCategoryView;
@property (nonatomic, strong) VerticalSectionCategoryHeaderView *sectionCategoryHeaderView;
@property (nonatomic, strong) NSArray <UICollectionViewLayoutAttributes *> *sectionHeaderAttributes;

@end

@implementation VerticalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    NSMutableArray *dataSource = [NSMutableArray array];
    self.headerTitles = @[@"我的频道", @"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事"];
    NSArray *imageNames = @[@"boat", @"crab", @"lobster", @"apple", @"carrot", @"grape", @"watermelon"];
    [self.headerTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        VerticalListSectionModel *sectionModel = [[VerticalListSectionModel alloc] init];
        sectionModel.sectionTitle = title;
        NSUInteger randomCount = arc4random()%10 + 5;
        NSMutableArray *cellModels = [NSMutableArray array];
        for (int i = 0; i < randomCount; i ++) {
            VerticalListCellModel *cellModel = [[VerticalListCellModel alloc] init];
            cellModel.imageName = imageNames[idx];
            cellModel.itemName = title;
            [cellModels addObject:cellModel];
        }
        sectionModel.cellModels = cellModels;
        [dataSource addObject:sectionModel];
    }];
    self.dataSource = dataSource;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[VerticalListCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[VerticalSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[VerticalSectionCategoryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"categoryHeader"];
    [self.view addSubview:self.collectionView];

    //创建pinCategoryView，但是不要被addSubview
    _pinCategoryView = [[JXCategoryTitleView alloc] init];
    self.pinCategoryView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    self.pinCategoryView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, VerticalListCategoryViewHeight);
    self.pinCategoryView.titles = @[@"超级大IP", @"热门HOT", @"周边衍生", @"影视综", @"游戏集锦", @"搞笑百事"];
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.verticalMargin = 15;
    self.pinCategoryView.indicators = @[lineView];
    self.pinCategoryView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.sectionHeaderAttributes == nil) {
        //获取到所有的sectionHeaderAtrributes，用于后续的点击，滚动到指定contentOffset.y使用
        NSMutableArray *attributes = [NSMutableArray array];
        UICollectionViewLayoutAttributes *lastHeaderAttri = nil;
        for (int i = 0; i < self.headerTitles.count; i++) {
            UICollectionViewLayoutAttributes *attri = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
            [attributes addObject:attri];
            if (i == self.headerTitles.count - 1) {
                lastHeaderAttri = attri;
            }
        }
        self.sectionHeaderAttributes = attributes;

        //如果最后一个section条目太少了，会导致滚动最底部，但是却不能触发categoryView选中最后一个item。而且点击最后一个滚动的contentOffset.y也不要弄。所以添加contentInset，让最后一个section滚到最下面能显示完整个屏幕。
        UICollectionViewLayoutAttributes *lastCellAttri = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:self.dataSource[self.headerTitles.count - 1].cellModels.count - 1 inSection:self.headerTitles.count - 1]];
        CGFloat lastSectionHeight = CGRectGetMaxY(lastCellAttri.frame) - CGRectGetMinY(lastHeaderAttri.frame);
        CGFloat value = (self.view.bounds.size.height - VerticalListCategoryViewHeight) - lastSectionHeight;
        if (value > 0) {
            self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, value, 0);
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.collectionView.frame = self.view.bounds;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    VerticalListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    VerticalListSectionModel *sectionModel = self.dataSource[indexPath.section];
    VerticalListCellModel *cellModel = sectionModel.cellModels[indexPath.row];
    cell.itemImageView.image = [UIImage imageNamed:cellModel.imageName];
    cell.titleLabel.text = cellModel.itemName;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource[section].cellModels.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == VerticalListPinSectionIndex) {
            VerticalSectionCategoryHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"categoryHeader" forIndexPath:indexPath];
            self.sectionCategoryHeaderView = headerView;
            if (self.pinCategoryView.superview == nil) {
                //首次使用VerticalSectionCategoryHeaderView的时候，把pinCategoryView添加到它上面。
                [headerView addSubview:self.pinCategoryView];
            }
            return headerView;
        }else {
            VerticalSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            VerticalListSectionModel *sectionModel = self.dataSource[indexPath.section];
            headerView.titleLabel.text = sectionModel.sectionTitle;
            return headerView;
        }
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UICollectionViewLayoutAttributes *attri = self.sectionHeaderAttributes[VerticalListPinSectionIndex];
    if (scrollView.contentOffset.y >= attri.frame.origin.y) {
        //当滚动的contentOffset.y大于了指定sectionHeader的y值，且还没有被添加到self.view上的时候，就需要切换superView
        if (self.pinCategoryView.superview != self.view) {
            [self.view addSubview:self.pinCategoryView];
        }
    }else if (self.pinCategoryView.superview != self.sectionCategoryHeaderView) {
        //当滚动的contentOffset.y小于了指定sectionHeader的y值，且还没有被添加到sectionCategoryHeaderView上的时候，就需要切换superView
        [self.sectionCategoryHeaderView addSubview:self.pinCategoryView];
    }

    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
    //用户滚动的才处理
    //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
    CGRect topRect = CGRectMake(0, scrollView.contentOffset.y + VerticalListCategoryViewHeight + 1, self.view.bounds.size.width, 1);
    UICollectionViewLayoutAttributes *topAttributes = [self.collectionView.collectionViewLayout layoutAttributesForElementsInRect:topRect].firstObject;
    NSUInteger topSection = topAttributes.indexPath.section;
    if (topAttributes != nil && topSection >= VerticalListPinSectionIndex) {
        if (self.pinCategoryView.selectedIndex != topSection - VerticalListPinSectionIndex) {
            //不相同才切换
            [self.pinCategoryView selectItemWithIndex:topSection - VerticalListPinSectionIndex];
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == VerticalListPinSectionIndex) {
        //categoryView所在的headerView要高一些
        return CGSizeMake(self.view.bounds.size.width, VerticalListCategoryViewHeight);
    }
    return CGSizeMake(self.view.bounds.size.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (self.view.bounds.size.width - 100*3)/4;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    CGFloat margin = (self.view.bounds.size.width - 100*3)/4;
    return UIEdgeInsetsMake(0, margin, 0, margin);
}


#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    //这里关心点击选中的回调！！！
    UICollectionViewLayoutAttributes *targetAttri = self.sectionHeaderAttributes[index + VerticalListPinSectionIndex];
    if (index == 0) {
        //选中了第一个，特殊处理一下，滚动到sectionHeaer的最上面
        [self.collectionView setContentOffset:CGPointMake(0, targetAttri.frame.origin.y) animated:YES];
    }else {
        //不是第一个，需要滚动到categoryView下面
        [self.collectionView setContentOffset:CGPointMake(0, targetAttri.frame.origin.y - VerticalListCategoryViewHeight) animated:YES];
    }
}

@end
