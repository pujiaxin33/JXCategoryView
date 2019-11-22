//
//  JXCategoryTitleSortCell.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/9.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleSortCell.h"
#import "JXCategoryTitleSortCellModel.h"

@interface JXCategoryTitleSortCell ()
@property (nonatomic, strong) UIImageView *upImageView;
@property (nonatomic, strong) UIImageView *downImageView;
@property (nonatomic, strong) UIImageView *singleImageView;
@property (nonatomic, strong) NSLayoutConstraint *upCenterYCons;
@property (nonatomic, strong) NSLayoutConstraint *downCenterYCons;
@end

@implementation JXCategoryTitleSortCell

- (void)initializeViews {
    [super initializeViews];

    self.titleLabelCenterX.active = NO;
    self.maskTitleLabelCenterX.active = NO;

    [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:0].active = YES;
    [NSLayoutConstraint constraintWithItem:self.maskTitleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:0].active = YES;

    self.upImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_up"]];
    self.upImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.upImageView.hidden = YES;
    self.upImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.upImageView];
    [NSLayoutConstraint constraintWithItem:self.upImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.upImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:1].active = YES;
    self.upCenterYCons = [NSLayoutConstraint constraintWithItem:self.upImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    self.upCenterYCons.active = YES;

    self.downImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_down"]];
    self.downImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.downImageView.hidden = YES;
    self.downImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.downImageView];
    [NSLayoutConstraint constraintWithItem:self.downImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.downImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.upImageView attribute:NSLayoutAttributeLeading multiplier:1 constant:0].active = YES;
    self.downCenterYCons = [NSLayoutConstraint constraintWithItem:self.downImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    self.downCenterYCons.active = YES;

    self.singleImageView = [[UIImageView alloc] init];
    self.singleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.singleImageView.hidden = YES;
    self.singleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.singleImageView];
    [NSLayoutConstraint constraintWithItem:self.singleImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:10].active = YES;
    [NSLayoutConstraint constraintWithItem:self.singleImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:1].active = YES;
    [NSLayoutConstraint constraintWithItem:self.singleImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0].active = YES;
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    self.upImageView.hidden = YES;
    self.downImageView.hidden = YES;
    self.singleImageView.hidden = YES;

    JXCategoryTitleSortCellModel *myCellModel = (JXCategoryTitleSortCellModel *)cellModel;
    if (myCellModel.uiType == JXCategoryTitleSortUIType_ArrowBoth) {
        if (myCellModel.arrowDirection == JXCategoryTitleSortArrowDirection_Both) {
            self.upImageView.hidden = NO;
            self.downImageView.hidden = NO;
            self.upCenterYCons.constant = -3;
            self.downCenterYCons.constant = 3;
        }else if (myCellModel.arrowDirection == JXCategoryTitleSortArrowDirection_Up) {
            self.upImageView.hidden = NO;
            self.upCenterYCons.constant = 0;
        }else {
            self.downImageView.hidden = NO;
            self.downCenterYCons.constant = 0;
        }
    }else if (myCellModel.uiType == JXCategoryTitleSortUIType_ArrowDown) {
        self.downImageView.hidden = NO;
        self.downCenterYCons.constant = 0;
    }else if (myCellModel.uiType == JXCategoryTitleSortUIType_SingleImage) {
        self.singleImageView.hidden = NO;
        self.singleImageView.image = myCellModel.singleImage;
    }

}

@end
