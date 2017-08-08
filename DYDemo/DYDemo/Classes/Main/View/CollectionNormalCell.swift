//
//  CollectionNormalCell.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/4.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {
    
    //MARK:- 控件属性
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onLineButton: UIButton!
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
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
           
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
            
            self.roomNameLabel.text = anchor.room_name
            
        }
    }
    
}
