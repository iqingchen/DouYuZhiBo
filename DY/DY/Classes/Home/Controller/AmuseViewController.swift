//
//  AmuseViewController.swift
//  DY
//
//  Created by zhang on 16/12/6.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kItemSpace : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemSpace) * 0.5
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50


private let kNormalCellID : String = "kNormalCellID"
private let kReusableViewHeadID : String = "kReusableViewHeadID"

class AmuseViewController: UIViewController {

    //MARK: - 懒加载
    fileprivate lazy var amuseViewModel : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemSpace, 0, kItemSpace)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemSpace
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kReusableViewHeadID)
        return collectionView
        }()
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置ui
        setupUI()
        //请求数据
        loadData()
    }
}

//MARK: - 设置UI
extension AmuseViewController {
    fileprivate func setupUI() {
        //1.添加collectionView
         view.addSubview(collectionView)
    }
}
//MARK: - 请求娱乐数据
extension AmuseViewController {
    fileprivate func loadData() {
        amuseViewModel.loadAmuseData { 
            self.collectionView.reloadData()
        }
    }
}

//MARK: - 实现collectionView的数据源协议
extension AmuseViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseViewModel.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseViewModel.anchorGroups[section].anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        cell.anchor = amuseViewModel.anchorGroups[indexPath.section].anchors[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kReusableViewHeadID, for: indexPath) as! CollectionHeaderView
        header.group = amuseViewModel.anchorGroups[indexPath.section]
        return header
    }
}
