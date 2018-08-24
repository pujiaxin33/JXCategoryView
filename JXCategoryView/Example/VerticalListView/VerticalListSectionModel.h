//
//  VerticalListSectionModel.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VerticalListCellModel.h"

@interface VerticalListSectionModel : NSObject

@property (nonatomic, copy) NSString *sectionTitle;

@property (nonatomic, strong) NSArray <VerticalListCellModel *> *cellModels;

@end
