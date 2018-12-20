//
//  LoadDataBaseViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "LoadDataBaseViewController.h"

@interface LoadDataBaseViewController ()

@end

@implementation LoadDataBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新数据" style:UIBarButtonItemStylePlain target:self action:@selector(reloadData)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (NSArray <NSString *> *)getRandomTitles {
    NSMutableArray *titles = @[@"红烧螃蟹", @"麻辣龙虾", @"美味苹果", @"胡萝卜", @"清甜葡萄", @"美味西瓜", @"美味香蕉", @"香甜菠萝", @"麻辣干锅", @"剁椒鱼头", @"鸳鸯火锅"].mutableCopy;
    NSInteger randomMaxCount = arc4random()%6 + 5;
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 0; i < randomMaxCount; i++) {
        NSInteger randomIndex = arc4random()%titles.count;
        [resultArray addObject:titles[randomIndex]];
        [titles removeObjectAtIndex:randomIndex];
    }
    return resultArray;
}

- (void)reloadData {
    
}

@end
