//
//  JXCategoryTitleCell.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryTitleCell.h"
#import "JXCategoryTitleCellModel.h"
#import "JXCategoryFactory.h"

@interface JXCategoryTitleCell ()
@property (nonatomic, strong) CALayer *titleMaskLayer;
@property (nonatomic, strong) CALayer *maskTitleMaskLayer;
@end

@implementation JXCategoryTitleCell

- (void)initializeViews
{
    [super initializeViews];
    
    _titleLabel = [[UILabel alloc] init];
    self.titleLabel.clipsToBounds = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];

    _titleMaskLayer = [CALayer layer];
    self.titleMaskLayer.backgroundColor = [UIColor redColor].CGColor;

    _maskTitleLabel = [[UILabel alloc] init];
    _maskTitleLabel.hidden = YES;
    self.maskTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.maskTitleLabel];

    _maskTitleMaskLayer = [CALayer layer];
    self.maskTitleMaskLayer.backgroundColor = [UIColor redColor].CGColor;
    self.maskTitleLabel.layer.mask = self.maskTitleMaskLayer;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.titleLabel.center = self.contentView.center;
    self.maskTitleLabel.center = self.contentView.center;
}

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel {
    [super reloadData:cellModel];

    JXCategoryTitleCellModel *myCellModel = (JXCategoryTitleCellModel *)cellModel;

    if (myCellModel.titleLabelZoomEnabled) {
        //先把font设置为缩放的最大值，再缩小到最小值，最后根据当前的titleLabelZoomScale值，进行缩放更新。这样就能避免transform从小到大时字体模糊
        UIFont *maxScaleFont = [UIFont fontWithDescriptor:myCellModel.titleFont.fontDescriptor size:myCellModel.titleFont.pointSize*myCellModel.titleLabelSelectedZoomScale];
        CGFloat baseScale = myCellModel.titleFont.lineHeight/maxScaleFont.lineHeight;
        if (myCellModel.selectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
            JXCategoryCellSelectedAnimationBlock block = [self preferredTitleZoomAnimationBlock:myCellModel baseScale:baseScale];
            [self addSelectedAnimationBlock:block];
        }else {
            self.titleLabel.font = maxScaleFont;
            self.maskTitleLabel.font = maxScaleFont;
            CGAffineTransform currentTransform = CGAffineTransformMakeScale(baseScale*myCellModel.titleLabelCurrentZoomScale, baseScale*myCellModel.titleLabelCurrentZoomScale);
            self.titleLabel.transform = currentTransform;
            self.maskTitleLabel.transform = currentTransform;
        }
    }else {
        if (myCellModel.selected) {
            self.titleLabel.font = myCellModel.titleSelectedFont;
            self.maskTitleLabel.font = myCellModel.titleSelectedFont;
        }else {
            self.titleLabel.font = myCellModel.titleFont;
            self.maskTitleLabel.font = myCellModel.titleFont;
        }
    }

    NSString *titleString = myCellModel.title ? myCellModel.title : @"";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titleString];
    if (myCellModel.titleLabelStrokeWidthEnabled) {
        if (myCellModel.selectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
            JXCategoryCellSelectedAnimationBlock block = [self preferredTitleStrokeWidthAnimationBlock:myCellModel attributedString:attributedString];
            [self addSelectedAnimationBlock:block];
        }else {
            [attributedString addAttribute:NSStrokeWidthAttributeName value:@(myCellModel.titleLabelCurrentStrokeWidth) range:NSMakeRange(0, titleString.length)];
            self.titleLabel.attributedText = attributedString;
            self.maskTitleLabel.attributedText = attributedString;
        }
    }else {
        self.titleLabel.attributedText = attributedString;
        self.maskTitleLabel.attributedText = attributedString;
    }

    if (myCellModel.titleLabelMaskEnabled) {
        self.maskTitleLabel.hidden = NO;
        self.titleLabel.textColor = myCellModel.titleNormalColor;
        self.maskTitleLabel.textColor = myCellModel.titleSelectedColor;
        [self.maskTitleLabel sizeToFit];

        CGRect topMaskframe = myCellModel.backgroundViewMaskFrame;
        //将相对于cell的backgroundViewMaskFrame转换为相对于maskTitleLabel
        //使用self.bounds.size.width而不是self.contentView.bounds.size.width。因为某些情况下，会出现self.bounds是正确的，而self.contentView.bounds还是重用前的状态。
        topMaskframe.origin.y = 0;
        CGRect bottomMaskFrame = topMaskframe;
        CGFloat maskStartX = 0;
        if (self.maskTitleLabel.bounds.size.width >= self.bounds.size.width) {
            topMaskframe.origin.x -= (self.maskTitleLabel.bounds.size.width -self.bounds.size.width)/2;
            bottomMaskFrame.size.width = self.maskTitleLabel.bounds.size.width;
            maskStartX = -(self.maskTitleLabel.bounds.size.width -self.bounds.size.width)/2;
        }else {
            bottomMaskFrame.size.width = self.bounds.size.width;
            topMaskframe.origin.x -= (self.bounds.size.width -self.maskTitleLabel.bounds.size.width)/2;
            maskStartX = 0;
        }
        bottomMaskFrame.origin.x = topMaskframe.origin.x;
        if (topMaskframe.origin.x > maskStartX) {
            bottomMaskFrame.origin.x = topMaskframe.origin.x - bottomMaskFrame.size.width;
        }else {
            bottomMaskFrame.origin.x = CGRectGetMaxX(topMaskframe);
        }

        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        if (topMaskframe.size.width > 0 && CGRectIntersectsRect(topMaskframe, self.maskTitleLabel.frame)) {
            self.titleLabel.layer.mask = self.titleMaskLayer;
            self.maskTitleMaskLayer.frame = topMaskframe;
            self.titleMaskLayer.frame = bottomMaskFrame;
        }else {
            self.maskTitleMaskLayer.frame = topMaskframe;
            self.titleLabel.layer.mask = nil;
        }
        [CATransaction commit];
    }else {
        self.maskTitleLabel.hidden = YES;
        self.titleLabel.layer.mask = nil;
        if (myCellModel.selectedAnimationEnabled && [self checkCanStartSelectedAnimation:myCellModel]) {
            JXCategoryCellSelectedAnimationBlock block = [self preferredTitleColorAnimationBlock:myCellModel];
            [self addSelectedAnimationBlock:block];
        }else {
           self.titleLabel.textColor = myCellModel.titleCurrentColor;
        }
    }

    [self startSelectedAnimationIfNeeded:myCellModel];

    [self.titleLabel sizeToFit];
    [self setNeedsLayout];
}

