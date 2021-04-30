//
//  JXCategoryViewAnimator.h
//  JXCategoryView
//
//  Created by jiaxin on 2019/1/24.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JXCategoryViewAnimator : NSObject

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, copy) void(^progressCallback)(CGFloat percent);
@property (nonatomic, copy) void(^completeCallback)(void);
@property (readonly, getter=isExecuting) BOOL executing;

- (void)start;
- (void)stop;
- (void)invalid;

@end

