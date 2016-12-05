//
//  CollectionNormalCell.swift
//  DY
//
//  Created by zhang on 16/12/1.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNameLabel: UILabel!

    var anchor : AnchorModel? {
        didSet {
            // 0.校验模型是否有值
            guard let anchor = anchor else {return}
            // 1.在线人数显示文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            roomNameLabel.text = anchor.room_name
            // 3.设置封面图片
            guard let iconUrl = URL(string: anchor.vertical_src) else {return}
            iconImageView.kf.setImage(with: iconUrl)
        }
    }

}
