//
//  PageTitleView.swift
//  DYDemo
//
//  Created by ZYP-MAC on 2017/7/31.
//  Copyright © 2017年 ZYP-MAC. All rights reserved.
//

import UIKit

//MARK:- titleLabel点击事件代理(加class，表示该协议只能被类继承)
protocol PageTitleViewDelegate : class {
    ///selectedIndex:外部参数  index:内部参数
    func pageTitleView(titleView : PageTitleView,selectedIndex index : Int)
    
}

private let PScrollLineH : CGFloat = 2

class PageTitleView: UIView {
    //MARK:-  定义属性
    fileprivate var titles: [String]
    
    fileprivate var currentIndex : Int = 0
    // 代理属性
    weak var delegate : PageTitleViewDelegate?
    
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
            // 1.创建label
            let label = UILabel()
            // 2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            // 3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            // 4.将label添加到scrollView中
            scrollView .addSubview(label)
            titleLabels.append(label)
            
            // 5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGest)
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

//MARK:- 监听label的点击
extension PageTitleView {

    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer) {
        
        // 1.获取当前label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        if currentLabel.tag == currentIndex {
            return
        }
        
        // 2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        // 3. 切换文字颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        
        // 4.保存最新label的下标值
        currentIndex = currentLabel.tag
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        // 6. 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
        
    }
}
