//
//  MLHomePageView.swift
//  MoLiao
//
//  Created by study on 2019/4/16.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol MLHomePageViewDelegate: NSObjectProtocol {
    /// 登录按钮
    func loginClick(pageView: MLHomePageView)
    /// 注册按钮
    func registerClick(pageView: MLHomePageView)
}

/// 引导页View
class MLHomePageView: UIView {

    weak var delegate: MLHomePageViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
      
        setupBGView()
        
        setupOtherBtnView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:- 点击事件
extension MLHomePageView {
    /// 登录按钮点击事件
    @objc private func loginAction()  {
       self.delegate?.loginClick(pageView: self)
    }
    
    /// 注册按钮点击事件
    @objc private func registerAction() {
        self.delegate?.registerClick(pageView: self)
    }
}


// MARK:- UI创建
extension MLHomePageView {
    private func setupBGView() {
        let bgView = UIImageView.init(frame: self.bounds)
        bgView.image = UIImage(named: "img640")
        self.addSubview(bgView)
    }
    
    /// 注册按钮 和 登录按钮
    private func setupOtherBtnView() {
        let centerSpace:CGFloat = 10
        let leftSpace:CGFloat = 17
        
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.frame = CGRect(x: leftSpace, y: kScreenHeight - 110, width: (kScreenWidth / 2.0 - leftSpace - centerSpace/2.0), height: 45)
        leftBtn.layer.cornerRadius = 6
        leftBtn.tag = 1000
        leftBtn.setTitle("注册", for: .normal)
        leftBtn.backgroundColor = UIColor(red: 234/255.0, green: 142/255.0, blue: 87/255.0, alpha: 1)
        leftBtn.clipsToBounds = true
        leftBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        self.addSubview(leftBtn)
        
        let rightBtn = UIButton.init(type: .custom)
        rightBtn.frame = CGRect(x: kScreenWidth / 2.0 + centerSpace / 2.0, y: kScreenHeight - 110, width: kScreenWidth / 2.0 - leftSpace - centerSpace/2.0, height: 45)
        rightBtn.layer.cornerRadius = 6
        rightBtn.tag = 1001
        rightBtn.setTitle("登录", for: .normal)
        rightBtn.backgroundColor = UIColor(red: 85/255.0, green: 187/255.0, blue: 149/255.0, alpha: 1)
        rightBtn.clipsToBounds = true
        rightBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.addSubview(rightBtn)
    }
}
