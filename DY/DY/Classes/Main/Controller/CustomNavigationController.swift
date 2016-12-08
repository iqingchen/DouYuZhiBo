//
//  CustomNavigationController.swift
//  DY
//
//  Created by zhang on 16/12/8.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
