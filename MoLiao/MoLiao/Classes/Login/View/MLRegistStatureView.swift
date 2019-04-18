//
//  MLRegistStatureView.swift
//  MoLiao
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol MLRegistStatureViewDelegate: NSObjectProtocol {
    /// 身高按钮
    func statureBtnClick(pageView: MLRegistStatureView, height: String)
}

/// "完善信息(3/7)" - 身高
class MLRegistStatureView: MLRegistBaseView {

    weak var delegate: MLRegistStatureViewDelegate?
    /// 身高
    private var heightString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- DYScrollRulerDelegate
extension MLRegistStatureView: DYScrollRulerDelegate {
    func dyScrollRulerView(_ rulerView: DYScrollRulerView!, valueChange value: Float) {
        self.heightString = "\(value)"
    }
    
}

// MARK:- 点击事件
extension MLRegistStatureView {
    @objc func nextClick() {
        self.delegate?.statureBtnClick(pageView: self, height: heightString)
    }
}


// MARK:- UI创建
extension MLRegistStatureView {    
    private func setupContent() {
        
        
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 80, width: bgView.width, height: 40))
        topTitle.text = "你的身高是"
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)
        
        let rulerView = DYScrollRulerView.init(frame: CGRect(x: 20, y: topTitle.bottomY + 50, width: kScreenWidth - 40 - 2*kBgViewSpace, height: 200), theMinValue: 140, theMaxValue: 220, theStep: 1, theUnit: "com", theNum: 5)
        rulerView?.setDefaultValue(155, animated: true)
        rulerView?.bgColor = UIColor.gray
        rulerView?.triangleColor = UIColor.white
        rulerView?.delegate = self
        rulerView?.scrollByHand = true
        bgView.addSubview(rulerView!)
        
        let nextBtn = UIButton.init(type: .custom)
        nextBtn.frame = CGRect(x: 20, y: kScreenHeight - kStatusBarH - kNavH - 100, width: kScreenWidth - 40 - 2*kBgViewSpace, height: 45)
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.layer.cornerRadius = 8
        nextBtn.clipsToBounds = true
        nextBtn.backgroundColor = UIColor.blue //kNavColor
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        bgView.addSubview(nextBtn)
    }
    
    
}

