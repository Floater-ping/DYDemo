//
//  HttpTools.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/7.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit
import Alamofire

enum PMethodType {
    case GET
    case POST
}


class HttpTools {

    class func requestData(_ type : PMethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        // 1. 获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
    
    
}
