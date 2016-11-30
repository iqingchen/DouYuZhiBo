//
//  HomeViewController.swift
//  DY
//
//  Created by zhang on 16/11/30.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
    }

}

//MARK - 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        //设置导航条
        setupNavigationBar()
    }
    
    fileprivate func setupNavigationBar() {
        let logoBtn = UIButton()
        logoBtn.setImage(UIImage(named: "logo"), for: .normal)
        logoBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoBtn)
        
        //设置左边按钮
        let size = CGSize(width: 40, height: 40)

        let historyItem = UIBarButtonItem(image: "image_my_history", highlightImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(image: "btn_search", highlightImage: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(image: "Image_scan", highlightImage: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
}
