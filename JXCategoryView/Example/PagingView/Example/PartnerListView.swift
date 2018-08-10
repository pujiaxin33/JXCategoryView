//
//  PartnerListView.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/5/29.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class PartnerListView: TestListBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        dataSource = ["【剑士】罗罗诺亚·索隆", "【航海士】娜美", "【狙击手】乌索普", "【厨师】香吉士", "【船医】托尼托尼·乔巴", "【船匠】 弗兰奇", "【音乐家】布鲁克", "【考古学家】妮可·罗宾"]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
