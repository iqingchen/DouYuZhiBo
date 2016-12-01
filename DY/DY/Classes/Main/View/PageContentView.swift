//
//  PageContentView.swift
//  DY
//
//  Created by zhang on 16/11/30.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

private let collectionIdentifier : String = "childsVcCell"
class PageContentView: UIView {
    //MARK: - 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewControll : UIViewController?
    
    //MARK: - 懒加载控件
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionIdentifier)
        return collectionView
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentsViewControll: UIViewController?) {
        self.childVcs = childVcs
        parentViewControll = parentsViewControll
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置UI界面
extension PageContentView {
    fileprivate func setupUI() {
        //1.添加子控制自控制器到父控制器中
        for child in childVcs {
            parentViewControll?.addChildViewController(child)
        }
        
        //2.添加UICollectionView,用于在cell中存放控制器view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: - 设置collectionView的代理
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionIdentifier, for: indexPath)
        //清除之前添加的view
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        //设置cell属性
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
