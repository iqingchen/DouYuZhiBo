//
//  AnchorGroup.swift
//  DY
//
//  Created by zhang on 16/12/2.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet{
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    
    ///定义主播模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    /*
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArr = value as? [[String : NSObject]] {
                for dic in dataArr {
                    anchors.append(AnchorModel(dict: dic))
                }
            }
        }
    }*/
}
