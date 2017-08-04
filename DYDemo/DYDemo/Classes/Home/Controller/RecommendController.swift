//
//  RecommendController.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/4.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

//MARK:- 定义常量
fileprivate let pItemMargin : CGFloat = 10
fileprivate let pItemW : CGFloat = (pScreenWidth - pItemMargin * 3) / 2
fileprivate let pItemH : CGFloat = pItemW * 3 / 4
fileprivate let pHeaderViewH : CGFloat = 50

fileprivate let pNormalCellID = "pNormalCellID"
fileprivate let pHeaderViewID = "pHeaderViewID"



class RecommendController: UIViewController {
    //MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
      
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: pItemW, height: pItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = pItemMargin
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: pScreenWidth, height: pHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        // 注册头部
         collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: pHeaderViewID)
        /// 注册cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: pNormalCellID)
        // 设置大小随父控件拉伸
         collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView;
        
    }()
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI页面
        setUpUI()
   
    }
    
}

//MARK:- 设置UI页面的内容
extension RecommendController {
    
    fileprivate func setUpUI(){
        
        view.addSubview(collectionView)
        
    }
}

//MARK:- UICollectionViewDataSource
extension RecommendController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pNormalCellID, for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerV = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: pHeaderViewID, for: indexPath)
        headerV.backgroundColor = UIColor.darkGray
        return headerV
    }
    
  
}
