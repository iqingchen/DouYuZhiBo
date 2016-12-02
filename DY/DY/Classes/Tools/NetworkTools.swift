//
//  NetworkTools.swift
//  DY
//
//  Created by zhang on 16/12/2.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    
}

//MARK: - 封装请求方法
extension NetworkTools {
    class func requestData(type: MethodType, urlString: String, parameters: [String : Any]? = nil, finishCallback: @escaping (_ result: Any)->()) {
        //判断请求方式
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        //发送请求，并且讲请求到的数据回调
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else{
                print(response.result.error)
                return
            }
            finishCallback(result)
        }
    }
}
