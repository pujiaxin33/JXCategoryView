//
//  JXCategoryImageCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleImageCell.h"
#import "JXCategoryTitleImageCellModel.h"

@interface JXCategoryTitleImageCell()

@end

@implementation JXCategoryTitleImageCell

- (void)initializeViews {
    [super initializeViews];

    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    JXCategoryTitleImageCellModel *myCellModel = (JXCategoryTitleImageCellModel *)self.cellModel;
    self.titleLabel.hidden = NO;
    CGSize imageSize = myCellModel.imageSize;
    self.imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
    switch (myCellModel.imageType) {

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

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryTitleImageCellModel *myCellModel = (JXCategoryTitleImageCellModel *)cellModel;
    if (myCellModel.imageName != nil) {
        self.imageView.image = [UIImage imageNamed:myCellModel.imageName];
    }else if (myCellModel.imageURL != nil) {
        if (myCellModel.loadImageCallback != nil) {
            myCellModel.loadImageCallback(self.imageView);
        }
    }
    if (myCellModel.selected) {
        if (myCellModel.selectedImageName != nil) {
            self.imageView.image = [UIImage imageNamed:myCellModel.selectedImageName];
        }else if (myCellModel.selectedImageURL != nil) {
            if (myCellModel.loadImageCallback != nil) {
                myCellModel.loadImageCallback(self.imageView);
            }
        }
    }

    if (myCellModel.imageZoomEnabled) {
        self.imageView.transform = CGAffineTransformMakeScale(myCellModel.imageZoomScale, myCellModel.imageZoomScale);
    }else {
        self.imageView.transform = CGAffineTransformIdentity;
    }

    [self setNeedsLayout];
    [self layoutIfNeeded];
}


@end
