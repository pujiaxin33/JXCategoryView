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
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) NSLayoutConstraint *imageViewWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *imageViewHeightConstraint;
@end

@implementation JXCategoryTitleImageCell

- (void)prepareForReuse {
    [super prepareForReuse];

    self.currentImageName = nil;
    self.currentImageURL = nil;
}

- (void)initializeViews {
    [super initializeViews];

    [self.titleLabel removeFromSuperview];

    _imageView = [[UIImageView alloc] init];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageViewWidthConstraint = [self.imageView.widthAnchor constraintEqualToConstant:0];
    self.imageViewWidthConstraint.active = YES;
    self.imageViewHeightConstraint = [self.imageView.heightAnchor constraintEqualToConstant:0];
    self.imageViewHeightConstraint.active = YES;

    _stackView = [[UIStackView alloc] init];
    self.stackView.alignment = UIStackViewAlignmentCenter;
    [self.contentView addSubview:self.stackView];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.stackView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.stackView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryTitleImageCellModel *myCellModel = (JXCategoryTitleImageCellModel *)cellModel;

    self.titleLabel.hidden = NO;
    self.imageView.hidden = NO;
    [self.stackView removeArrangedSubview:self.titleLabel];
    [self.stackView removeArrangedSubview:self.imageView];
    CGSize imageSize = myCellModel.imageSize;
    self.imageViewWidthConstraint.constant = imageSize.width;
    self.imageViewHeightConstraint.constant = imageSize.height;
    self.stackView.spacing = myCellModel.titleImageSpacing;
    switch (myCellModel.imageType) {
<<<<<<< HEAD
        case JXCategoryTitleImageType_TopImage: {
            CGFloat contentHeight = imageSize.height + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.height;
            self.imageView.center = CGPointMake(self.contentView.center.x, (self.contentView.bounds.size.height - contentHeight)/2 + imageSize.height/2);
            [self refreshTitleLabelCenter:CGPointMake(self.contentView.center.x, CGRectGetMaxY(self.imageView.frame) + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.height/2)];
            break;
        }
        case JXCategoryTitleImageType_LeftImage: {
            CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.width;
            self.imageView.center = CGPointMake((self.contentView.bounds.size.width - contentWidth)/2 + imageSize.width/2, self.contentView.center.y);
            [self refreshTitleLabelCenter:CGPointMake(CGRectGetMaxX(self.imageView.frame) + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.width/2, self.contentView.center.y)];
            break;
        }
        case JXCategoryTitleImageType_BottomImage: {
            CGFloat contentHeight = imageSize.height + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.height;
            [self refreshTitleLabelCenter:CGPointMake(self.contentView.center.x, (self.contentView.bounds.size.height - contentHeight)/2 + self.titleLabel.bounds.size.height/2)];
            self.imageView.center = CGPointMake(self.contentView.center.x, CGRectGetMaxY(self.titleLabel.frame) + myCellModel.titleImageSpacing + imageSize.height/2);
            break;
        }
        case JXCategoryTitleImageType_RightImage: {
            CGFloat contentWidth = imageSize.width + myCellModel.titleImageSpacing + self.titleLabel.bounds.size.width;
            [self refreshTitleLabelCenter:CGPointMake((self.contentView.bounds.size.width - contentWidth)/2 + self.titleLabel.bounds.size.width/2, self.contentView.center.y)];
            self.imageView.center = CGPointMake(CGRectGetMaxX(self.titleLabel.frame) + myCellModel.titleImageSpacing + imageSize.width/2, self.contentView.center.y);
=======

        case JXCategoryTitleImageType_TopImage:
        {
            self.stackView.axis = UILayoutConstraintAxisVertical;
            [self.stackView addArrangedSubview:self.imageView];
            [self.stackView addArrangedSubview:self.titleLabel];
        }
            break;

        case JXCategoryTitleImageType_LeftImage:
        {
            self.stackView.axis = UILayoutConstraintAxisHorizontal;
            [self.stackView addArrangedSubview:self.imageView];
            [self.stackView addArrangedSubview:self.titleLabel];
        }
            break;

        case JXCategoryTitleImageType_BottomImage:
        {
            self.stackView.axis = UILayoutConstraintAxisVertical;
            [self.stackView addArrangedSubview:self.titleLabel];
            [self.stackView addArrangedSubview:self.imageView];
        }
            break;

        case JXCategoryTitleImageType_RightImage:
        {
            self.stackView.axis = UILayoutConstraintAxisHorizontal;
            [self.stackView addArrangedSubview:self.titleLabel];
            [self.stackView addArrangedSubview:self.imageView];
        }
>>>>>>> 0d3e236bbefe737493edd6287983b88b4ccaf517
            break;
        }
        case JXCategoryTitleImageType_OnlyImage: {
            self.titleLabel.hidden = YES;
<<<<<<< HEAD
            self.imageView.center = self.contentView.center;
=======
            [self.stackView addArrangedSubview:self.imageView];
        }
>>>>>>> 0d3e236bbefe737493edd6287983b88b4ccaf517
            break;
        }
        case JXCategoryTitleImageType_OnlyTitle: {
            self.imageView.hidden = YES;
<<<<<<< HEAD
            [self refreshTitleLabelCenter:self.contentView.center];
=======
            [self.stackView addArrangedSubview:self.titleLabel];
        }
            break;

        default:
>>>>>>> 0d3e236bbefe737493edd6287983b88b4ccaf517
            break;
        }
    }

    //因为`- (void)reloadData:(JXCategoryBaseCellModel *)cellModel`方法会回调多次，尤其是左右滚动的时候会调用无数次，如果每次都触发图片加载，会非常消耗性能。所以只会在图片发生了变化的时候，才进行图片加载。
    NSString *currentImageName;
    NSURL *currentImageURL;
    if (myCellModel.imageName) {
        currentImageName = myCellModel.imageName;
    } else if (myCellModel.imageURL) {
        currentImageURL = myCellModel.imageURL;
    }
    if (myCellModel.isSelected) {
        if (myCellModel.selectedImageName) {
            currentImageName = myCellModel.selectedImageName;
        } else if (myCellModel.selectedImageURL) {
            currentImageURL = myCellModel.selectedImageURL;
        }
    }
    if (currentImageName && ![currentImageName isEqualToString:self.currentImageName]) {
        self.currentImageName = currentImageName;
        self.imageView.image = [UIImage imageNamed:currentImageName];
    } else if (currentImageURL && ![currentImageURL.absoluteString isEqualToString:self.currentImageURL.absoluteString]) {
        self.currentImageURL = currentImageURL;
        if (myCellModel.loadImageCallback) {
            myCellModel.loadImageCallback(self.imageView, currentImageURL);
        }
    }

    if (myCellModel.isImageZoomEnabled) {
        self.imageView.transform = CGAffineTransformMakeScale(myCellModel.imageZoomScale, myCellModel.imageZoomScale);
    } else {
        self.imageView.transform = CGAffineTransformIdentity;
    }
}


@end
