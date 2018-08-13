//
//  JXCategoryComponentCellModel.h
//  DQGuess
//
//  Created by jiaxin on 2018/7/25.
//  Copyright © 2018年 jingbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryBaseCellModel.h"

@interface JXCategoryComponentCellModel : JXCategoryBaseCellModel

@property (nonatomic, assign) BOOL zoomEnabled;

@property (nonatomic, assign) CGFloat zoomScale;

@property (nonatomic, assign) BOOL sepratorLineShowEnabled;

@property (nonatomic, strong) UIColor *separatorLineColor;

@property (nonatomic, assign) CGSize separatorLineSize;

@property (nonatomic, assign) CGRect backgroundEllipseLayerMaskFrame;

@end
