//
//  ListViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"

/**
 列表实例对象
 
 在 .h 头文件中声明遵守 <JXCategoryListContentViewDelegate> 协议
 */
@interface ListViewController : UIViewController <JXCategoryListContentViewDelegate>

@end
