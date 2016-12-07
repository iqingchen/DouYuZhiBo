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

private let kPrettyCellID : String = "kPrettyCellID"

class RecommendViewController: BaseAnchorViewController {
    //MARK: - 懒加载
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    
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
}

//MARK: - 设置UI界面
extension RecommendViewController {
     override func setupUI() {
        //执行父类方法
        super.setupUI()
        
        //添加无限轮播
        collectionView.addSubview(recommendCycleView)
        //添加游戏推荐
        collectionView.addSubview(recommendGameView)
        
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
}

//MARK: - 实现collectionView的datasource代理方法
extension RecommendViewController : UICollectionViewDelegateFlowLayout{
     override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.row]
            return cell
        }else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
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
    override func loadData() {
        baseVM = recommendVM
        
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
            //数据请求完成
            self.loadDataFinished()
        }
        //请求无限轮播的数据
        recommendVM.requestCycleData {
            self.recommendCycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}
