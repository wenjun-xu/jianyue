//
//  MLRegistBaseView.swift
//  MoLiao
//
//  Created by study on 2019/4/18.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class MLRegistBaseView: UIView {

    let bgView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 白色背景
        setupBGView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 父类独有的方法
extension MLRegistBaseView {
    private func setupBGView() {
        bgView.frame = CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        self.addSubview(bgView)
    }
}

// MARK:- 子类自行调用
extension MLRegistBaseView {
    public func setupTopicView(title: String) {
        
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 60, width: bgView.width, height: 30))
        topTitle.text = title 
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)
        
    }
}
