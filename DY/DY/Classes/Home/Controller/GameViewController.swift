//
//  GameViewController.swift
//  DY
//
//  Created by zhang on 16/12/6.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50

private let kGameViewH : CGFloat = 90

private let kGameCellID : String = "kGameCellID"
private let kReusableViewHeadID : String = "kReusableViewHeadID"

class GameViewController: BaseViewController {
    //MARK: - 懒加载
    fileprivate lazy var gameViewModel : GameViewModel = GameViewModel()
    fileprivate lazy var commonHeaderView : CollectionHeaderView = {
        let header = CollectionHeaderView.collectionHeaderView()
        header.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        header.titleLabel.text = "常见"
        header.iconImageView.image = UIImage(named: "Img_orange")
        header.moreBtn.isHidden = true
        return header
    }()
    fileprivate lazy var recommendGameView : RecommendGameView = {
        let gameView = RecommendGameView.createRecommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgeMargin, 0, kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kReusableViewHeadID)
        return collectionView
        }()
    
    //MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置ui
        setupUI()
        
        //网络请求
        requestData()
    }
}

//MARK: - 设置UI
extension GameViewController {
    override func setupUI() {
        contentView = collectionView
        
        //添加collectionView
        view.addSubview(collectionView)
        //添加常见header
        collectionView.addSubview(commonHeaderView)
        //添加常见游戏View
        collectionView.addSubview(recommendGameView)
        
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewH + kGameViewH, 0, 0, 0)
        
        super.setupUI()
    }
}

//MARK: - 网络请求
extension GameViewController {
    fileprivate func requestData()  {
        gameViewModel.loadAllGanmesData {
            //1.刷新表格
            self.collectionView.reloadData()
            //2.讲数据传给recommendGameView
            self.recommendGameView.baseGameModel = Array(self.gameViewModel.games[0..<10])
            
            //数据请求完成
            self.loadDataFinished()
        }
    }
}

//MARK: - 实现collectionView的数据源方法
extension GameViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.baseGame = gameViewModel.games[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kReusableViewHeadID, for: indexPath) as! CollectionHeaderView
        let group = AnchorGroup()
        group.tag_name = "全部"
        group.icon_name = "Img_orange"
        header.group = group
        header.moreBtn.isHidden = true
        return header
    }
}
