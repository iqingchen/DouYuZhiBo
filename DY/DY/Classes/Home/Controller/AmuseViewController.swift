//
//  AmuseViewController.swift
//  DY
//
//  Created by zhang on 16/12/6.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

private let kAmuseMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    //MARK: - 懒加载属性
    fileprivate lazy var anumseViewModel : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var amuseMenuView : AmuseMenuView = {
        let amuseV = AmuseMenuView.createAmuseMenu()
        amuseV.frame = CGRect(x: 0, y: -kAmuseMenuViewH, width: kScreenW, height: kAmuseMenuViewH)
        return amuseV
    }()
    
}
//MARK: - 设置UI
extension AmuseViewController {
    override func setupUI() {
        //调用父类方法
        super.setupUI()
        //添加AmuseMenuView
        collectionView.addSubview(amuseMenuView)
        
        collectionView.contentInset = UIEdgeInsetsMake(kAmuseMenuViewH, 0, 0, 0)
    }
    
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


