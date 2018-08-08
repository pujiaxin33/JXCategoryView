//
//  JXCategoryImageView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"

typedef NS_ENUM(NSUInteger, JXCategoryImageType) {
    JXCategoryImageType_OnlyImage = 0,
    JXCategoryImageType_TopImage,
    JXCategoryImageType_LeftImage,
    JXCategoryImageType_BottomImage,
    JXCategoryImageType_RightImage,
};

@interface JXCategoryImageView : JXCategoryTitleView

@property (nonatomic, strong) NSArray <NSString *>*imageNames;

@property (nonatomic, strong) NSArray <NSURL *>*imageURLs;

@property (nonatomic, strong) NSArray <NSString *>*selectedImageNames;

@property (nonatomic, strong) NSArray <NSURL *>*selectedImageURLs;

@property (nonatomic, assign) JXCategoryImageType imageType;    //默认JXCategoryImageType_LeftImage

@property (nonatomic, assign) CGSize imageSize;     //默认CGSizeMake(20, 20)

@property (nonatomic, assign) CGFloat titleImageSpacing;    //titleLabel和ImageView的间距，默认5

@end
