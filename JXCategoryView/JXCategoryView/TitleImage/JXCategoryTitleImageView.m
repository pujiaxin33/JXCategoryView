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

@implementation JXCategoryTitleImageView

- (void)initializeDatas {
    [super initializeDatas];

    _imageType = JXCategoryTitleImageType_LeftImage;
    _imageSize = CGSizeMake(20, 20);
    _titleImageSpacing = 5;
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
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTitleImageCellModel *myCellModel = (JXCategoryTitleImageCellModel *)cellModel;
    myCellModel.imageType = self.imageType;
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
}

- (CGFloat)preferredCellWidthWithIndex:(NSInteger)index {
    CGFloat width = [super preferredCellWidthWithIndex:index];
    return width + self.titleImageSpacing + self.imageSize.width;
}

@end
