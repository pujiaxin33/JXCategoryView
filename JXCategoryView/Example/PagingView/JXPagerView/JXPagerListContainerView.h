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

@protocol JXPagerListContainerViewDelegate <NSObject>

- (NSInteger)numberOfRowsInListContainerView:(JXPagerListContainerView *)listContainerView;

- (UIView *)listContainerView:(JXPagerListContainerView *)listContainerView listViewInRow:(NSInteger)row;

- (void)listContainerView:(JXPagerListContainerView *)listContainerView willDisplayCellAtRow:(NSInteger)row;

@end


@interface JXPagerListContainerView : UIView

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, weak) id<JXPagerListContainerViewDelegate> delegate;
@property (nonatomic, weak) JXPagerMainTableView *mainTableView;

- (instancetype)initWithDelegate:(id<JXPagerListContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)reloadData;

@end
