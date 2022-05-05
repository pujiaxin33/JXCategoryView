//
//  JXCategoryTitleImageView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"
#import "JXCategoryTitleImageCell.h"
#import "JXCategoryTitleImageCellModel.h"

@interface JXCategoryTitleImageView : JXCategoryTitleView

//imageInfo数组可以传入imageName字符串或者image的URL地址等，然后会通过loadImageBlock透传回来，把imageView对于图片的加载过程完全交给使用者决定。
@property (nonatomic, strong) NSArray <id>*imageInfoArray;
@property (nonatomic, strong) NSArray <id>*selectedImageInfoArray;
@property (nonatomic, copy) void(^loadImageBlock)(UIImageView *imageView, id info);
//图片尺寸。默认CGSizeMake(20, 20)
@property (nonatomic, assign) CGSize imageSize;
//titleLabel和ImageView的间距，默认5
@property (nonatomic, assign) CGFloat titleImageSpacing;
//图片是否缩放。默认为NO
@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;
//图片缩放的最大scale。默认1.2，imageZoomEnabled为YES才生效
@property (nonatomic, assign) CGFloat imageZoomScale;
//默认@[JXCategoryTitleImageType_LeftImage...]
@property (nonatomic, strong) NSArray <NSNumber *> *imageTypes;

//下面的属性将会被弃用，请使用`imageInfoArray`、`selectedImageInfoArray`、`loadImageBlock`属性完成需求。
//普通状态下的imageNames，通过[UIImage imageNamed:]方法加载
@property (nonatomic, strong) NSArray <NSString *>*imageNames;
//选中状态下的imageNames，通过[UIImage imageNamed:]方法加载。可选
@property (nonatomic, strong) NSArray <NSString *>*selectedImageNames;
//普通状态下的imageURLs，通过loadImageCallback回调加载
@property (nonatomic, strong) NSArray <NSURL *>*imageURLs;
//选中状态下的selectedImageURLs，通过loadImageCallback回调加载
@property (nonatomic, strong) NSArray <NSURL *>*selectedImageURLs;
//使用imageURL从远端下载图片进行加载，建议使用SDWebImage等第三方库进行下载。
@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);

@end
