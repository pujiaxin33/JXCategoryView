//
//  JXCategoryImageView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorView.h"
#import "JXCategoryImageCell.h"
#import "JXCategoryImageCellModel.h"

@interface JXCategoryImageView : JXCategoryIndicatorView

//imageInfo数组可以传入imageName字符串或者image的URL地址等，然后会通过loadImageBlock透传回来，把imageView对于图片的加载过程完全交给使用者决定。
@property (nonatomic, strong) NSArray <id>*imageInfoArray;
@property (nonatomic, strong) NSArray <id>*selectedImageInfoArray;
@property (nonatomic, copy) void(^loadImageBlock)(UIImageView *imageView, id info);

@property (nonatomic, assign) CGSize imageSize;     //默认值为 CGSizeMake(20, 20)
@property (nonatomic, assign) CGFloat imageCornerRadius; //图片圆角
@property (nonatomic, assign, getter=isImageZoomEnabled) BOOL imageZoomEnabled;     //默认值为 NO
@property (nonatomic, assign) CGFloat imageZoomScale;    //默认值为 1.2，imageZoomEnabled 为 YES 时才生效

//下面的属性将会被弃用，请使用`imageInfoArray`、`selectedImageInfoArray`、`loadImageBlock`属性完成需求。
@property (nonatomic, strong) NSArray <NSString *>*imageNames;
@property (nonatomic, strong) NSArray <NSURL *>*imageURLs;
@property (nonatomic, strong) NSArray <NSString *>*selectedImageNames;
@property (nonatomic, strong) NSArray <NSURL *>*selectedImageURLs;
@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);   //使用imageURL从远端下载图片进行加载，建议使用SDWebImage等第三方库进行下载。

@end
