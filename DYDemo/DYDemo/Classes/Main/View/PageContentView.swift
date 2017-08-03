//
//  PageContentView.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/3.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

fileprivate let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    //MARK:- 定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    
    
    //MARK:- 懒加载属性
     fileprivate lazy var collectionView:UICollectionView = {[weak self] in
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        /// 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionView;
    }()
    
    
    
    init(frame : CGRect,childVCs : [UIViewController],parentViewController : UIViewController?) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        // 设置UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置ui界面
extension PageContentView {
    fileprivate func setUpUI(){
    // 1.将所有的自控制器添加到父控制器中
        for childvc in childVCs {
        
            parentViewController?.addChildViewController(childvc)
        }
        
        // 2.添加一个UICollectionView，用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
        
        
    }
}

//MARK:- UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        // 2.给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVCs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
        
    }
}


//MARK:- UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滚动处理
//        let currentOffsetX = scrollView.contentOffset.x
//        let scrollViewW = scrollView.bounds.width
//        if currentOffsetX >  {
//            <#code#>
//        }
        
        
    }
    

    
}


//MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        
    }
}
