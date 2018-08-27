//
//  TestListBaseView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagingView.h"

@protocol TestListViewDelegate <NSObject>
- (void)listViewDidScroll:(UIScrollView *)scrollView;
@end

@interface TestListBaseView : UIView <JXPagingViewListViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSString *> *dataSource;
@property (nonatomic, weak) id<TestListViewDelegate> delegate;

@end
