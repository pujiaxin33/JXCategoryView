//
//  JXCategoryListContainerView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryListContainerView.h"
#import <objc/runtime.h>

@interface JXCategoryListContainerViewController : UIViewController
@property (copy) void(^viewWillAppearBlock)(void);
@property (copy) void(^viewDidAppearBlock)(void);
@property (copy) void(^viewWillDisappearBlock)(void);
@property (copy) void(^viewDidDisappearBlock)(void);
@end

@implementation JXCategoryListContainerViewController
- (void)dealloc
{
    self.viewWillAppearBlock = nil;
    self.viewDidAppearBlock = nil;
    self.viewWillDisappearBlock = nil;
    self.viewDidDisappearBlock = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewWillAppearBlock();
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewDidAppearBlock();
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.viewWillDisappearBlock();
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.viewDidDisappearBlock();
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods { return NO; }
@end

@interface JXCategoryListContainerView () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) id<JXCategoryListContainerViewDelegate> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableDictionary <NSNumber *, id<JXCategoryListContentViewDelegate>> *validListDict;
@property (nonatomic, assign) NSInteger willAppearIndex;
@property (nonatomic, assign) NSInteger willDisappearIndex;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) JXCategoryListContainerViewController *containerVC;
@end

@implementation JXCategoryListContainerView

- (instancetype)initWithType:(JXCategoryListContainerType)type delegate:(id<JXCategoryListContainerViewDelegate>)delegate{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _containerType = type;
        _delegate = delegate;
        _validListDict = [NSMutableDictionary dictionary];
        _willAppearIndex = -1;
        _willDisappearIndex = -1;
        _initListPercent = 0.01;
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    _containerVC = [[JXCategoryListContainerViewController alloc] init];
    self.containerVC.view.backgroundColor = [UIColor clearColor];
    [self addSubview:self.containerVC.view];
    __weak typeof(self) weakSelf = self;
    self.containerVC.viewWillAppearBlock = ^{
        [weakSelf listWillAppear:weakSelf.currentIndex];
    };
    self.containerVC.viewDidAppearBlock = ^{
        [weakSelf listDidAppear:weakSelf.currentIndex];
    };
    self.containerVC.viewWillDisappearBlock = ^{
        [weakSelf listWillDisappear:weakSelf.currentIndex];
    };
    self.containerVC.viewDidDisappearBlock = ^{
        [weakSelf listDidDisappear:weakSelf.currentIndex];
    };
    if (self.containerType == JXCategoryListContainerType_ScrollView) {
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(scrollViewClassInlistContainerView:)] &&
            [[self.delegate scrollViewClassInlistContainerView:self] isKindOfClass:object_getClass([UIScrollView class])]) {
            _scrollView = (UICollectionView *)[[[self.delegate scrollViewClassInlistContainerView:self] alloc] init];
        }else {
            _scrollView = [[UIScrollView alloc] init];
        }
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.containerVC.view addSubview:self.scrollView];
    }else {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(scrollViewClassInlistContainerView:)] &&
            [[self.delegate scrollViewClassInlistContainerView:self] isKindOfClass:object_getClass([UICollectionView class])]) {
            _collectionView = (UICollectionView *)[[[self.delegate scrollViewClassInlistContainerView:self] alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        }else {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        }
        self.collectionView.pagingEnabled = YES;
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.scrollsToTop = NO;
        self.collectionView.bounces = NO;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        if (@available(iOS 10.0, *)) {
            self.collectionView.prefetchingEnabled = NO;
        }
        if (@available(iOS 11.0, *)) {
            self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.containerVC.view addSubview:self.collectionView];
        //让外部统一访问scrollView
        _scrollView = _collectionView;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];

    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            [((UIViewController *)next) addChildViewController:self.containerVC];
            break;
        }
        next = next.nextResponder;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.containerVC.view.frame = self.bounds;
    if (self.containerType == JXCategoryListContainerType_ScrollView) {
        if (CGRectEqualToRect(self.scrollView.frame, CGRectZero) ||  !CGSizeEqualToSize(self.scrollView.bounds.size, self.bounds.size)) {
            self.scrollView.frame = self.bounds;
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
            [_validListDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull index, id<JXCategoryListContentViewDelegate>  _Nonnull list, BOOL * _Nonnull stop) {
                [list listView].frame = CGRectMake(index.intValue*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
            }];
            self.scrollView.contentOffset = CGPointMake(self.currentIndex*self.scrollView.bounds.size.width, 0);
        }else {
            self.scrollView.frame = self.bounds;
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
        }
    }else {
        if (CGRectEqualToRect(self.collectionView.frame, CGRectZero) ||  !CGSizeEqualToSize(self.collectionView.bounds.size, self.bounds.size)) {
            self.collectionView.frame = self.bounds;
            [self.collectionView.collectionViewLayout invalidateLayout];
            [self.collectionView setContentOffset:CGPointMake(self.collectionView.bounds.size.width*self.currentIndex, 0) animated:NO];
        }else {
            self.collectionView.frame = self.bounds;
        }
    }
}


