//
//  RecommendViewController.swift
//  DY
//
//  Created by zhang on 16/12/1.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kItemSpace : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3 * kItemSpace) * 0.5
private let kNormalItemH : CGFloat = kItemW * 3 / 4
private let kHeaderViewH : CGFloat = 50
private let kPrettyItemH : CGFloat = kItemW * 4 / 3

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID : String = "kNormalCellID"
private let kPrettyCellID : String = "kPrettyCellID"
private let kReusableViewHeadID : String = "kReusableViewHeadID"

class RecommendViewController: UIViewController {
    //MARK: - 懒加载
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemSpace, 0, kItemSpace)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemSpace
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kReusableViewHeadID)
        return collectionView
    }()
    fileprivate lazy var recommendCycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.createRecommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kGameViewH + kCycleViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var recommendGameView : RecommendGameView = {
        let gameView = RecommendGameView.createRecommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        //设置UI
        setupUI()
        //网络请求
        loadData()
    }
}

//MARK: - 设置UI界面
extension RecommendViewController {
    fileprivate func setupUI() {
        //添加collectionView
        view.addSubview(collectionView)
        //添加无限轮播
        collectionView.addSubview(recommendCycleView)
        //添加游戏推荐
        collectionView.addSubview(recommendGameView)
        
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
}

//MARK: - 实现collectionView的datasource代理方法
extension RecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CollectionBaseCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kReusableViewHeadID, for: indexPath) as! CollectionHeaderView
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}

//MARK: - 网络请求
extension RecommendViewController {
    func loadData() {
        //请求视频数据
        recommendVM.requestData {
            self.collectionView.reloadData()
            //将数据传给gameView
            //移除前两组
            var anchorGroup = self.recommendVM.anchorGroups
            anchorGroup.removeFirst()
            anchorGroup.removeFirst()
            //添加更多这一组
            let group = AnchorGroup()
            group.tag_name = "更多"
            anchorGroup.append(group)
            self.recommendGameView.baseGameModel = anchorGroup
        }
        //请求无限轮播的数据
        recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}
