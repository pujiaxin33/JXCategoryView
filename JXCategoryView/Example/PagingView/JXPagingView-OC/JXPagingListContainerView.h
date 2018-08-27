//
//  JXPagingListContainerView.h
//  JXPagingView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JXPagingMainTableView;
@class JXPagingListContainerView;

@protocol JXPagingListContainerViewDelegate <NSObject>

- (NSInteger)numberOfRowsInListContainerView:(JXPagingListContainerView *)listContainerView;

- (UIView *)listContainerView:(JXPagingListContainerView *)listContainerView listViewInRow:(NSInteger)row;

@end


@interface JXPagingListContainerView : UIView

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, weak) id<JXPagingListContainerViewDelegate> delegate;
@property (nonatomic, weak) JXPagingMainTableView *mainTableView;

- (instancetype)initWithDelegate:(id<JXPagingListContainerViewDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)reloadData;

@end
