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

@protocol JXCategoryIndicatorProtocol <NSObject>

- (void)jx_refreshState:(CGRect)selectedCellFrame;


/**
 contentScrollView在进行手势滑动时，处理指示器跟随手势变化UI逻辑；

 @param leftCellFrame 正在过渡中的两个cell，相对位置在左边的cell的frame
 @param rightCellFrame 正在过渡中的两个cell，相对位置在右边的cell的frame
 @param selectedPosition 当前处于选中状态的cell的位置
 @param percent 过渡百分比
 */
- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame selectedPosition:(JXCategoryCellClickedPosition)selectedPosition percent:(CGFloat)percent;

/**
 点击选中了某一个cell

 @param cellFrame cell的frame
 @param clickedRelativePosition 相对于已选中cell，当前点击的cell的相对位置。比如 A、B、C 当前处于选中状态的是B。点击了A是JXCategoryCellClickedPosition_Left；点击了C是JXCategoryCellClickedPosition_Right;
 @param isClicked YES：点击选中；NO：滚动选中。
 */
- (void)jx_selectedCell:(CGRect)cellFrame clickedRelativePosition:(JXCategoryCellClickedPosition)clickedRelativePosition isClicked:(BOOL)isClicked;

@end
