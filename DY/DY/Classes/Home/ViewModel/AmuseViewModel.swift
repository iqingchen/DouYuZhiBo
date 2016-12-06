//
//  AmuseViewModel.swift
//  DY
//
//  Created by zhang on 16/12/6.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

//MARK: - 请求娱乐数据
extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping ()->()) {
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2"){(result) in
            // 1.获取数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 2.字典转模型
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            // 3.回调数据
            finishedCallback()
        }
    }
}
