//
//  JXCategoryNumberView.m
//  DQGuess
//
//  Created by jiaxin on 2018/4/9.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryNumberView.h"

@implementation JXCategoryNumberView

- (void)initializeData {
    [super initializeData];

    self.cellSpacing = 25;
}

- (Class)preferredCellClass {
    return [JXCategoryNumberCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryNumberCellModel *cellModel = [[JXCategoryNumberCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryNumberCellModel *myCellModel = (JXCategoryNumberCellModel *)cellModel;
    myCellModel.count = [self.counts[index] integerValue];
}

@end
