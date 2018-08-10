//
//  PowerListView.swift
//  JXPagingView
//
//  Created by jiaxin on 2018/5/29.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class PowerListView: TestListBaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        dataSource = ["橡胶火箭", "橡胶火箭炮", "橡胶机关枪", "橡胶子弹", "橡胶攻城炮", "橡胶象枪", "橡胶象枪乱打", "橡胶灰熊铳", "橡胶雷神象枪", "橡胶猿王枪", "橡胶犀·榴弹炮", "橡胶大蛇炮", "橡胶火箭", "橡胶火箭炮", "橡胶机关枪", "橡胶子弹", "橡胶攻城炮", "橡胶象枪", "橡胶象枪乱打", "橡胶灰熊铳", "橡胶雷神象枪", "橡胶猿王枪", "橡胶犀·榴弹炮", "橡胶大蛇炮"]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
