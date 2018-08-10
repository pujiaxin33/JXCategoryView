//
//  JXCategoryImageCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleImageCell.h"
#import "JXCategoryTitleImageCellModel.h"

@interface JXCategoryTitleImageCell() <NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation JXCategoryTitleImageCell

- (void)initializeViews {
    [super initializeViews];

    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];

    _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    JXCategoryTitleImageCellModel *myCellModel = (JXCategoryTitleImageCellModel *)self.cellModel;
    self.titleLabel.hidden = NO;
    CGSize imageSize = myCellModel.imageSize;
    self.imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
    switch (myCellModel.imageType) {
        case JXCategoryTitleImageType_OnlyImage:
        {
            self.titleLabel.hidden = YES;
            self.imageView.center = self.contentView.center;
        }
            break;

        case JXCategoryTitleImageType_TopImage:
        {
            CGFloat contentHeight = imageSize.height + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.height;
            self.imageView.center = CGPointMake(self.contentView.center.x, (self.contentView.bounds.size.height - contentHeight)/2 + imageSize.height/2);
            self.titleLabel.center = CGPointMake(self.contentView.center.x, CGRectGetMaxY(self.imageView.frame) + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.height/2);
        }
            break;

        case JXCategoryTitleImageType_LeftImage:
        {
            CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.width;
            self.imageView.center = CGPointMake((self.contentView.bounds.size.width - contentWidth)/2 + imageSize.width/2, self.contentView.center.y);
            self.titleLabel.center = CGPointMake(CGRectGetMaxX(self.imageView.frame) + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.width/2, self.contentView.center.y);
        }
            break;

        case JXCategoryTitleImageType_BottomImage:
        {
            CGFloat contentHeight = imageSize.height + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.height;
            self.titleLabel.center = CGPointMake(self.contentView.center.x, (self.contentView.bounds.size.height - contentHeight)/2 + self.titleLabel.bounds.size.height/2);
            self.imageView.center = CGPointMake(self.contentView.center.x, CGRectGetMaxY(self.titleLabel.frame) + myCellModel.titleImageSpacing + imageSize.height/2);
        }
            break;

        case JXCategoryTitleImageType_RightImage:
        {
            CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.width;
            self.titleLabel.center = CGPointMake((self.contentView.bounds.size.width - contentWidth)/2 + self.titleLabel.bounds.size.width/2, self.contentView.center.y);
            self.imageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + myCellModel.titleImageSpacing + imageSize.width/2, self.contentView.center.y);
        }
            break;

        default:
            break;
    }
}

- (void)reloadDatas:(JXCategoryBaseCellModel *)cellModel {
    [super reloadDatas:cellModel];

    JXCategoryTitleImageCellModel *myCellModel = (JXCategoryTitleImageCellModel *)cellModel;
    if (myCellModel.imageName != nil) {
        self.imageView.image = [UIImage imageNamed:myCellModel.imageName];
    }else if (myCellModel.imageURL != nil) {
        NSAssert(NO, @"如果业务需要从远端下载图片进行加载，务必使用SDWebImage等第三方库进行下载。我这里只是写的demo代码，没有缓存逻辑。");
        NSURLRequest *request = [NSURLRequest requestWithURL:myCellModel.imageURL];
        NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request];
        [task resume];
    }
    if (myCellModel.selected) {
        if (myCellModel.selectedImageName != nil) {
            self.imageView.image = [UIImage imageNamed:myCellModel.selectedImageName];
        }else if (myCellModel.selectedImageURL != nil) {
            NSAssert(NO, @"如果业务需要从远端下载图片进行加载，务必使用SDWebImage等第三方库进行下载。我这里只是写的demo代码，没有缓存逻辑。");
            NSURLRequest *request = [NSURLRequest requestWithURL:myCellModel.selectedImageURL];
            NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request];
            [task resume];
        }
    }
}

#pragma mark - NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *imageData = [NSData dataWithContentsOfURL:location];
    self.imageView.image = [UIImage imageWithData:imageData];
}

@end
