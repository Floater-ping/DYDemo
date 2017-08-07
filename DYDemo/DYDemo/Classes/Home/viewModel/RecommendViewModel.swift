//
//  RecommendViewModel.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/7.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class RecommendViewModel {
    
}
//MARK:- 发送网络请求
extension RecommendViewModel {

     func requestData() {
        HttpTools.requestData(.GET, URLString: "http://testadmin2017.51toc.net/MemberBusApi/getCard") { (result) in
            print(result)
        }
        
        
    }
}
