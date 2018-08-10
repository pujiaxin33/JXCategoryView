//
//  TestListView.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/5/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

@objc protocol TestListViewDelegate {
    func listViewDidScroll(_ scrollView: UIScrollView)
}

class TestListBaseView: UIView {
    var tableView: UITableView!
    var dataSource: [String]?
    weak var delegate: TestListViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView = UITableView(frame: frame, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        addSubview(tableView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        tableView.frame = self.bounds
    }

}

extension TestListBaseView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource?[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegate?.listViewDidScroll(scrollView)
    }
}

extension TestListBaseView: JXPagingViewListViewDelegate {
    var scrollView: UIScrollView {
        return self.tableView
    }
}
