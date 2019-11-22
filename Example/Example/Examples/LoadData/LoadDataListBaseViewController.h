//
//  LoadDataListBaseViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadDataListBaseViewController : UITableViewController

@property (nonatomic, strong) UINavigationController *naviController;
@property (nonatomic, copy) void(^didScrollCallback)(UIScrollView *scrollView);
- (void)loadDataForFirst;

@end
