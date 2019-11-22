//
//  JXGradientView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/20.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "JXGradientView.h"

@implementation JXGradientView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

@end
