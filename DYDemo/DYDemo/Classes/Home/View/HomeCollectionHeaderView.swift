//
//  HomeCollectionHeaderView.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/4.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class HomeCollectionHeaderView: UICollectionReusableView {
    //MARK:- 控件属性
    ///图片
    @IBOutlet weak var iconImageView: UIImageView!
    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    //MARK:- 模型属性
    var groupModel : AnchorGroupModel? {
    
        didSet {
        titleLabel.text = groupModel?.tag_name
            iconImageView.image = UIImage.init(named: groupModel?.icon_name ?? "home_header_normal")
            
        }
    }
    
}
