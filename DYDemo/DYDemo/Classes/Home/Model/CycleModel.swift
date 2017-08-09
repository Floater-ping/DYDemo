//
//  CycleModel.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/9.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    /// 标题
    var title : String = ""
     /// 图片地址
    var  pic_url : String = ""
    /// 主播信息对应的字典
    var room : [String : Any]? {
        didSet {
        
            guard let room = room else {
                return
            }
            
            anchor = AnchorModel(dict: room)
            
        }
    }
    /// 主播信息对应的模型对象
    var anchor : AnchorModel?
    
    /// 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    

    

}
