//
//  GameCollectionCell.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/14.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class GameCollectionCell: UICollectionViewCell {
    
    //MARK:- 控件属性
    
    @IBOutlet weak var gImageView: UIImageView!
    
    @IBOutlet weak var gTitleNameLabel: UILabel!
    //MARK:- 设置数据属性
    var anchor : AnchorGroupModel? {
    
        didSet {
            guard let anchor = anchor else {
                return
            }
            gTitleNameLabel.text = anchor.tag_name;
            guard let iconURL = URL(string: anchor.icon_url ) else {
                let img = UIImage(named: "home_more_btn")
                gImageView.image = img;
                return
            }
            
            gImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}

