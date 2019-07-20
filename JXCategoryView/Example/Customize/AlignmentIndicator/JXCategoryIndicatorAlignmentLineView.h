//
//  JXCategoryIndicatorAlignmentLineView.h
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/20.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

typedef NS_ENUM(NSUInteger, JXCategoryIndicatorAlignmentStyle) {
    JXCategoryIndicatorAlignmentStyleLeading,
    JXCategoryIndicatorAlignmentStyleTrailing,
};

NS_ASSUME_NONNULL_BEGIN

@interface JXCategoryIndicatorAlignmentLineView : JXCategoryIndicatorComponentView
@property (nonatomic, assign) JXCategoryIndicatorAlignmentStyle alignmentStyle;
@end

NS_ASSUME_NONNULL_END
