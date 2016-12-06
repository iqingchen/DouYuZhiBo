//
//  GameViewModel.swift
//  DY
//
//  Created by zhang on 16/12/6.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}
//MARK: -  网络请求
extension GameViewModel {
    func loadAllGanmesData(finishedCallback: @escaping ()->()){
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (result) in
            //1.获取数据
            guard let resultDict = result as? [String: Any] else {return}
            guard let dataArr = resultDict["data"] as? [[String: Any]] else {return}
            // 2.字典转模型
            for dict in dataArr {
                self.games.append(GameModel(dict: dict))
            }
            // 3.通知外界数据请求完成
            finishedCallback()
        }
    }

}
