//
//  PageTitleView.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/7/31.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

private let PScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    //MARK:-  定义属性
    fileprivate var titles: [String]
    
    fileprivate lazy var scrollView : UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    fileprivate lazy var scrollLine : UIView = {
    
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
        
    }()
    
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    
    
    //MARK:- 自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame:frame)
        
        // 设置ui界面
        setupUI()
    }
    
    
    
    
    /// 自定义或者重写构造函数必须重写该方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    
    
}

//MARK:- 设置ui界面
extension PageTitleView {
    
    fileprivate func setupUI(){
        // 1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 2. 添加titleview对应的label
        setUpTitleViewLabels()
        
        // 3.设置底线和底部划块
        setUpBottomLineAndScrollLine()
    }
    
    private func setUpTitleViewLabels(){
        let labelW : CGFloat = frame.width/CGFloat(titles.count)
        let labelH : CGFloat = frame.height - PScrollLineH
        let labelY : CGFloat = 0
        for (index,title) in titles.enumerated() {
            // 创建label
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView .addSubview(label)
            titleLabels.append(label)
            
            
        }
    }
    
    private func setUpBottomLineAndScrollLine(){
        // 1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 2.添加scrollviewline
        // 2.1 获取第一个label
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        
        // 2.2 设置scrollLine的属性
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - PScrollLineH, width: firstLabel.frame.size.width, height: PScrollLineH)
        
    }
}
