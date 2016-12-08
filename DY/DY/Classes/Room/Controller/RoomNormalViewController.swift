//
//  RoomNormalViewController.swift
//  DY
//
//  Created by zhang on 16/12/8.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController{
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        //依然保持手势
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //显示导航栏
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
