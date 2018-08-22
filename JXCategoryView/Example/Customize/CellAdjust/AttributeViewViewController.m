//
//  AttributeViewViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "AttributeViewViewController.h"
#import "JXCategoryTitleAttributeView.h"

@interface AttributeViewViewController ()

@property (nonatomic, strong) JXCategoryTitleAttributeView *myCategoryView;
@property (nonatomic, strong) NSArray <NSAttributedString *> *attributeTitles;
@end

@implementation AttributeViewViewController

- (void)viewDidLoad {
    NSMutableAttributedString *monday = [[NSMutableAttributedString alloc] initWithString:@"周一\n8月20号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
    [monday addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];

    NSMutableAttributedString *tuesday = [[NSMutableAttributedString alloc] initWithString:@"周二\n8月21号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
    [tuesday addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];

    NSMutableAttributedString *wednesday = [[NSMutableAttributedString alloc] initWithString:@"周三\n8月22号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
    [wednesday addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];

    NSMutableAttributedString *thursday = [[NSMutableAttributedString alloc] initWithString:@"周四\n8月23号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
    [thursday addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];

    NSMutableAttributedString *friday = [[NSMutableAttributedString alloc] initWithString:@"周五\n8月24号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
    [friday addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];

    NSMutableAttributedString *saturday = [[NSMutableAttributedString alloc] initWithString:@"周六\n8月25号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
    [saturday addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];

    NSMutableAttributedString *sunday = [[NSMutableAttributedString alloc] initWithString:@"周日\n8月26号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
    [sunday addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];

    _attributeTitles = @[monday, tuesday, wednesday, thursday, friday, saturday, sunday];

    [super viewDidLoad];

    self.myCategoryView.attributeTitles = self.attributeTitles;

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewHeight = 40;
    backgroundView.backgroundViewCornerRadius = 5;
    self.myCategoryView.indicators = @[backgroundView];
}

- (JXCategoryTitleAttributeView *)myCategoryView {
    return (JXCategoryTitleAttributeView *)self.categoryView;
}

- (NSUInteger)preferredListViewCount {
    return self.attributeTitles.count;
}

- (Class)preferredCategoryViewClass {
    return [JXCategoryTitleAttributeView class];
}

@end
