//
//  PageContentView.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/3.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView,progress : CGFloat,sourceIndex : Int,targetIndex : Int)
}

fileprivate let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    //MARK:- 定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    /// 屏蔽点击时候代理的回调
    fileprivate var isForbidScollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    
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
        collectionView.delegate = self
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScollDelegate = false
          startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScollDelegate {
            return
        }
        
       // 1.获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {
            // 左滑
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count-1
            }
            
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else {
            // 右滑
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    
    
}


//MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        // 记录需要执行代理方法
        isForbidScollDelegate = true
        // 方法一
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
        /*
         // 方法二
         let indexPath : IndexPath = IndexPath(item: currentIndex, section: 0)
         collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: false)
         */
        
        
    }
}
