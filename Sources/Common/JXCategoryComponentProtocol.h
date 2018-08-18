//
//  JXCategoryComponentProtocol.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JXCategoryViewDefines.h"

@protocol JXCategoryComponentProtocol <NSObject>

- (void)jx_refreshState:(CGRect)selectedCellFrame;

- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame clickedPosition:(JXCategoryCellClickedPosition)clickedPosition percent:(CGFloat)percent;

/**
 点击选中了某一个cell

 @param cellFrame cell的frame
 @param clickedPosition 相对于已选中cell，当前点击的cell位置。比如 A、B、C 当前处于选中状态的是B。点击了A是JXCategoryCellClickedPosition_Left；点击了C是JXCategoryCellClickedPosition_Right;
 */
- (void)jx_selectedCell:(CGRect)cellFrame clickedPosition:(JXCategoryCellClickedPosition)clickedPosition;

@end
