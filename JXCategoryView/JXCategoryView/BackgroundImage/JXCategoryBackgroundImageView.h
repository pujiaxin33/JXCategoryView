//
//  JXCategoryBackgroundImageView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryComponentView.h"
#import "JXCategoryBackgroundImageCell.h"
#import "JXCategoryBackgroundImageCellModel.h"

@interface JXCategoryBackgroundImageView : JXCategoryComponentView

@property (nonatomic, assign) BOOL backgroundImageViewShowEnabled;      //默认NO

@property (nonatomic, strong, readonly) UIImageView *backgroundImageView;

@property (nonatomic, assign) CGSize backgroundImageViewSize;

@end
