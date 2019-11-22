//
//  LoadDataBaseViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WindowsSize [UIScreen mainScreen].bounds.size

@interface LoadDataBaseViewController : UIViewController

- (NSArray <NSString *> *)getRandomTitles;
- (void)reloadData;

@end

