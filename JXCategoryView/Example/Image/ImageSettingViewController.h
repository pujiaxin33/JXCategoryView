//
//  ImageSettingViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryImageView.h"

@protocol ImageSettingViewControllerDelegate <NSObject>

- (void)imageSettingVCDidSelectedImageType:(JXCategoryImageType)imageType;

@end

@interface ImageSettingViewController : UITableViewController

@property (nonatomic, weak) id<ImageSettingViewControllerDelegate> delegate;

@property (nonatomic, assign) JXCategoryImageType imageType;

@end
