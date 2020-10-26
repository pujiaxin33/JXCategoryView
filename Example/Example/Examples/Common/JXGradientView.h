//
//  JXGradientView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/20.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 渐变视图
 
 在「指示器样式」——>「BackgroundView渐变色」 中有用到！
 */
@interface JXGradientView : UIView

@property (nonatomic, strong, readonly) CAGradientLayer *gradientLayer;

@end

NS_ASSUME_NONNULL_END
