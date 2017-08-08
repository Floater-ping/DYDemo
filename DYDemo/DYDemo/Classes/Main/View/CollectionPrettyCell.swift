//
//  CollectionPrettyCell.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/4.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {
    //MARK:- 控件属性
    @IBOutlet weak var cityButton: UIButton!
    
    //MARK:- 定义属性
    var anchorModel : AnchorModel? {
        
        didSet {
            guard let anchor = anchorModel else {
                return
            }
            
          
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }else {
                onlineStr = "\(anchor.online)在线"
            }
            onLineButton.setTitle(onlineStr, for: .normal)
            
            nickNameLabel.text = anchor.nickname
            cityButton.setTitle(anchor.anchor_city, for: .normal)
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
           
        }
    }
    
}
