//
//  JXCategoryScrollSmallView.m
//  Example
//
//  Created by tony on 2021/10/22.
//  Copyright © 2021 jiaxin. All rights reserved.
//

#import "JXCategoryScrollSmallView.h"

@implementation JXCategoryScrollSmallView
- (void)initializeData {
    [super initializeData];

    _bottomTitleFont = [UIFont boldSystemFontOfSize:13];
    self.titleFont = [UIFont systemFontOfSize:10];
    _bottomTitleSelectedFont = [UIFont boldSystemFontOfSize:15];
    self.titleSelectedFont = [UIFont systemFontOfSize:10];
    _bottomTitleNormalColor = [UIColor lightGrayColor];
    self.titleColor = [UIColor lightGrayColor];
    _bottomTitleSelectedColor = [UIColor whiteColor];
    self.titleSelectedColor = [UIColor whiteColor];
    self.bottomAlpha = 1;
}

//返回自定义的cell class
- (Class)preferredCellClass {
    return [JXCategoryScrollSmallCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.bottomTitles.count; i++) {
        JXCategoryScrollSmallCellModel *cellModel = [[JXCategoryScrollSmallCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryScrollSmallCellModel *model = (JXCategoryScrollSmallCellModel *)cellModel;
    model.bottomTitle = self.bottomTitles[index];
    model.bottomTitleNormalColor = self.bottomTitleNormalColor;
    model.bottomTitleSelectedColor = self.bottomTitleSelectedColor;
    model.bottomTitleFont = self.bottomTitleFont;
    model.bottomTitleSelectedFont = self.bottomTitleSelectedFont;
    model.bottomAlpha = self.bottomAlpha;
}

- (void)refreshBottomAlpha:(CGFloat)alpha {
    self.bottomAlpha = 1;
    for (JXCategoryScrollSmallCellModel *cellModel in self.dataSource) {
        cellModel.bottomAlpha = alpha;
    }
    NSArray <JXCategoryScrollSmallCell *> *cells = [self.collectionView visibleCells];
    for (JXCategoryScrollSmallCell *cell in cells) {
        [cell refreshBottomAlpha:alpha];
    }
}
@end
