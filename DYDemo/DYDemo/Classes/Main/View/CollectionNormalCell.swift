//
//  CollectionNormalCell.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/4.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    
    //MARK:- 控件属性
    @IBOutlet weak var roomNameLabel: UILabel!
    
    
    //MARK:- 定义属性
    override var anchorModel : AnchorModel? {
        
        didSet {
            super.anchorModel = anchorModel
            
            self.roomNameLabel.text = anchorModel?.room_name
            
        }
    }
    
}
