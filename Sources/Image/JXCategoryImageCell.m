//
//  JXCategoryImageCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryImageCell.h"
#import "JXCategoryImageCellModel.h"

@interface JXCategoryImageCell()
@property (nonatomic, strong) NSString *currentImageName;
@property (nonatomic, strong) NSURL *currentImageURL;
@end

@implementation JXCategoryImageCell

- (void)prepareForReuse {
    [super prepareForReuse];

    self.currentImageName = nil;
    self.currentImageURL = nil;
}

- (void)initializeViews {
    [super initializeViews];

    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    JXCategoryImageCellModel *myCellModel = (JXCategoryImageCellModel *)self.cellModel;
    self.imageView.bounds = CGRectMake(0, 0, myCellModel.imageSize.width, myCellModel.imageSize.height);
    self.imageView.center = self.contentView.center;
    self.imageView.layer.cornerRadius = myCellModel.imageCornerRadius;
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryImageCellModel *myCellModel = (JXCategoryImageCellModel *)cellModel;
    //因为`- (void)reloadData:(JXCategoryBaseCellModel *)cellModel`方法会回调多次，尤其是左右滚动的时候会调用无数次，如果每次都触发图片加载，会非常消耗性能。所以只会在图片发生了变化的时候，才进行图片加载。
    NSString *currentImageName = nil;
    NSURL *currentImageURL = nil;
    if (myCellModel.imageName != nil) {
        currentImageName = myCellModel.imageName;
    }else if (myCellModel.imageURL != nil) {
        currentImageURL = myCellModel.imageURL;
    }
    if (myCellModel.isSelected) {
        if (myCellModel.selectedImageName != nil) {
            currentImageName = myCellModel.selectedImageName;
        }else if (myCellModel.selectedImageURL != nil) {
            currentImageURL = myCellModel.selectedImageURL;
        }
    }
    if (currentImageName != nil && ![currentImageName isEqualToString:self.currentImageName]) {
        self.currentImageName = currentImageName;
        self.imageView.image = [UIImage imageNamed:currentImageName];
    }else if (currentImageURL != nil && ![currentImageURL.absoluteString isEqualToString:self.currentImageURL.absoluteString]) {
        self.currentImageURL = currentImageURL;
        if (myCellModel.loadImageCallback != nil) {
            myCellModel.loadImageCallback(self.imageView, currentImageURL);
        }
    }

    if (myCellModel.isImageZoomEnabled) {
        self.imageView.transform = CGAffineTransformMakeScale(myCellModel.imageZoomScale, myCellModel.imageZoomScale);
    }else {
        self.imageView.transform = CGAffineTransformIdentity;
    }
}

@end
