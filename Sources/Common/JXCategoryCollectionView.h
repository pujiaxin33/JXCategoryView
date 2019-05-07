//
//  JXCategoryCollectionView.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/21.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryIndicatorProtocol.h"
@class JXCategoryCollectionView;

@protocol JXCategoryCollectionViewGestureDelegate <NSObject>
@optional
- (BOOL)categoryCollectionView:(JXCategoryCollectionView *)collectionView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
- (BOOL)categoryCollectionView:(JXCategoryCollectionView *)collectionView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end

@interface JXCategoryCollectionView : UICollectionView

@property (nonatomic, strong) NSArray <UIView<JXCategoryIndicatorProtocol> *> *indicators;
@property (nonatomic, weak) id<JXCategoryCollectionViewGestureDelegate> gestureDelegate;

@end
