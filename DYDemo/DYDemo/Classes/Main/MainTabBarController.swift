//
//  MainTabBarController.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/7/31.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControler(storyName: "Home")
        addChildViewControler(storyName: "Live")
        addChildViewControler(storyName: "Follow")
        addChildViewControler(storyName: "Profile")
        
    }

    private func addChildViewControler(storyName:String) {
        /// 通过storyboard获取控制器
        let homeVC = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()!
        /// 将childvc做为子控制器
        addChildViewController(homeVC)
    }

  

}
