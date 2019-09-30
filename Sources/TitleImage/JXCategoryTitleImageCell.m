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
@property (nonatomic, strong) NSString *currentImageName;
@property (nonatomic, strong) NSURL *currentImageURL;
@end

@implementation JXCategoryTitleImageCell

- (void)prepareForReuse {
    [super prepareForReuse];

    self.currentImageName = nil;
    self.currentImageURL = nil;
}

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
    self.imageView.hidden = NO;
    CGSize imageSize = myCellModel.imageSize;
    self.imageView.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
    switch (myCellModel.imageType) {

        case JXCategoryTitleImageType_TopImage:
        {
            CGFloat contentHeight = imageSize.height + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.height;
            self.imageView.center = CGPointMake(self.contentView.center.x, (self.contentView.bounds.size.height - contentHeight)/2 + imageSize.height/2);
            [self refreshTitleLabelCenter:CGPointMake(self.contentView.center.x, CGRectGetMaxY(self.imageView.frame) + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.height/2)];
        }
            break;

        case JXCategoryTitleImageType_LeftImage:
        {
            CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.width;
            self.imageView.center = CGPointMake((self.contentView.bounds.size.width - contentWidth)/2 + imageSize.width/2, self.contentView.center.y);
            [self refreshTitleLabelCenter:CGPointMake(CGRectGetMaxX(self.imageView.frame) + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.width/2, self.contentView.center.y)];
        }
            break;

        case JXCategoryTitleImageType_BottomImage:
        {
            CGFloat contentHeight = imageSize.height + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.height;
            [self refreshTitleLabelCenter:CGPointMake(self.contentView.center.x, (self.contentView.bounds.size.height - contentHeight)/2 + self.titleLabel.bounds.size.height/2)];
            self.imageView.center = CGPointMake(self.contentView.center.x, CGRectGetMaxY(self.titleLabel.frame) + myCellModel.titleImageSpacing + imageSize.height/2);
        }
            break;

        case JXCategoryTitleImageType_RightImage:
        {
            CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.width;
            [self refreshTitleLabelCenter:CGPointMake((self.contentView.bounds.size.width - contentWidth)/2 + self.titleLabel.bounds.size.width/2, self.contentView.center.y)];
            self.imageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + myCellModel.titleImageSpacing + imageSize.width/2, self.contentView.center.y);
        }
            break;

        case JXCategoryTitleImageType_OnlyImage:
        {
            self.titleLabel.hidden = YES;
            self.imageView.center = self.contentView.center;
        }
            break;

        case JXCategoryTitleImageType_OnlyTitle:
        {
            self.imageView.hidden = YES;
            [self refreshTitleLabelCenter:self.contentView.center];
        }
            break;

        default:
            break;
    }
}

- (void)refreshTitleLabelCenter:(CGPoint)center {
    JXCategoryTitleImageCellModel *myCellModel = (JXCategoryTitleImageCellModel *)self.cellModel;
    if (myCellModel.titleLabelAnchorPointStyle == JXCategoryTitleLabelAnchorPointStyleBottom) {
        center.y += (self.titleLabel.bounds.size.height/2 + myCellModel.titleLabelVerticalOffset);
    }else if (myCellModel.titleLabelAnchorPointStyle == JXCategoryTitleLabelAnchorPointStyleTop) {
        center.y -= (self.titleLabel.bounds.size.height/2 + myCellModel.titleLabelVerticalOffset);
    }
    self.titleLabelCenterX.constant = center.x - self.contentView.bounds.size.width/2;
    self.titleLabelCenterY.constant = center.y - self.contentView.bounds.size.height/2;
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryTitleImageCellModel *myCellModel = (JXCategoryTitleImageCellModel *)cellModel;

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

    [self setNeedsLayout];
}


@end
