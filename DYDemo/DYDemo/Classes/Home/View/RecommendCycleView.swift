//
//  RecommendCycleView.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/9.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit
fileprivate let pCycleCellID = "pCycleCellID"

class RecommendCycleView: UIView {
    //MARK:- 定义属性
    var cycleTimer : Timer?
    var cycleModelArr : [CycleModel]? {
        didSet {
            // 1.刷新表格
            collectionView.reloadData()
            
            // 2设置pageControl的个数
            pageControl.numberOfPages = cycleModelArr?.count ?? 0
            
            // 3.默认滚动到中间的位置
            let indexPath = NSIndexPath(item: (cycleModelArr?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            // 4.添加定时器
            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    
    
    
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        // 注册cell
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: pCycleCellID)
    }
    
    override func layoutSubviews() {
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
    
    
}
//MARK:- 快速创建方法
extension RecommendCycleView {
    
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK:- UICollectionViewDataSource
extension RecommendCycleView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModelArr?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pCycleCellID, for: indexPath) as! CollectionCycleCell
        let cycleModle = cycleModelArr![indexPath.item % cycleModelArr!.count]
        cell.cycleModel = cycleModle
        return cell
        
    }
    
}

//MARK:- UICollectionViewDelegate
extension RecommendCycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动偏移量 +scrollView.bounds.width * 0.5:滚动到一半的时候就变
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModelArr?.count ?? 1)
        
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        addCycleTimer()
    }
    
}


//MARK:- 对定时器的操作方法
extension RecommendCycleView {
    
    /// 创建定时器
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
        
        
    }
    
    /// 移除定时器
    fileprivate  func removeCycleTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}


