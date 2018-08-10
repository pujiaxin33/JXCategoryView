//
//  HobbyListView.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/5/29.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class HobbyListView: TestListBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        dataSource = ["吃烤肉", "吃鸡腿肉", "吃牛肉", "各种肉"]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
