//
//  LoadDataListScrollZoomViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/24.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"

@interface LoadDataListScrollZoomViewController : UIViewController <JXCategoryListContentViewDelegate>
@property (nonatomic, copy) void(^didScrollCallback)(UIScrollView *scrollView);
@end