- (JXCategoryCellSelectedAnimationBlock)preferredTitleZoomAnimationBlock:(JXCategoryTitleCellModel *)cellModel baseScale:(CGFloat)baseScale {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.selected) {
            //将要选中，scale从小到大插值渐变
            cellModel.titleLabelCurrentZoomScale = [JXCategoryFactory interpolationFrom:cellModel.titleLabelNormalZoomScale to:cellModel.titleLabelSelectedZoomScale percent:percent];
        }else {
            //将要取消选中，scale从大到小插值渐变
            cellModel.titleLabelCurrentZoomScale = [JXCategoryFactory interpolationFrom:cellModel.titleLabelSelectedZoomScale to:cellModel.titleLabelNormalZoomScale percent:percent];
        }
        CGAffineTransform currentTransform = CGAffineTransformMakeScale(baseScale*cellModel.titleLabelCurrentZoomScale, baseScale*cellModel.titleLabelCurrentZoomScale);
        weakSelf.titleLabel.transform = currentTransform;
        weakSelf.maskTitleLabel.transform = currentTransform;
    };
}

- (JXCategoryCellSelectedAnimationBlock)preferredTitleStrokeWidthAnimationBlock:(JXCategoryTitleCellModel *)cellModel attributedString:(NSMutableAttributedString *)attributedString {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.selected) {
            //将要选中，StrokeWidth从小到大插值渐变
            cellModel.titleLabelCurrentStrokeWidth = [JXCategoryFactory interpolationFrom:cellModel.titleLabelNormalStrokeWidth to:cellModel.titleLabelSelectedStrokeWidth percent:percent];
        }else {
            //将要取消选中，StrokeWidth从大到小插值渐变
            cellModel.titleLabelCurrentStrokeWidth = [JXCategoryFactory interpolationFrom:cellModel.titleLabelSelectedStrokeWidth to:cellModel.titleLabelNormalStrokeWidth percent:percent];
        }
        [attributedString addAttribute:NSStrokeWidthAttributeName value:@(cellModel.titleLabelCurrentStrokeWidth) range:NSMakeRange(0, attributedString.string.length)];
        weakSelf.titleLabel.attributedText = attributedString;
        weakSelf.maskTitleLabel.attributedText = attributedString;
    };
}

- (JXCategoryCellSelectedAnimationBlock)preferredTitleColorAnimationBlock:(JXCategoryTitleCellModel *)cellModel {
    __weak typeof(self) weakSelf = self;
    return ^(CGFloat percent) {
        if (cellModel.selected) {
            //将要选中，textColor从titleNormalColor到titleSelectedColor插值渐变
            cellModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:cellModel.titleNormalColor to:cellModel.titleSelectedColor percent:percent];
        }else {
            //将要取消选中，textColor从titleSelectedColor到titleNormalColor插值渐变
            cellModel.titleCurrentColor = [JXCategoryFactory interpolationColorFrom:cellModel.titleSelectedColor to:cellModel.titleNormalColor percent:percent];
        }
        weakSelf.titleLabel.textColor = cellModel.titleCurrentColor;
    };
}


@end
