//
//  ScrollUpNavigationBar.h
//  Example
//
//  Created by jiaxin on 2020/5/22.
//  Copyright © 2020 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollUpNavigationBar : UIView
@property (nonatomic, copy) void (^backBlock)(void);
@end

NS_ASSUME_NONNULL_END