- (void)setinitListPercent:(CGFloat)initListPercent {
    _initListPercent = initListPercent;
    if (initListPercent <= 0 || initListPercent >= 1) {
        NSAssert(NO, @"initListPercent值范围为开区间(0,1)，即不包括0和1");
    }
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.delegate numberOfListsInlistContainerView:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(indexPath.item)];
    [list listView].frame = cell.contentView.bounds;
    [cell.contentView addSubview:[list listView]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.bounds.size;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat currentIndexPercent = scrollView.contentOffset.x/scrollView.bounds.size.width;
    if (self.willAppearIndex != -1 || self.willDisappearIndex != -1) {
        NSInteger disappearIndex = self.willDisappearIndex;
        NSInteger appearIndex = self.willAppearIndex;
        if (self.willAppearIndex > self.willDisappearIndex) {
            //将要出现的列表在右边
            if (currentIndexPercent >= self.willAppearIndex) {
                self.willDisappearIndex = -1;
                self.willAppearIndex = -1;
                [self listDidDisappear:disappearIndex];
                [self listDidAppear:appearIndex];
            }
        }else {
            //将要出现的列表在左边
            if (currentIndexPercent <= self.willAppearIndex) {
                self.willDisappearIndex = -1;
                self.willAppearIndex = -1;
                [self listDidDisappear:disappearIndex];
                [self listDidAppear:appearIndex];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.willDisappearIndex != -1) {
        [self listWillAppear:self.willDisappearIndex];
        [self listWillDisappear:self.willAppearIndex];
        [self listDidAppear:self.willDisappearIndex];
        [self listDidDisappear:self.willAppearIndex];
        self.willDisappearIndex = -1;
        self.willAppearIndex = -1;
    }
}

#pragma mark - JXCategoryViewListContainer

- (UIScrollView *)contentScrollView {
    return self.scrollView;
}

- (void)setDefaultSelectedIndex:(NSInteger)index {
    self.currentIndex = index;
}

- (void)scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio selectedIndex:(NSInteger)selectedIndex {
    if (rightIndex == selectedIndex) {
        //当前选中的在右边，用户正在从右边往左边滑动
        if (ratio < (1 - self.initListPercent)) {
            [self initListIfNeededAtIndex:leftIndex];
        }
        if (self.willAppearIndex == -1) {
            self.willAppearIndex = leftIndex;
            if (self.validListDict[@(leftIndex)] != nil) {
                [self listWillAppear:self.willAppearIndex];
            }
        }
        if (self.willDisappearIndex == -1) {
            self.willDisappearIndex = rightIndex;
            [self listWillDisappear:self.willDisappearIndex];
        }
    }else {
        //当前选中的在左边，用户正在从左边往右边滑动
        if (ratio > self.initListPercent) {
            [self initListIfNeededAtIndex:rightIndex];
        }
        if (self.willAppearIndex == -1) {
            self.willAppearIndex = rightIndex;
            if (_validListDict[@(rightIndex)] != nil) {
                [self listWillAppear:self.willAppearIndex];
            }
        }
        if (self.willDisappearIndex == -1) {
            self.willDisappearIndex = leftIndex;
            [self listWillDisappear:self.willDisappearIndex];
        }
    }
}

- (void)didClickSelectedItemAtIndex:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    self.willAppearIndex = -1;
    self.willDisappearIndex = -1;
    if (self.currentIndex != index) {
        [self listWillDisappear:self.currentIndex];
        [self listDidDisappear:self.currentIndex];
        [self listWillAppear:index];
        [self listDidAppear:index];
    }
}

- (void)reloadData {
    for (id<JXCategoryListContentViewDelegate> list in _validListDict.allValues) {
        [[list listView] removeFromSuperview];
    }
    [_validListDict removeAllObjects];

    if (self.containerType == JXCategoryListContainerType_ScrollView) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width*[self.delegate numberOfListsInlistContainerView:self], self.scrollView.bounds.size.height);
    }else {
        [self.collectionView reloadData];
    }
    [self listWillAppear:self.currentIndex];
    [self listDidAppear:self.currentIndex];
}

