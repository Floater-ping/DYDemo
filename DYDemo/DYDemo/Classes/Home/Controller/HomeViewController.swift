//
//  HomeViewController.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/7/31.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

fileprivate let pTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    //MARK:- 懒加载
    fileprivate lazy var pageTitleView:PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: pStatusBarH+pNavigationBarH, width: pScreenWidth, height: pTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        let contentY = pStatusBarH + pNavigationBarH + pTitleViewH
        let contentH = pScreenHeight - contentY
        let contentFrame = CGRect(x: 0, y: contentY, width: pScreenWidth, height: contentH)
        
        var childVCArr = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCArr.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCArr, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        /// 1.设置ui界面
        setupUI()
        
        /// 2.设置titleview
        view.addSubview(pageTitleView)
        
        /// 3.添加pageContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.orange
        
    }
    
}


//MARK:- 设置ui界面
extension HomeViewController {
    
    fileprivate func setupUI() {
        /// 不需要调整scrollview的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        /// 设置导航栏
        setupNavigationBar()
        
    }
    
    
    fileprivate func setupNavigationBar() {
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

//MARK:- PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
        
    }
    
}

//MARK:- PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {

    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

