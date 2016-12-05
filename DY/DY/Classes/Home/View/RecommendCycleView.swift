//
//  RecommendCycleView.swift
//  DY
//
//  Created by zhang on 16/12/5.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

//MARK: - 设置常量
private let cycleViewCell : String = "cycleViewCell"

class RecommendCycleView: UIView {
    
    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        //注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cycleViewCell)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.scrollDirection = .vertical
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.red
    }
}

//MARK: - 提供一个快速创建View的类方法
extension RecommendCycleView {
    class func createRecommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK: - 实现collectionView的代理方法
extension RecommendCycleView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cycleViewCell, for: indexPath)
        return cell
    }
}
