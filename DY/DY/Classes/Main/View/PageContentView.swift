//
//  PageContentView.swift
//  DY
//
//  Created by zhang on 16/11/30.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

//MARK: - 定义代理方法
protocol PageContentViewDelegate: class {
    func pageContentViewWithScroll(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

//MARK: - 定义常量
private let collectionIdentifier : String = "childsVcCell"

//MARK: - 定义PageContentView类
class PageContentView: UIView {
    //MARK: - 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate var startScrollViewX : CGFloat = 0
    fileprivate weak var parentViewControll : UIViewController?
    fileprivate var isForbidScroll : Bool = false
    weak var delegate: PageContentViewDelegate?
    
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
        collectionView.delegate = self
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

//MARK: - 实现scrollview的代理方法
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScroll = false
        startScrollViewX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScroll == true {return}
        
        //1.定义需要获取的函数
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //2.判断是左滑还是右滑
        let scrollOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if scrollOffsetX > startScrollViewX {
            //左滑
            progress = scrollOffsetX / scrollViewW - floor(scrollOffsetX / scrollViewW)
            sourceIndex = Int(scrollOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            //预防越界
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //全部滑过去progress为1
            if scrollOffsetX - startScrollViewX == scrollViewW  {
                progress = 1
                targetIndex = sourceIndex
            }
        }else {
            //右滑
            progress = 1 - (scrollOffsetX / scrollViewW - floor(scrollOffsetX / scrollViewW))
            targetIndex = Int(scrollOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            //预防越界
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        //3.将progress／sourceIndex／targetIndex传递出去
        delegate?.pageContentViewWithScroll(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK: - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        isForbidScroll = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

