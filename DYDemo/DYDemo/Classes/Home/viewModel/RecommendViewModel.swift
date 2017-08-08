//
//  RecommendViewModel.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/7.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroupArr : [AnchorGroupModel] = [AnchorGroupModel]()
    fileprivate lazy var bigDataGroup : AnchorGroupModel = AnchorGroupModel()
    fileprivate lazy var prettyGroup : AnchorGroupModel = AnchorGroupModel()
    
}
//MARK:- 发送网络请求
extension RecommendViewModel {
    
    func requestData(finishedCallBack : @escaping () -> ()) {
        let parameters = ["limit" : "4","offset" : "0","time" : NSDate.getCurrentTime()]
        
        // 创建组
        let dispathgroup = DispatchGroup()
        // 进入组
        dispathgroup.enter()
        
        /// 1.请求第一部分推荐数据
        HttpTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let dataArr = resultDict["data"] as? [[String : Any]] else { return }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_url = "home_header_hot"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchorArr.append(anchor)
                
            }
            // 离开组
            dispathgroup.leave()
            
        }
        
        
        dispathgroup.enter()
        /// 3.组请求第二部分颜值数据
        HttpTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else {
                return
            }
            
            guard let dataArr = resultDict["data"] as? [[String : Any]] else {
                return
            }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_url = "home_header_phone"
            for dict in dataArr {
                
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchorArr.append(anchor)
                
            }
            dispathgroup.leave()
        }
        
        dispathgroup.enter()
        /// 3.2-10请求游戏数据
        HttpTools.requestData(.GET, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate",parameters: parameters) { (result) in
            
            // 1.转化成字段模型
            guard let resultDict = result as? [String : Any] else {
                return
            }
            // 2.获取数组
            guard let dateArr = resultDict["data"] as? [[String : Any]] else {
                return
            }
            
            // 3.遍历数组，获取字典，并且将字典转成模型对象
            for dict in dateArr {
                let group = AnchorGroupModel(dict: dict)
                self.anchorGroupArr.append(group)
                
            }
            
            dispathgroup.leave()
        }
        
        
        /// 所有的数据都请求结束
        dispathgroup.notify(queue: DispatchQueue.main) {
            self.anchorGroupArr.insert(self.prettyGroup, at: 0)
            self.anchorGroupArr.insert(self.bigDataGroup, at: 0)
            finishedCallBack()
            
        }
        
        
    }
}
