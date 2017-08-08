//
//  CollectionPrettyCell.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/4.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class CollectionPrettyCell: UICollectionViewCell {
    //MARK:- 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onLineButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    
    //MARK:- 定义属性
    var anchorModel : AnchorModel? {
        
        didSet {
            guard let anchor = anchorModel else {
                return
            }
            
            var onelineStr : String = ""
            if anchor.online >= 10000 {
                onelineStr = "\(Int(anchor.online / 10000))万在线"
            }else {
                onelineStr = "\(anchor.online)在线"
                
            }
            onLineButton.setTitle(onelineStr, for: .normal)
            
            
            nickNameLabel.text = anchor.nickname
            cityButton.setTitle(anchor.anchor_city, for: .normal)
            
              //            iconImageView.image = UIImage(named: AnchorModel.vertical_src)??
            
        }
    }
    
}
