//
//  RecommendGameView.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/9.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class RecommendGameView: UIView {

   

}

//MARK:- 快速创建方法
extension RecommendGameView {
    
    class func recommendCycleView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}
