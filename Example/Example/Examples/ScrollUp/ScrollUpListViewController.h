//
//  ScrollUpListViewController.h
//  Example
//
//  Created by jiaxin on 2020/5/22.
//  Copyright © 2020 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollUpListViewController : UIViewController <JXCategoryListContentViewDelegate>
@property (nonatomic, copy) void (^scrollViewDidScrollBlock)(UIScrollView *);
@property (nonatomic, copy) void (^willBeginDragging)(UIScrollView *);
@property (nonatomic, copy) void (^didEndDragging)(UIScrollView *);

- (void)stopScrolling;
@end

NS_ASSUME_NONNULL_END
