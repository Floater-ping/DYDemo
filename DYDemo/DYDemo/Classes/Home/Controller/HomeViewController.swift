//
//  HomeViewController.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/7/31.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

private let pTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    //MARK:- 懒加载
    private lazy var pageTitleView:PageTitleView = {
        let titleFrame = CGRect(x: 0, y: pStatusBarH+pNavigationBarH, width: pScreenWidth, height: pTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    
    
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 设置ui界面
        setupUI()
    }
    
}


//MARK:- 设置ui界面
private extension HomeViewController {
    
    func setupUI() {
        /// 设置导航栏
        setupNavigationBar()
        
    }
    
    
    private func setupNavigationBar() {
        /// 1.设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        /// 2.设置右侧items
        let size = CGSize(width: 40, height: 40)
        //        let qrcodeItem = UIBarButtonItem.createItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
}
