//
//  AnchorModel.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/7.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    /// 房间号
    var room_id : Int = 0
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播：0:电脑直播   1:手机直播
    //    var isVertical : Bool = false
    var isVertical : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 在线人数
    var online : Int = 0
    /// 所在城市
    var anchor_city : String = ""
    
    init(dict : [String : Any]) {
        super.init()
//                room_id = dict["room_id"] as! Int
//                vertical_src = dict["vertical_src"] as! String
//                isVertical = dict["isVertical"] as! Int
//                room_name = dict["room_name"] as! String
//                nickname = dict["nickname"] as! String
//                online = dict["online"] as! Int
//                if (dict["nicknanchor_cityame"] != nil) {
//        
//                    nickname = dict["nicknanchor_cityame"] as! String
//                }
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {}
    
    
}
