//
//  AnchorGroup.swift
//  DY
//
//  Created by zhang on 16/12/2.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet{
            guard let room_list = room_list else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    /// 该组显示的标题
    var tag_name : String = ""
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 分组图片
    var icon_url : String = ""
    
    ///定义主播模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
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
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
