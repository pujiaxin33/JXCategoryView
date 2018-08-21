//
//  BaseViewController.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/8/10.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

fileprivate let JXTableHeaderViewHeight: CGFloat = 200
fileprivate let JXheightForHeaderInSection: CGFloat = 50

class PagingViewController: UIViewController {
    var pagingView: JXPagingView!
    var userHeaderView: PagingViewTableHeaderView!
    var categoryView: JXCategoryTitleView!
    var listViewArray: [TestListBaseView]!
    var titles = ["能力", "爱好", "队友"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人中心"
        self.navigationController?.navigationBar.isTranslucent = false

        let powerListView = PowerListView()
        powerListView.delegate = self

        let hobbyListView = HobbyListView()
        hobbyListView.delegate = self

        let partnerListView = PartnerListView()
        partnerListView.delegate = self

        listViewArray = [powerListView, hobbyListView, partnerListView]

        userHeaderView = PagingViewTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: JXTableHeaderViewHeight))

        categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: JXheightForHeaderInSection))
        categoryView.titles = titles
        categoryView.backgroundColor = UIColor.white
        categoryView.titleSelectedColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
        categoryView.titleColor = UIColor.black
        categoryView.titleColorGradientEnabled = true
        categoryView.zoomEnabled = true

        let lineView = JXCategoryIndicatorLineView()
        lineView.indicatorLineWidth = 30
        lineView.indicatorLineViewColor = UIColor(red: 105/255, green: 144/255, blue: 239/255, alpha: 1)
        categoryView.indicators = [lineView]

        let lineWidth = 1/UIScreen.main.scale
        let lineLayer = CALayer()
        lineLayer.backgroundColor = UIColor.lightGray.cgColor
        lineLayer.frame = CGRect(x: 0, y: categoryView.bounds.height - lineWidth, width: categoryView.bounds.width, height: lineWidth)
        categoryView.layer.addSublayer(lineLayer)

        pagingView = JXPagingView(delegate: self)
        pagingView.delegate = self
        self.view.addSubview(pagingView)

        categoryView.contentScrollView = pagingView.listContainerView.collectionView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        pagingView.frame = self.view.bounds
    }

}

extension PagingViewController: JXPagingViewDelegate {

    func tableHeaderViewHeight(in pagingView: JXPagingView) -> CGFloat {
        return JXTableHeaderViewHeight
    }

    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return userHeaderView
    }

    func heightForHeaderInSection(in pagingView: JXPagingView) -> CGFloat {
        return JXheightForHeaderInSection
    }

    func viewForHeaderInSection(in pagingView: JXPagingView) -> UIView {
        return categoryView
    }

    func numberOfListViews(in pagingView: JXPagingView) -> Int {
        return titles.count
    }

    func pagingView(_ pagingView: JXPagingView, listViewInRow row: Int) -> UIView & JXPagingViewListViewDelegate {
        return listViewArray[row]
    }

    func mainTableViewDidScroll(_ scrollView: UIScrollView) {
        userHeaderView?.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
}

extension PagingViewController: TestListViewDelegate {
    func listViewDidScroll(_ scrollView: UIScrollView) {
        pagingView.listViewDidScroll(scrollView: scrollView)
    }
}

