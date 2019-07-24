//
//  JXCategoryTimelineView.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/23.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "JXCategoryTimelineView.h"

@implementation JXCategoryTimelineView

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
}

//返回自定义的cell class
- (Class)preferredCellClass {
    return [JXCategoryTimelineCell class];
}

- (void)refreshDataSource {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.timeTitles.count; i++) {
        JXCategoryTimelineCellModel *cellModel = [[JXCategoryTimelineCellModel alloc] init];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTimelineCellModel *model = (JXCategoryTimelineCellModel *)cellModel;
    model.timeTitle = self.timeTitles[index];
    model.timeTitleNormalColor = self.timeTitleNormalColor;
    model.timeTitleSelectedColor = self.timeTitleSelectedColor;
    model.timeTitleFont = self.timeTitleFont;
    model.timeTitleSelectedFont = self.timeTitleSelectedFont;
}

@end
