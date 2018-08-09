//
//  JXCategoryLineStyleCell.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryBackgroundImageCell.h"


/**
 虽然我什么都没有做，但是要保持好队形。
 一个子类JXCategoryBaseView，都要子类化JXCategoryBaseCell、JXCategoryBaseCellModel。
 这样后续的继承才不会乱掉。所以，做新的子类化的时候，三个都要继承。避免中间某些特性丢失。
 */
@interface JXCategoryLineStyleCell : JXCategoryBackgroundImageCell

@end
