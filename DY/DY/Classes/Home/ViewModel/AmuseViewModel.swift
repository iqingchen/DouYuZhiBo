//
//  AmuseViewModel.swift
//  DY
//
//  Created by zhang on 16/12/6.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel {
}

//MARK: - 请求娱乐数据
extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping ()->()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
