//
//  CollectionPrettyCell.swift
//  DY
//
//  Created by zhang on 16/12/1.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var cityNameBtn: UIButton!
    
    override var anchor : AnchorModel? {
        didSet {
            super.anchor = anchor
            // 1.设置城市的显示
            cityNameBtn.setTitle(anchor?.anchor_city, for: .normal)
    
        }
    }

}
