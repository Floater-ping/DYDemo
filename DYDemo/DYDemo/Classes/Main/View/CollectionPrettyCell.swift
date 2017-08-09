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
    override var anchorModel : AnchorModel? {
        
        didSet {
            super.anchorModel = anchorModel
          
            cityButton.setTitle(anchorModel?.anchor_city, for: .normal)
           
        }
    }
    
}
