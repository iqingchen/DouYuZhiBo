//
//  PageTitleView.swift
//  DY
//
//  Created by zhang on 16/11/30.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

private let kScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    //MARK: - 定义属性
    fileprivate var titles : [String]
    
    //MARK: - 懒加载添加属性
    fileprivate var titleLabelArr = [UILabel]()
    fileprivate var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    fileprivate var scrollLine : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.orange
        return lineView
    }()
    
    //MARK: - 自定义构造函数
    init(frame : CGRect, titlesArr : [String]) {
        self.titles = titlesArr
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置UI界面
extension PageTitleView {
    fileprivate func setupUI() {
        //1.添加scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加label
        setLabels()
        
        //3.设置底线和滚动滑块
        setBottomLineAndScrolline()
        
    }
    fileprivate func setLabels() {
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1.创建label
            let label = UILabel()
            //2.添加属性
            label.text = title
            label.tag = index
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            
            //3.设置label的frame
            let labelX : CGFloat = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabelArr.append(label)
        }
    }
    fileprivate func setBottomLineAndScrolline() {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let bottomH : CGFloat = 0.5
        let bottomY : CGFloat = frame.height - bottomH
        bottomLine.frame = CGRect(x: 0, y: bottomY, width: frame.width, height: bottomH)
        addSubview(bottomLine)
        
        //获取第一个label
        guard let firstLabel = titleLabelArr.first else {return}
        firstLabel.textColor = UIColor.orange
        
        //添加滑块
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}
