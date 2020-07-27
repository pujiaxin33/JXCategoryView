//
//  JXPagerListRefreshView.m
//  JXPagerView
//
//  Created by jiaxin on 2018/8/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXPagerListRefreshView.h"

@interface JXPagerListRefreshView()
@property (nonatomic, assign) CGFloat lastScrollingListViewContentOffsetY;
@end

@implementation JXPagerListRefreshView

- (instancetype)initWithDelegate:(id<JXPagerViewDelegate>)delegate listContainerType:(JXPagerListContainerType)type {
    self = [super initWithDelegate:delegate listContainerType:type];
    if (self) {
        self.mainTableView.bounces = NO;
    }
    return self;
}

- (void)preferredProcessListViewDidScroll:(UIScrollView *)scrollView {
    BOOL shouldProcess = YES;
    if (self.currentScrollingListView.contentOffset.y > self.lastScrollingListViewContentOffsetY) {
        //往上滚动
    }else {
        //往下滚动
        if (self.mainTableView.contentOffset.y == 0) {
            shouldProcess = NO;
        }else {
            if (self.mainTableView.contentOffset.y < self.mainTableViewMaxContentOffsetY) {
                //mainTableView的header还没有消失，让listScrollView一直为0
                if (self.currentList && [self.currentList respondsToSelector:@selector(listScrollViewWillResetContentOffset)]) {
                    [self.currentList listScrollViewWillResetContentOffset];
                }
                [self setListScrollViewToMinContentOffsetY:self.currentScrollingListView];
                if (self.automaticallyDisplayListVerticalScrollIndicator) {
                    self.currentScrollingListView.showsVerticalScrollIndicator = NO;
                }
            }
        }
    }
    if (shouldProcess) {
        if (self.mainTableView.contentOffset.y < self.mainTableViewMaxContentOffsetY) {
            //处于下拉刷新的状态，scrollView.contentOffset.y为负数，就重置为0
            if (self.currentScrollingListView.contentOffset.y > [self minContentOffsetYInListScrollView:self.currentScrollingListView]) {
                //mainTableView的header还没有消失，让listScrollView一直为0
                if (self.currentList && [self.currentList respondsToSelector:@selector(listScrollViewWillResetContentOffset)]) {
                    [self.currentList listScrollViewWillResetContentOffset];
                }
                [self setListScrollViewToMinContentOffsetY:self.currentScrollingListView];
                if (self.automaticallyDisplayListVerticalScrollIndicator) {
                    self.currentScrollingListView.showsVerticalScrollIndicator = NO;
                }
            }
        } else {
            //mainTableView的header刚好消失，固定mainTableView的位置，显示listScrollView的滚动条
            self.mainTableView.contentOffset = CGPointMake(0, self.mainTableViewMaxContentOffsetY);
            if (self.automaticallyDisplayListVerticalScrollIndicator) {
                self.currentScrollingListView.showsVerticalScrollIndicator = YES;
            }
        }
    }
    self.lastScrollingListViewContentOffsetY = self.currentScrollingListView.contentOffset.y;
}

- (void)preferredProcessMainTableViewDidScroll:(UIScrollView *)scrollView {
    if (self.pinSectionHeaderVerticalOffset != 0) {
        if (!(self.currentScrollingListView != nil && self.currentScrollingListView.contentOffset.y > [self minContentOffsetYInListScrollView:self.currentScrollingListView])) {
            //没有处于滚动某一个listView的状态
            if (scrollView.contentOffset.y <= 0) {
                self.mainTableView.bounces = NO;
                self.mainTableView.contentOffset = CGPointZero;
                return;
            }else {
                self.mainTableView.bounces = YES;
            }
        }
    }
    if (self.currentScrollingListView != nil && self.currentScrollingListView.contentOffset.y > [self minContentOffsetYInListScrollView:self.currentScrollingListView]) {
        //mainTableView的header已经滚动不见，开始滚动某一个listView，那么固定mainTableView的contentOffset，让其不动
        [self setMainTableViewToMaxContentOffsetY];
    }

    if (scrollView.contentOffset.y < self.mainTableViewMaxContentOffsetY) {
        //mainTableView已经显示了header，listView的contentOffset需要重置
        for (id<JXPagerViewListViewDelegate> list in self.validListDict.allValues) {
            //正在下拉刷新时，不需要重置
            UIScrollView *listScrollView = [list listScrollView];
            if (listScrollView.contentOffset.y > 0) {
                if ([list respondsToSelector:@selector(listScrollViewWillResetContentOffset)]) {
                    [list listScrollViewWillResetContentOffset];
                }
                [self setListScrollViewToMinContentOffsetY:listScrollView];
            }
        }
    }

    if (scrollView.contentOffset.y > self.mainTableViewMaxContentOffsetY && self.currentScrollingListView.contentOffset.y == [self minContentOffsetYInListScrollView:self.currentScrollingListView]) {
        //当往上滚动mainTableView的headerView时，滚动到底时，修复listView往上小幅度滚动
        [self setMainTableViewToMaxContentOffsetY];
    }
}


@end
