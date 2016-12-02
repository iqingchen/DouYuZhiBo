//
//  PageTitleView.swift
//  DY
//
//  Created by zhang on 16/11/30.
//  Copyright © 2016年 zhang. All rights reserved.
//

import UIKit

//MARK: - 定义代理方法
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, selectedIndex index:Int)
}

//MARK: - 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    //MARK: - 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex:Int = 0
    weak var delegate:PageTitleViewDelegate?
    
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            
            //3.设置label的frame
            let labelX : CGFloat = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabelArr.append(label)
            //4.添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapClick(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    fileprivate func setBottomLineAndScrolline() {
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        let bottomH : CGFloat = 0.5
        let bottomY : CGFloat = frame.height - bottomH
        bottomLine.frame = CGRect(x: 0, y: bottomY, width: frame.width, height: bottomH)
        addSubview(bottomLine)
        
        //获取第一个label
        guard let firstLabel = titleLabelArr.first else {return}
        firstLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        //添加滑块
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK: - 事件处理
extension PageTitleView {
    @objc fileprivate func labelTapClick(tap: UITapGestureRecognizer) {
        //1.取消原来label的选中
        let oldLabel = titleLabelArr[currentIndex]
        oldLabel.textColor = UIColor.darkGray
        
        //2.设置新点击的label选中
        guard let newLabel = tap.view as? UILabel else{return}
        if newLabel.tag == currentIndex {return}
        newLabel.textColor = UIColor.orange
        currentIndex = newLabel.tag
        
        //3.滑线滚动到对应的位置
        let scrollLineX = CGFloat(newLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //4.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//MARK: - 暴露给外界的接口
extension PageTitleView {
    func setTitleWithProgres(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //1.取出原来的label和目标的label
        let sourceLabel = titleLabelArr[sourceIndex]
        let targetLabel = titleLabelArr[targetIndex]
        
        //2.修改滑块的位置
        let scrollLineTotalChangeX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let alreadyChangeX = scrollLineTotalChangeX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + alreadyChangeX
        
        //3.label颜色渐变
        let colorRange = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorRange.0 * progress, g: kSelectedColor.1 - colorRange.1 * progress, b: kSelectedColor.2 - colorRange.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorRange.0 * progress, g: kNormalColor.1 + colorRange.1 * progress, b: kNormalColor.2 + colorRange.2 * progress)
        //4.记录最新的index
        currentIndex = targetIndex
    }
}
