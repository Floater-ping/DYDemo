//
//  CollectionCycleCell.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/8/9.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    //MARK:- 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            guard let iconURL = URL(string: cycleModel?.pic_url ?? "") else { return }
//            iconImageView.kf.setImage(with: iconURL)
            
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"), options: nil, progressBlock: nil, completionHandler: nil)
            
        }
    }
    
    
}

