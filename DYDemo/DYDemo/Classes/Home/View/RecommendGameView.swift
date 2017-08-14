//
//  RecommendGameView.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/9.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

fileprivate let pGameCellID = "pGameCellID"

class RecommendGameView: UIView {
    //MARK:- 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- 定义数据的属性
    var groups : [AnchorGroupModel]? {
        
        didSet {
            groups?.removeFirst()
            groups?.removeFirst()
            let moreGroup = AnchorGroupModel()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            collectionView.reloadData()
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        /// 注册cell
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: pGameCellID)
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: pGameCellID)
    }
}

//MARK:- 快速创建方法
extension RecommendGameView {
    
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}


//MARK:- UICollectionViewDelegate
extension RecommendGameView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pGameCellID, for: indexPath) as! GameCollectionCell
        /// 强制解包
        cell.anchor = groups![indexPath.item];
        return cell
    }
}


//MARK:- UICollectionViewDelegate
extension RecommendGameView : UICollectionViewDelegate {
    
    
}

