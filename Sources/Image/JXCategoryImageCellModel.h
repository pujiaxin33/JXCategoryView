//
//  JXCategoryImageCellModel.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorCellModel.h"

@interface JXCategoryImageCellModel : JXCategoryIndicatorCellModel

@property (nonatomic, strong) id imageInfo;
@property (nonatomic, strong) id selectedImageInfo;
@property (nonatomic, copy) void(^loadImageBlock)(UIImageView *imageView, id info);

@property (nonatomic, assign) CGSize imageSize;

@property (nonatomic, assign) CGFloat imageCornerRadius;

@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;

@property (nonatomic, assign) CGFloat imageZoomScale;

/// 以下属性将会被弃用
@property (nonatomic, copy) NSString *imageName;    //加载bundle内的图片
@property (nonatomic, strong) NSURL *imageURL;      //图片URL
@property (nonatomic, copy) NSString *selectedImageName;
@property (nonatomic, strong) NSURL *selectedImageURL;
@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

@end
