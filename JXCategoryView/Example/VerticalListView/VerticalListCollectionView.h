//
//  VerticalListCollectionView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/10/10.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface VerticalListCollectionView : UICollectionView

@property (nonatomic, copy) void(^layoutSubviewsCallback)(void);

@end

