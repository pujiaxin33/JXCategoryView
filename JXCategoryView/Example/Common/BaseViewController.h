//
//  BaseViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryBaseView.h"

#define WindowsSize [UIScreen mainScreen].bounds.size

@interface BaseViewController : UIViewController

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) UIScrollView *scrollView;


- (Class)preferredCategoryViewClass;

- (NSUInteger)preferredListViewCount;

- (CGFloat)preferredCategoryViewHeight;

@end
