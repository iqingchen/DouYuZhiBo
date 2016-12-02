//
//  RecommendViewModel.swift
//  DY
//
//  Created by zhang on 16/12/2.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class RecommendViewModel {
    fileprivate lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

//MARK: - 发送网络请求
extension RecommendViewModel {
    //请求第一部分数据
    
    //请求第二部分数据
    
    //请求第2-12部分数据
    func requsetData()  {
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["limit":4, "offset":0, "time":Date.getCurrentTime()] ) {(result) in
            //1.将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else{return}
            //2.根据data该key，获取数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else {return}
            //3.遍历数组，获取字典，并将字典转成模型对象
            for dic in dataArr {
                let group = AnchorGroup(dict: dic)
                self.anchorGroups.append(group)
            }
            for group in self.anchorGroups {
                for anchor in group.anchors{
                    print("\(anchor.nickname)")
                }
                print("----------")
            }
        }
    }
    
}
