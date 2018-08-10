//
//  JXCategoryTitleImageCellModel.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleCellModel.h"

typedef NS_ENUM(NSUInteger, JXCategoryTitleImageType) {
    JXCategoryTitleImageType_OnlyImage = 0,
    JXCategoryTitleImageType_TopImage,
    JXCategoryTitleImageType_LeftImage,
    JXCategoryTitleImageType_BottomImage,
    JXCategoryTitleImageType_RightImage,
};

@interface JXCategoryTitleImageCellModel : JXCategoryTitleCellModel

@property (nonatomic, assign) JXCategoryTitleImageType imageType;

@property (nonatomic, copy) NSString *imageName;    //加载bundle内的图片

@property (nonatomic, strong) NSURL *imageURL;      //图片URL

@property (nonatomic, copy) NSString *selectedImageName;

@property (nonatomic, strong) NSURL *selectedImageURL;

@property (nonatomic, assign) CGSize imageSize;     //默认CGSizeMake(20, 20)

@property (nonatomic, assign) CGFloat titleImageSpacing;    //titleLabel和ImageView的间距，默认5

@end
