//
//  JXPagingMainTableView.h
//  JXPagingView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXPagerMainTableViewGestureDelegate <NSObject>

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

@end

@interface JXPagerMainTableView : UITableView
@property (nonatomic, weak) id<JXPagerMainTableViewGestureDelegate> gestureDelegate;
@end
