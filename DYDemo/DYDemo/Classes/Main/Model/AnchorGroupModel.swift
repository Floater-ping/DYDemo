//
//  AnchorGroupModel.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/7.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class AnchorGroupModel: NSObject {
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let roomList = room_list else {
                return
            }
            
            for dict in roomList {
                let archor = AnchorModel(dict: dict)
                self.anchorArr.append(archor)
            }
        
            
        }
    }
    /// 组显示的标题
    var tag_name : String = ""
    /// 组显示的图标
    var icon_url : String = "home_header_normal"
    
    /// 定义主播模型对象数组 --- 该组中对应的房间信息
    lazy var anchorArr : [AnchorModel] = [AnchorModel]()
    
    override init() {
        
    }
    
    init(dict : [String : NSObject]) {
    
        super.init()
        tag_name = dict["tag_name"] as! String
        icon_url = dict["icon_url"] as! String
        room_list = dict["room_list"] as? [[String : NSObject]]
//        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {}
    
    
}
