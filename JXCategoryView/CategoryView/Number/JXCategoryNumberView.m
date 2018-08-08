//
//  JXCategoryNumberView.m
//  DQGuess
//
//  Created by jiaxin on 2018/4/9.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryNumberView.h"
#import "JXCategoryNumberCell.h"
#import "JXCategoryNumberCellModel.h"

@implementation JXCategoryNumberView

- (Class)preferredCellClass {
    return [JXCategoryNumberCell class];
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    super.titles = titles;

    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryNumberCellModel *cellModel = [[JXCategoryNumberCellModel alloc] init];
        cellModel.title = self.titles[i];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

- (void)setCounts:(NSArray<NSNumber *> *)counts {
    _counts = counts;

    for (int i = 0; i < self.dataSource.count; i ++) {
        JXCategoryNumberCellModel *cellModel = (JXCategoryNumberCellModel *)self.dataSource[i];
        NSInteger count = [counts[i] integerValue];
        cellModel.count = count;
    }
}

@end
