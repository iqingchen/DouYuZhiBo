//
//  AmuseViewController.swift
//  DY
//
//  Created by zhang on 16/12/6.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class AmuseViewController: BaseAnchorViewController {
    //MARK: - 懒加载属性
    fileprivate lazy var anumseViewModel : AmuseViewModel = AmuseViewModel()
    
}
//MARK: - 设置UI
extension AmuseViewController {
    
}

//MARK: - 请求数据
extension AmuseViewController {
    override func loadData() {
        //1.给父类ViewModel赋值
        baseVM = anumseViewModel
        //2.请求数据
        anumseViewModel.loadAmuseData { 
              self.collectionView.reloadData()
        }
    }
}


