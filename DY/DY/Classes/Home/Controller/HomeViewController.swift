//
//  HomeViewController.swift
//  DY
//
//  Created by zhang on 16/11/30.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit


private let kPageTitleH : CGFloat = 40
class HomeViewController: UIViewController {
    //MARK: - 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let rect = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kPageTitleH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleV = PageTitleView(frame: rect, titlesArr: titles)
        pageTitleV.delegate = self
        return pageTitleV
    }()
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        //1.确定contentView的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kPageTitleH - kTabbarH
        let rect = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kPageTitleH, width: kScreenW, height: contentH )
        //2.子控制器
        var childVcs = [UIViewController]()
        let recommondVC = RecommendViewController()
        childVcs.append(recommondVC)
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame:rect , childVcs: childVcs, parentsViewControll: self)
        contentView.delegate = self
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
    }

}

//MARK: - 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        //设置导航条
        setupNavigationBar()
        
        //添加pageTitleView
        view.addSubview(pageTitleView)
        
        //添加pageContentView
        view.addSubview(pageContentView)
    }
    
    //MARK: - 设置导航栏
    fileprivate func setupNavigationBar() {
        let logoBtn = UIButton()
        logoBtn.setImage(UIImage(named: "logo"), for: .normal)
        logoBtn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoBtn)
        
        //设置左边按钮
        let size = CGSize(width: 40, height: 40)

        let historyItem = UIBarButtonItem(image: "image_my_history", highlightImage: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(image: "btn_search", highlightImage: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(image: "Image_scan", highlightImage: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
    
}

//MARK: - 遵守PageTitleView的协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK: - 遵守PageContentView的协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentViewWithScroll(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgres(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
