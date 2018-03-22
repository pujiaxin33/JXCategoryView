//
//  JXCategoryCellModel.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JXCategoryCellModel : NSObject

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *titleSelectedColor;

@property (nonatomic, assign) CGFloat titleFontSize;

@property (nonatomic, assign) CGFloat cellWidth;

@property (nonatomic, assign) CGFloat zoomScale;

@end
