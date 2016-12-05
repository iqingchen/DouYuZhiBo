//
//  CollectionNormalCell.swift
//  DY
//
//  Created by zhang on 16/12/1.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLabel: UILabel!

    override var anchor : AnchorModel? {
        didSet {
            // 1.将属性传给父类
            super.anchor = anchor
            // 2.房间名的显示
            roomNameLabel.text = anchor?.room_name
        }
    }

}
