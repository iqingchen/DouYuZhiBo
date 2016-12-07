//
//  FunnyViewModel.swift
//  DY
//
//  Created by zhang on 16/12/7.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {
    
}
extension FunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
