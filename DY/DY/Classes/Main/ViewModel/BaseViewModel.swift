//
//  BaseViewModel.swift
//  DY
//
//  Created by zhang on 16/12/6.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

//MARK: - 请求数据
extension BaseViewModel {
    func loadAnchorData(URLString: String, parameters: [String : Any]? = nil, finishedCallback:@escaping ()->()) {
        NetworkTools.requestData(type: .GET, urlString: URLString, parameters: parameters){(result) in
            // 1.获取数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            // 2.字典转模型
            for dict in dataArray {
                let group = AnchorGroup(dict: dict)
                if group.anchors.count == 0 {
                    continue
                }
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            // 3.回调数据
            finishedCallback()
        }
    }
}
