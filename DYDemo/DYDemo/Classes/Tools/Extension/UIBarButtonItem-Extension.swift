//
//  UIBarButtonItem-Extension.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/7/31.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /**
     /// 类方法
     class func createItem(imageName:String,highImageName : String,size : CGSize) -> UIBarButtonItem {
     let btn = UIButton()
     btn.setImage(UIImage.init(named: imageName), for: .normal)
     btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
     btn.frame = CGRect(origin: CGPoint(), size: size)
     return UIBarButtonItem(customView: btn);
     }
     */
    
    /**
     便利构造函数:推荐使用
     1:convenience 开头
     2:在构造函数中必须明确调用一个设计的构造函数（self调用）
     */
    convenience init(imageName:String,highImageName : String = "",size : CGSize = CGSize()) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        }
        if size == CGSize() {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint(), size: size)
        }
        self.init(customView:btn)
    }
    
    
}
