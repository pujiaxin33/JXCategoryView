//
//  JXCategoryImageView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryImageView.h"
#import "JXCategoryImageCell.h"
#import "JXCategoryImageCellModel.h"

@implementation JXCategoryImageView

- (void)initializeDatas {
    [super initializeDatas];

    _imageType = JXCategoryImageType_LeftImage;
    _imageSize = CGSizeMake(20, 20);
    _titleImageSpacing = 5;
}

- (Class)preferredCellClass {
    return [JXCategoryImageCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryImageCellModel *cellModel = [[JXCategoryImageCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryImageCellModel *myCellModel = (JXCategoryImageCellModel *)cellModel;
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
