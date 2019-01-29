//
//  JXPagingListContainerView.h
//  JXPagingView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXPagerMainTableView;
@class JXPagerListContainerView;
@class JXPagerListContainerCollectionView;

@protocol JXPagerListContainerCollectionViewGestureDelegate <NSObject>
- (BOOL)pagerListContainerCollectionViewGestureRecognizerShouldBegin:(JXPagerListContainerCollectionView *)collectionView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
@end

@interface JXPagerListContainerCollectionView: UICollectionView<UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL isNestEnabled;
@property (nonatomic, weak) id<JXPagerListContainerCollectionViewGestureDelegate> gestureDelegate;
@end

@protocol JXPagerListContainerViewDelegate <NSObject>

- (NSInteger)numberOfRowsInListContainerView:(JXPagerListContainerView *)listContainerView;

- (UIView *)listContainerView:(JXPagerListContainerView *)listContainerView listViewInRow:(NSInteger)row;

- (void)listContainerView:(JXPagerListContainerView *)listContainerView willDisplayCellAtRow:(NSInteger)row;

@end


@interface JXPagerListContainerView : UIView

@property (nonatomic, strong, readonly) JXPagerListContainerCollectionView *collectionView;
@property (nonatomic, weak) id<JXPagerListContainerViewDelegate> delegate;
@property (nonatomic, weak) JXPagerMainTableView *mainTableView;

- (instancetype)initWithDelegate:(id<JXPagerListContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)reloadData;

- (void)deviceOrientationDidChanged;

@end


