//
//  JXCategoryView.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleView.h"
#import "JXCategoryTitleCell.h"
#import "JXCategoryTitleCellModel.h"
#import "UIColor+JXAdd.h"

@interface JXCategoryTitleView ()

@end

@implementation JXCategoryTitleView

- (void)initializeDatas
{
    [super initializeDatas];

    _titleColor = [UIColor whiteColor];
    _titleSelectedColor = [UIColor grayColor];
    _titleFont = [UIFont systemFontOfSize:15];
    _titleColorGradientEnabled = NO;
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;

    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i++) {
        JXCategoryTitleCellModel *cellModel = [[JXCategoryTitleCellModel alloc] init];
        cellModel.title = self.titles[i];
        [tempArray addObject:cellModel];
    }
    self.dataSource = tempArray;
}

#pragma mark - Override

- (Class)preferredCellClass {
    return [JXCategoryTitleCell class];
}

- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    [super refreshSelectedCellModel:selectedCellModel unselectedCellModel:unselectedCellModel];

    JXCategoryTitleCellModel *myUnselectedCellModel = (JXCategoryTitleCellModel *)unselectedCellModel;
    myUnselectedCellModel.titleColor = self.titleColor;
    myUnselectedCellModel.titleSelectedColor = self.titleSelectedColor;

    JXCategoryTitleCellModel *myselectedCellModel = (JXCategoryTitleCellModel *)selectedCellModel;
    myselectedCellModel.titleColor = self.titleColor;
    myselectedCellModel.titleSelectedColor = self.titleSelectedColor;
}

- (void)refreshLeftCellModel:(JXCategoryBaseCellModel *)leftCellModel rightCellModel:(JXCategoryBaseCellModel *)rightCellModel ratio:(CGFloat)ratio {
    [super refreshLeftCellModel:leftCellModel rightCellModel:rightCellModel ratio:ratio];

    //处理颜色渐变
    if (!self.titleColorGradientEnabled) {
        return;
    }

    JXCategoryTitleCellModel *leftModel = (JXCategoryTitleCellModel *)leftCellModel;
    JXCategoryTitleCellModel *rightModel = (JXCategoryTitleCellModel *)rightCellModel;
    if (leftModel.selected) {
        leftModel.titleSelectedColor = [self interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
        leftModel.titleColor = self.titleColor;
    }else {
        leftModel.titleColor = [self interpolationColorFrom:self.titleSelectedColor to:self.titleColor percent:ratio];
        leftModel.titleSelectedColor = self.titleSelectedColor;
    }
    if (rightModel.selected) {
        rightModel.titleSelectedColor = [self interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
        rightModel.titleColor = self.titleColor;
    }else {
        rightModel.titleColor = [self interpolationColorFrom:self.titleColor to:self.titleSelectedColor percent:ratio];
        rightModel.titleSelectedColor = self.titleSelectedColor;
    }
}

- (CGFloat)preferredCellWidthWithIndex:(NSInteger)index {
    if (self.cellWidth == JXCategoryViewAutomaticDimension) {
        return ceilf([self.titles[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleFont} context:nil].size.width) + 10;
    }else {
        return self.cellWidth;
    }
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {
    [super refreshCellModel:cellModel index:index];

    JXCategoryTitleCellModel *model = (JXCategoryTitleCellModel *)cellModel;
    model.titleFont = self.titleFont;
    model.titleColor = self.titleColor;
    model.titleSelectedColor = self.titleSelectedColor;
}

#pragma mark - Private

- (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat red = [self interpolationFrom:fromColor.red to:toColor.red percent:percent];
    CGFloat green = [self interpolationFrom:fromColor.green to:toColor.green percent:percent];
    CGFloat blue = [self interpolationFrom:fromColor.blue to:toColor.blue percent:percent];
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];

}

@end
