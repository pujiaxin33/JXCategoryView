//
//  JXCategoryTimelineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/23.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"
#import "JXCategoryTimelineCell.h"
#import "JXCategoryTimelineCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXCategoryTimelineView : JXCategoryTitleView
@property (nonatomic, strong) NSArray <NSString *> *timeTitles;
@property (nonatomic, strong) UIColor *timeTitleNormalColor;
@property (nonatomic, strong) UIColor *timeTitleSelectedColor;
@property (nonatomic, strong) UIFont *timeTitleFont;
@property (nonatomic, strong) UIFont *timeTitleSelectedFont;
@end

NS_ASSUME_NONNULL_END
