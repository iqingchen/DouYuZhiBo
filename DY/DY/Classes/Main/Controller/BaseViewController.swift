//
//  BaseViewController.swift
//  DY
//
//  Created by zhang on 16/12/6.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var contentView : UIView?
    
    fileprivate lazy var animImageView : UIImageView = {[unowned self] in
        let animImageV = UIImageView(image: UIImage(named: "img_loading_1"))
        animImageV.center = self.view.center
        animImageV.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        animImageV.animationDuration = 0.5
        animImageV.animationRepeatCount = LONG_MAX
        animImageV.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return animImageV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: - 设置UI
extension BaseViewController {
    func setupUI() {
        contentView?.isHidden = true
        //添加加载动画
        view.addSubview(animImageView)
        //执行动画
        animImageView.startAnimating()
        //背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    func loadDataFinished() {
        // 1.停止动画
        animImageView.stopAnimating()
        
        // 2.隐藏animImageView
        animImageView.isHidden = true
        
        // 3.显示内容的View
        contentView?.isHidden = false
    }
}

