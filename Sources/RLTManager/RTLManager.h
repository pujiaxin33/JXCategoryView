//
//  RTLManager.h
//  JXCategoryView
//
//  Created by jiaxin on 2020/7/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTLManager : NSObject

+ (BOOL)supportRTL;
+ (void)horizontalFlipView:(UIView *)view;
+ (void)horizontalFlipViewIfNeeded:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
