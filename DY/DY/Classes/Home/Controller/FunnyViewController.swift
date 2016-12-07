//
//  FunnyViewController.swift
//  DY
//
//  Created by zhang on 16/12/7.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class FunnyViewController: BaseAnchorViewController {
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
    }
}

//MARK: - 网络请求
extension FunnyViewController {
    override func loadData() {
        baseVM = funnyVM
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            //数据请求完成
            self.loadDataFinished()
        }
    }
}

