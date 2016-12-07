//
//  AmuseMenuView.swift
//  DY
//
//  Created by zhang on 16/12/7.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

private let kAmuseMenuCell = "kAmuseMenuCell"
class AmuseMenuView: UIView {
    //设置属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.isPagingEnabled = true
        
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseMenuCell)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}

//MARK: - 提供快速创建的方法
extension AmuseMenuView {
    class func createAmuseMenu() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

//MARK: - 实现collectionView的数据源方法
extension AmuseMenuView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseMenuCell, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension AmuseMenuView : UICollectionViewDelegate {
    
}
