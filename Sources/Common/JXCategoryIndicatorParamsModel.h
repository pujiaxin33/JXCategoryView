//
//  JXCategoryIndicatorParamsModel.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/13.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JXCategoryViewDefines.h"
/**
 指示器不同情况处理时传递的数据模型，不同情况会对不同的属性赋值，根据不同情况的api说明确认。
 为什么会通过model传递数据，因为指示器处理逻辑以后会扩展不同的使用场景，会新增参数，如果不通过model传递，就会在api新增参数，一旦修改api该的地方就特别多了，而且会影响到之前自定义实现的开发者。
 */
@interface JXCategoryIndicatorParamsModel : NSObject
@property (nonatomic, assign) NSInteger selectedIndex;      //当前选中的index
@property (nonatomic, assign) CGRect selectedCellFrame;     //当前选中的cellFrame
@property (nonatomic, assign) NSInteger leftIndex;          //正在过渡中的两个cell，相对位置在左边的cell的index
@property (nonatomic, assign) CGRect leftCellFrame;         //正在过渡中的两个cell，相对位置在左边的cell的frame
@property (nonatomic, assign) NSInteger rightIndex;         //正在过渡中的两个cell，相对位置在右边的cell的index
@property (nonatomic, assign) CGRect rightCellFrame;        //正在过渡中的两个cell，相对位置在右边的cell的frame
@property (nonatomic, assign) CGFloat percent;              //正在过渡中的两个cell，从左到右的百分比
@property (nonatomic, assign) NSInteger lastSelectedIndex;  //之前选中的index
@property (nonatomic, assign) JXCategoryCellSelectedType selectedType;  //cell被选中类型
@end