#pragma mark - Private

- (void)initListIfNeededAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
        BOOL canInitList = [self.delegate listContainerView:self canInitListAtIndex:index];
        if (!canInitList) {
            return;
        }
    }
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list != nil) {
        //列表已经创建好了
        return;
    }
    list = [self.delegate listContainerView:self initListForIndex:index];
    if ([list isKindOfClass:[UIViewController class]]) {
        [self.containerVC addChildViewController:(UIViewController *)list];
    }
    _validListDict[@(index)] = list;

    if (self.containerType == JXCategoryListContainerType_ScrollView) {
        [list listView].frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
        [self.scrollView addSubview:[list listView]];
    }else {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        for (UIView *subview in cell.contentView.subviews) {
            [subview removeFromSuperview];
        }
        [list listView].frame = cell.contentView.bounds;
        [cell.contentView addSubview:[list listView]];
    }
    [self listWillAppear:index];
}

- (void)listWillAppear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list != nil) {
        if (list && [list respondsToSelector:@selector(listWillAppear)]) {
            [list listWillAppear];
        }
        if ([list isKindOfClass:[UIViewController class]]) {
            UIViewController *listVC = (UIViewController *)list;
            [listVC beginAppearanceTransition:YES animated:NO];
        }
    }else {
        //当前列表未被创建（页面初始化或通过点击触发的listWillAppear）
        BOOL canInitList = YES;
        if (self.delegate && [self.delegate respondsToSelector:@selector(listContainerView:canInitListAtIndex:)]) {
            canInitList = [self.delegate listContainerView:self canInitListAtIndex:index];
        }
        if (canInitList) {
            id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
            if (list == nil) {
                list = [self.delegate listContainerView:self initListForIndex:index];
                if ([list isKindOfClass:[UIViewController class]]) {
                    [self.containerVC addChildViewController:(UIViewController *)list];
                }
                _validListDict[@(index)] = list;
            }
            if (self.containerType == JXCategoryListContainerType_ScrollView) {
                if ([list listView].superview == nil) {
                    [list listView].frame = CGRectMake(index*self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
                    [self.scrollView addSubview:[list listView]];

                    if (list && [list respondsToSelector:@selector(listWillAppear)]) {
                        [list listWillAppear];
                    }
                    if ([list isKindOfClass:[UIViewController class]]) {
                        UIViewController *listVC = (UIViewController *)list;
                        [listVC beginAppearanceTransition:YES animated:NO];
                    }
                }
            }else {
                UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
                for (UIView *subview in cell.contentView.subviews) {
                    [subview removeFromSuperview];
                }
                [list listView].frame = cell.contentView.bounds;
                [cell.contentView addSubview:[list listView]];

                if (list && [list respondsToSelector:@selector(listWillAppear)]) {
                    [list listWillAppear];
                }
                if ([list isKindOfClass:[UIViewController class]]) {
                    UIViewController *listVC = (UIViewController *)list;
                    [listVC beginAppearanceTransition:YES animated:NO];
                }
            }
        }
    }
}

- (void)listDidAppear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    self.currentIndex = index;
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidAppear)]) {
        [list listDidAppear];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC endAppearanceTransition];
    }
}

- (void)listWillDisappear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listWillDisappear)]) {
        [list listWillDisappear];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC beginAppearanceTransition:NO animated:NO];
    }
}

- (void)listDidDisappear:(NSInteger)index {
    if (![self checkIndexValid:index]) {
        return;
    }
    id<JXCategoryListContentViewDelegate> list = _validListDict[@(index)];
    if (list && [list respondsToSelector:@selector(listDidDisappear)]) {
        [list listDidDisappear];
    }
    if ([list isKindOfClass:[UIViewController class]]) {
        UIViewController *listVC = (UIViewController *)list;
        [listVC endAppearanceTransition];
    }
}

- (BOOL)checkIndexValid:(NSInteger)index {
    NSUInteger count = [self.delegate numberOfListsInlistContainerView:self];
    if (count <= 0 || index >= count) {
        return NO;
    }
    return YES;
}

@end
