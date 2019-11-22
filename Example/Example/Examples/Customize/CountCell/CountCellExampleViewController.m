//
//  CountCellExampleViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2019/7/20.
//  Copyright © 2019 jiaxin. All rights reserved.
//

#import "CountCellExampleViewController.h"
#import "JXCategoryTitleAttributeView.h"

@interface CountCellExampleViewController ()

@property (nonatomic, strong) JXCategoryTitleAttributeView *myCategoryView;
@end

@implementation CountCellExampleViewController

- (void)viewDidLoad {
    NSArray <NSString *>*mainTitles = @[@"已完成", @"未完成", @"进行中", @"计划中"];
    self.titles = mainTitles;  //主要是为了父类创建列表，实际使用不要参考这个写法。

    [super viewDidLoad];
    NSArray <NSNumber *>*counts = @[@(10), @(33), @(3), @(99)];
    NSMutableArray <NSAttributedString *>*attributedStringArray = [NSMutableArray array];
    NSMutableArray <NSAttributedString *>*selectedAttributedStringArray = [NSMutableArray array];
    for (NSInteger index = 0; index < mainTitles.count; index++) {
        [attributedStringArray addObject:[self attributedText:mainTitles[index] count:counts[index] isSelected:NO]];
        [selectedAttributedStringArray addObject:[self attributedText:mainTitles[index] count:counts[index] isSelected:YES]];
    }
    self.myCategoryView.attributeTitles = attributedStringArray;
    self.myCategoryView.selectedAttributeTitles = selectedAttributedStringArray;
    self.myCategoryView.titleLabelZoomEnabled = YES;

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 40;
    backgroundView.indicatorCornerRadius = 5;
    self.myCategoryView.indicators = @[backgroundView];
}

- (NSAttributedString *)attributedText:(NSString *)title count:(NSNumber *)count isSelected:(BOOL)isSelected {
    NSString *countString = [[NSString alloc] initWithFormat:@"(%@)", count];
    NSString *allString = [NSString stringWithFormat:@"%@%@", title, countString];
    UIColor *tintColor = nil;
    if (isSelected) {
        tintColor = [UIColor redColor];
    }else {
        tintColor = [UIColor blackColor];
    }
    NSMutableAttributedString *attrubtedText = [[NSMutableAttributedString alloc] initWithString:allString attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : tintColor}];
    [attrubtedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[allString rangeOfString:countString]];
    //让数量对齐
    [attrubtedText addAttribute:NSBaselineOffsetAttributeName value:@(([UIFont systemFontOfSize:15].lineHeight - [UIFont systemFontOfSize:12].lineHeight)/2 + (([UIFont systemFontOfSize:15].descender - [UIFont systemFontOfSize:12].descender))) range:[allString rangeOfString:countString]];
    return attrubtedText;
}

- (JXCategoryTitleAttributeView *)myCategoryView {
    return (JXCategoryTitleAttributeView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleAttributeView alloc] init];
}

@end
