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

//MARK:- 定义常量
private let PScrollLineH : CGFloat = 2
/// 元组类型
fileprivate let pNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
fileprivate let pSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

//MARK:- 定义类
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
        scrollLine.backgroundColor = UIColor(r: pSelectColor.0, g: pSelectColor.1, b: pSelectColor.2)
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
            label.textColor = UIColor(r: pNormalColor.0, g: pNormalColor.1, b: pNormalColor.2)
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
        firstLabel.textColor = UIColor(r: pSelectColor.0, g: pSelectColor.1, b: pSelectColor.2)
        
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
        currentLabel.textColor = UIColor(r: pSelectColor.0, g: pSelectColor.1, b: pSelectColor.2)
        oldLabel.textColor = UIColor(r: pNormalColor.0, g: pNormalColor.1, b: pNormalColor.2)
        
        
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



//MARK:- 对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress : CGFloat,sourceIndex : Int,targetIndex : Int){
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑线的逻辑
        let moveTotalX = targetLabel.frame.minX - sourceLabel.frame.minX
        let moveX = moveTotalX * progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.minX + moveX
        
        // 3.颜色的渐变
        // 3.1 取出颜色的变化范围
        let colorRange : (CGFloat,CGFloat,CGFloat) = (pSelectColor.0-pNormalColor.0,pSelectColor.1-pNormalColor.1,pSelectColor.2-pNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: pSelectColor.0 - colorRange.0*progress, g: pSelectColor.1 - colorRange.1*progress, b: pSelectColor.2 - colorRange.2*progress)
        targetLabel.textColor = UIColor(r: pNormalColor.0 + colorRange.0*progress, g: pNormalColor.1 + colorRange.1*progress, b: pNormalColor.2 + colorRange.2*progress)
        // 4.记录最新的index
        currentIndex = targetIndex;
        
        
    }
}
