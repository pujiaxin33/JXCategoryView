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
@end

@implementation AttributeViewViewController

- (void)viewDidLoad {
    NSArray <NSString *>*weekStringArray = @[@"周一\n8月20号", @"周二\n8月21号", @"周三\n8月22号", @"周四\n8月23号", @"周五\n8月24号", @"周六\n8月25号", @"周日\n8月26号"];
    self.titles = weekStringArray;  //主要是为了父类创建列表，实际使用不要参考这个写法。

    [super viewDidLoad];

    NSMutableArray <NSAttributedString *>*weekAttributedStringArray = [NSMutableArray array];
    NSMutableArray <NSAttributedString *>*weekSelectedAttributedStringArray = [NSMutableArray array];
    for (NSString *day in weekStringArray) {
        [weekAttributedStringArray addObject:[self weekAttributedText:day isSelected:NO]];
        [weekSelectedAttributedStringArray addObject:[self weekAttributedText:day isSelected:YES]];
    }
    self.myCategoryView.attributeTitles = weekAttributedStringArray;
    self.myCategoryView.selectedAttributeTitles = weekSelectedAttributedStringArray;
    self.myCategoryView.titleLabelZoomEnabled = YES;

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 40;
    backgroundView.indicatorCornerRadius = 5;
    self.myCategoryView.indicators = @[backgroundView];
}

- (NSAttributedString *)weekAttributedText:(NSString *)day isSelected:(BOOL)isSelected {
    NSMutableAttributedString *attrubtedText = [[NSMutableAttributedString alloc] initWithString:day attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor blackColor]}];
    if (isSelected) {
        [attrubtedText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    }else {
        [attrubtedText addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 2)];
    }
    return attrubtedText;
}

- (JXCategoryTitleAttributeView *)myCategoryView {
    return (JXCategoryTitleAttributeView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleAttributeView alloc] init];
}

@end
