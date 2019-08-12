//
//  JXCategoryTitleSortView.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/8/9.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTitleSortView.h"

@implementation JXCategoryTitleSortView

- (void)initializeData {
    [super initializeData];

}

//返回自定义的cell class
- (Class)preferredCellClass {
    return [JXCategoryTitleSortCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryTitleSortCellModel *cellModel = [[JXCategoryTitleSortCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTitleSortCellModel *myModel = (JXCategoryTitleSortCellModel *)cellModel;
    myModel.uiType = (JXCategoryTitleSortUIType)(self.uiTypes[@(index)].integerValue);
    myModel.arrowDirection = (JXCategoryTitleSortArrowDirection)(self.arrowDirections[@(index)].integerValue);
    myModel.singleImage = self.singleImages[@(index)];
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    CGFloat cellWidth = [super preferredCellWidthAtIndex:index];
    JXCategoryTitleSortUIType uiType = (JXCategoryTitleSortUIType)(self.uiTypes[@(index)].integerValue);
    if (uiType == JXCategoryTitleSortUIType_ArrowNone) {
        return cellWidth;
    }
    return cellWidth + 3 + 10;
}

@end
