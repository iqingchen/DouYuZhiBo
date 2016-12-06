//
//  RecommendViewModel.swift
//  DY
//
//  Created by zhang on 16/12/2.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel{
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
    
}

//MARK: - 发送网络请求
extension RecommendViewModel {
    //请求推荐数据
    func requestData(_ finishCallback: @escaping ()->())  {
        //1.定义参数
        let para : [String : Any] = ["limit":4, "offset":0, "time":Date.getCurrentTime()]
        
        //2.创建Group
        let dGroup = DispatchGroup()
        
        //请求第一部分数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time":Date.getCurrentTime()]){(result) in
            //1.将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else{return}
            //2.根据data该key，获取数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else {return}
            
            //3.字典转模型
            //3.1设置组的属性
            self.bigDataGroup.icon_name = "home_header_hot"
            self.bigDataGroup.tag_name = "热门"
            //3.2获取主播数据
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }

        //请求第二部分数据
        dGroup.enter()
        NetworkTools.requestData(type: .GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: para){(result) in
            //1.将result转成字典类型
            guard let resultDic = result as? [String : NSObject] else{return}
            //2.根据data该key，获取数组
            guard let dataArr = resultDic["data"] as? [[String : NSObject]] else {return}
            
            //3.字典转模型
            //3.1设置组的属性
            self.prettyGroup.icon_name = "home_header_phone"
            self.prettyGroup.tag_name = "颜值"
            //3.2获取主播数据
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()
        }
        
        //请求第2-12部分数据
        dGroup.enter()
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate"){
            dGroup.leave()
        }
        
        //判断所有数据都请求到
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    //请求无限轮播的数据
    func requestCycleData(_ finishCallback: @escaping ()->()) {
        NetworkTools.requestData(type: .GET, urlString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]){(result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict as [NSString : NSObject]))
            }
    
            finishCallback()
        }
    }
    
}
