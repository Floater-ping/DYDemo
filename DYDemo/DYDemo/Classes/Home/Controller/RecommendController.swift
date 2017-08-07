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
fileprivate let pNormalItemH : CGFloat = pItemW * 3 / 4
fileprivate let pPrettyItemH : CGFloat = pItemW * 4 / 3
fileprivate let pHeaderViewH : CGFloat = 50

fileprivate let pNormalCellID = "pNormalCellID"
fileprivate let pPrettyCellID = "pPrettyCellID"
fileprivate let pHeaderViewID = "pHeaderViewID"



class RecommendController: UIViewController {
    //MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        // 1.创建layout
        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: pItemW, height: pNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = pItemMargin
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: pScreenWidth, height: pHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        // 注册头部
        collectionView.register(UINib(nibName: "HomeCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: pHeaderViewID)
        /// 注册cell
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: pNormalCellID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: pNormalCellID)
        // 颜值cell
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: pPrettyCellID)
        
        // 设置大小随父控件拉伸
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        return collectionView;
        
        }()
    
    
    fileprivate lazy var recomendVM : RecommendViewModel = RecommendViewModel()
    
    
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI页面
        setUpUI()
        loadData()
        
    }
    
}

//MARK:- 设置UI页面的内容
extension RecommendController {
    
    fileprivate func setUpUI(){
        
        view.addSubview(collectionView)
        
    }
}

//MARK:- 网络请求-加载数据
extension RecommendController {
    func loadData() {
    
        recomendVM.requestData {
            self.collectionView.reloadData()
        }
    }
  
}

//MARK:- UICollectionViewDataSource
extension RecommendController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recomendVM.anchorGroupArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       let group = recomendVM.anchorGroupArr[section]
        return group.anchorArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell : UICollectionViewCell
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pPrettyCellID, for: indexPath)
        }else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: pNormalCellID, for: indexPath)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerV = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: pHeaderViewID, for: indexPath) as! HomeCollectionHeaderView
        let group = recomendVM.anchorGroupArr[indexPath.section]
        headerV.groupModel = group
        
        return headerV
    }
    
}

//MARK:- UICollectionViewDelegate
extension RecommendController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: pItemW, height: pPrettyItemH)
        }else {
        
            return CGSize(width: pItemW, height: pNormalItemH)
        }
        
    }

}
