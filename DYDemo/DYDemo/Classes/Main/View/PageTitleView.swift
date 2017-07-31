//
//  PageTitleView.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/7/31.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    //MARK:-  定义属性
    private var titles: [String]
    
    //MARK:- 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame:frame)
    }
    
    
    
    
    /// 自定义或者重写构造函数必须重写该方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    

}
