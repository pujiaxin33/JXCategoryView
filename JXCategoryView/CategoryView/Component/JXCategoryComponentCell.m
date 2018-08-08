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

    self.separatorLine = ({
        UIView *view = [[UIView alloc] init];
        view.hidden = YES;
        view.backgroundColor = [UIColor colorWithRed:40/255.0 green:44/255.0 blue:61/255.0 alpha:1];
        view;
    });
    [self.contentView addSubview:self.separatorLine];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat lineWidth = 1;
    CGFloat lineHeight = self.bounds.size.height/3.0;
    self.separatorLine.frame = CGRectMake(self.bounds.size.width-lineWidth, (self.bounds.size.height - lineHeight)/2.0, lineWidth, lineHeight);
}

- (void)reloadDatas:(JXCategoryBaseCellModel *)cellModel {
    [super reloadDatas:cellModel];

    JXCategoryComponentCellModel *model = (JXCategoryComponentCellModel *)cellModel;
    if (model.zoomEnabled) {
        self.transform = CGAffineTransformMakeScale(model.zoomScale, model.zoomScale);
    }else {
        self.transform = CGAffineTransformIdentity;
    }
    self.separatorLine.hidden = !model.sepratorLineShowEnabled;
}

@end
