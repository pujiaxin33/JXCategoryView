//
//  JXCategoryImageView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleImageView.h"
#import "JXCategoryTitleImageCell.h"
#import "JXCategoryTitleImageCellModel.h"
#import "JXCategoryFactory.h"

@implementation JXCategoryTitleImageView

- (void)dealloc
{
    self.loadImageCallback = nil;
}

- (void)initializeData {
    [super initializeData];

    _imageSize = CGSizeMake(20, 20);
    _titleImageSpacing = 5;
    _imageZoomEnabled = NO;
    _imageZoomScale = 1.2;
}

- (Class)preferredCellClass {
    return [JXCategoryTitleImageCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryTitleImageCellModel *cellModel = [[JXCategoryTitleImageCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    if (self.imageTypes == nil || self.imageTypes.count == 0) {
        NSMutableArray *types = [NSMutableArray array];
        for (int i = 0; i < self.titles.count; i++) {
            [types addObject:@(JXCategoryTitleImageType_LeftImage)];
        }
        self.imageTypes = types;
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTitleImageCellModel *myCellModel = (JXCategoryTitleImageCellModel *)cellModel;
    myCellModel.loadImageCallback = self.loadImageCallback;
    myCellModel.imageType = [self.imageTypes[index] integerValue];
    myCellModel.imageSize = self.imageSize;
    myCellModel.titleImageSpacing = self.titleImageSpacing;
    if (self.imageNames != nil) {
        myCellModel.imageName = self.imageNames[index];
    }else if (self.imageURLs != nil) {
        myCellModel.imageURL = self.imageURLs[index];
    }
    if (self.selectedImageNames != nil) {
        myCellModel.selectedImageName = self.selectedImageNames[index];
    }else if (self.selectedImageURLs != nil) {
        myCellModel.selectedImageURL = self.selectedImageURLs[index];
    }
    myCellModel.imageZoomEnabled = self.imageZoomEnabled;
    myCellModel.imageZoomScale = 1.0;
    if (index == self.selectedIndex) {
        myCellModel.imageZoomScale = self.imageZoomScale;
    }
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    JXCategoryTitleImageCellModel *myUnselectedCellModel = (JXCategoryTitleImageCellModel *)unselectedCellModel;
    myUnselectedCellModel.imageZoomScale = 1.0;

    JXCategoryTitleImageCellModel *myselectedCellModel = (JXCategoryTitleImageCellModel *)selectedCellModel;
    myselectedCellModel.imageZoomScale = self.imageZoomScale;
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    JXCategoryTitleImageCellModel *leftModel = (JXCategoryTitleImageCellModel *)leftCellModel;
    JXCategoryTitleImageCellModel *rightModel = (JXCategoryTitleImageCellModel *)rightCellModel;

    if (self.isImageZoomEnabled) {
        leftModel.imageZoomScale = [JXCategoryFactory interpolationFrom:self.imageZoomScale to:1.0 percent:ratio];
        rightModel.imageZoomScale = [JXCategoryFactory interpolationFrom:1.0 to:self.imageZoomScale percent:ratio];
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    CGFloat titleWidth = [super preferredCellWidthAtIndex:index];
    JXCategoryTitleImageType type = [self.imageTypes[index] integerValue];
    CGFloat cellWidth = 0;
    switch (type) {
        case JXCategoryTitleImageType_OnlyTitle:
            cellWidth = titleWidth;
            break;
        case JXCategoryTitleImageType_OnlyImage:
            cellWidth = self.imageSize.width;
            break;
        case JXCategoryTitleImageType_LeftImage:
        case JXCategoryTitleImageType_RightImage:
            cellWidth = titleWidth + self.titleImageSpacing + self.imageSize.width;
            break;
        case JXCategoryTitleImageType_TopImage:
        case JXCategoryTitleImageType_BottomImage:
            cellWidth = MAX(titleWidth, self.imageSize.width);
            break;
    }
    return cellWidth;
}

@end
