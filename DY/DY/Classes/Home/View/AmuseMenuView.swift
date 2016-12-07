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
    
    var anchorGroup : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
        if anchorGroup == nil {return 0}
        let pageNum = (anchorGroup!.count - 1) % 8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseMenuCell, for: indexPath) as! AmuseMenuViewCell
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    private func setupCellDataWithCell(cell : AmuseMenuViewCell, indexPath : IndexPath) {
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15
        // 2也: 16 ~ 23
        // 1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 2.判断越界问题
        if endIndex > anchorGroup!.count - 1 {
            endIndex = anchorGroup!.count - 1
        }
        
        // 3.取出数据,并且赋值给cell
        cell.groups = Array(anchorGroup![startIndex...endIndex])
    }
}

extension AmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offX = scrollView.contentOffset.x / scrollView.bounds.width
        pageControl.currentPage = Int(offX)
    }
}
