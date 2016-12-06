//
//  RecommendGameView.swift
//  DY
//
//  Created by zhang on 16/12/5.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kGameViewCell : String = "kGameViewCell"

class RecommendGameView: UIView {
    //MARK: - 定义属性
    var baseGameModel : [BaseGameModel]?{
        didSet{
            //刷新
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //1.设置不随着父空间缩小而缩小
        autoresizingMask = UIViewAutoresizing()
        //2.注册cell
        collectionView.register(UINib.init(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCell)
        collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5)
    }
}

//MARK: - 提供一个快速创建的类方法
extension RecommendGameView {
    class func createRecommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//MARK: - 实现collectionView的数据源方法
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return baseGameModel?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCell, for: indexPath) as! CollectionGameCell
        cell.baseGame = baseGameModel![indexPath.row]
        return cell
    }
}
