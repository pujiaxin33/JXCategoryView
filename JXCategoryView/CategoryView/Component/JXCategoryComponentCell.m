//
//  JXCategoryComponetCell.m
//  DQGuess
//
//  Created by jiaxin on 2018/7/25.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import "JXCategoryComponentCell.h"
#import "JXCategoryComponentCellModel.h"

@interface JXCategoryComponentCell ()
@property (nonatomic, strong) UIView *separatorLine;
@end

@implementation JXCategoryComponentCell

- (void)initializeViews
{
    [super initializeViews];

    self.separatorLine = [[UIView alloc] init];
    self.separatorLine.hidden = YES;
    [self.contentView addSubview:self.separatorLine];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    JXCategoryComponentCellModel *model = (JXCategoryComponentCellModel *)self.cellModel;
    CGFloat lineWidth = model.separatorLineSize.width;
    CGFloat lineHeight = model.separatorLineSize.height;

    self.separatorLine.frame = CGRectMake(self.bounds.size.width - lineWidth + self.cellModel.cellSpacing/2, (self.bounds.size.height - lineHeight)/2.0, lineWidth, lineHeight);
}

- (void)reloadDatas:(JXCategoryBaseCellModel *)cellModel {
    [super reloadDatas:cellModel];

    JXCategoryComponentCellModel *model = (JXCategoryComponentCellModel *)cellModel;
    if (model.zoomEnabled) {
        self.transform = CGAffineTransformMakeScale(model.zoomScale, model.zoomScale);
    }else {
        self.transform = CGAffineTransformIdentity;
    }
    self.separatorLine.backgroundColor = model.separatorLineColor;
    self.separatorLine.hidden = !model.sepratorLineShowEnabled;
}

@end
