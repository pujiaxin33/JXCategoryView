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

    _timeTitleFont = [UIFont boldSystemFontOfSize:13];
    self.titleFont = [UIFont systemFontOfSize:10];
    _timeTitleSelectedFont = [UIFont boldSystemFontOfSize:15];
    self.titleSelectedFont = [UIFont systemFontOfSize:10];
    _timeTitleNormalColor = [UIColor lightGrayColor];
    self.titleColor = [UIColor lightGrayColor];
    _timeTitleSelectedColor = [UIColor whiteColor];
    self.titleSelectedColor = [UIColor whiteColor];
    self.bottomAlpha = 1;
}

//返回自定义的cell class
- (Class)preferredCellClass {
    return [JXCategoryScrollSmallCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.statusTitles.count; i++) {
        JXCategoryScrollSmallCellModel *cellModel = [[JXCategoryScrollSmallCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryScrollSmallCellModel *model = (JXCategoryScrollSmallCellModel *)cellModel;
    model.timeTitle = self.statusTitles[index];
    model.timeTitleNormalColor = self.timeTitleNormalColor;
    model.timeTitleSelectedColor = self.timeTitleSelectedColor;
    model.timeTitleFont = self.timeTitleFont;
    model.timeTitleSelectedFont = self.timeTitleSelectedFont;
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
