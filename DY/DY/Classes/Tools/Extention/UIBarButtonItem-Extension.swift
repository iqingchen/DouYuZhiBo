//
//  UIBarButtonItem-Extension.swift
//  DY
//
//  Created by zhang on 16/11/30.
//  Copyright © 2016年 zhang. All rights reserved.
//


import UIKit

extension UIBarButtonItem {
    /*
     class func createItem(image:String, highlightImage:String, size:CGSize) -> UIBarButtonItem {
     let btn = UIButton()
     btn.setImage(UIImage(named: image), for: .normal)
     btn.setImage(UIImage(named: highlightImage), for: .highlighted)
     btn.frame = CGRect(origin: CGPoint.zero, size: size)
     return UIBarButtonItem(customView: btn)
     }*/
    
    //便利构造函数：1>convenience开头 2>在构造函数中必须明确调用一个设计的构造函数（self）
    convenience init(image:String, highlightImage:String, size:CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named: image), for: .normal)
        btn.setImage(UIImage(named: highlightImage), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        self.init(customView:btn)
    }
}
