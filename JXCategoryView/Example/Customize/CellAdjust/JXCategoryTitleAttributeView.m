//
//  JXCategoryTitleAttributeView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleAttributeView.h"

@implementation JXCategoryTitleAttributeView

#pragma mark - Override

//返回自定义的cell class
- (Class)preferredCellClass {
    return [JXCategoryTitleAttributeCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.attributeTitles.count; i++) {
        JXCategoryTitleAttributeCellModel *cellModel = [[JXCategoryTitleAttributeCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];


}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

}

- (CGFloat)preferredCellWidthWithIndex:(NSInteger)index {
    if (self.cellWidth == JXCategoryViewAutomaticDimension) {
        return ceilf([self.attributeTitles[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size.width);
    }else {
        return self.cellWidth;
    }
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTitleAttributeCellModel *model = (JXCategoryTitleAttributeCellModel *)cellModel;
    model.attributeTitle = self.attributeTitles[index];
}

@end
