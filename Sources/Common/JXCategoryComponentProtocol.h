//
//  JXCategoryComponentProtocol.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/17.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol JXCategoryComponentProtocol <NSObject>

- (void)jx_refreshState:(CGRect)selectedCellFrame;

- (void)jx_contentScrollViewDidScrollWithLeftCellFrame:(CGRect)leftCellFrame rightCellFrame:(CGRect)rightCellFrame isLeftCellSelected:(BOOL)isLeftCellSelected percent:(CGFloat)percent;

/**
 点击选中了某一个cell

 @param cellFrame cell的frame
 @param isLeftCellSelected 是否点击了相对于当前已选中cell左边的cell。比如 A、B、C 当前处于选中状态的是B。点击了A，isLeftCellSelected=YES;点击了C，isLeftCellSelected=NO;
 */
- (void)jx_selectedCell:(CGRect)cellFrame isLeftCellSelected:(BOOL)isLeftCellSelected;

@end
