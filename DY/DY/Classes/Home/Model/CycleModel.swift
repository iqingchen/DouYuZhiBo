//
//  CycleModel.swift
//  DY
//
//  Created by zhang on 16/12/5.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    var title : String = ""
    // 展示的图片地址
    var pic_url : String = ""
    // 主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else  { return }
            anchor = AnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor : AnchorModel?
    
    // 自定义构造函数
    init(dict: [NSString : NSObject]) {
        super.init()
        setValuesForKeys(dict as [String : Any])
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
