//
//  MLAccountView.swift
//  MoLiao
//
//  Created by study on 2019/4/16.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol MLAccountViewDelegate: NSObjectProtocol {
    /// 点击了 “下一页”
    func loginClick(LoginView: MLAccountView, pwdText: String)
}


/// 创建账号
class MLAccountView: UIView {

    /// 手机号登录注册
    var centerView:UIView!
    var textFieldPassword:UITextField!
    
    let bgView = UIView()
    let loginBtn = UIButton()
    
    weak var delegate: MLAccountViewDelegate?
    let leftSpace:CGFloat = 30
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setupBGView()
        setupPhoneNumberView()
        setupLoginBtn()
        setupOtherView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLAccountView {
    
    private func setupBGView() {
       
        self.backgroundColor = kBgColor
        bgView.frame =  CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        self.addSubview(bgView)
    }
    
    /// 请输入手机号
    private func setupPhoneNumberView() {
        centerView = UIView.init(frame: CGRect(x: leftSpace, y: 50, width: (bgView.width - 2*leftSpace), height: 250))
        bgView.addSubview(centerView)
        
        /// 手机号
        let textFieldPhone = UITextField.init(frame: CGRect(x: 0, y: 0, width: centerView.width, height: 65))
        textFieldPhone.placeholder = "请输入手机号"
        textFieldPhone.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        centerView.addSubview(textFieldPhone)
        let phoneLine = UIView.init(frame: CGRect(x: 0, y: textFieldPhone.bottomY, width: centerView.width, height: 0.3))
        phoneLine.backgroundColor = kWangjiColor
        centerView.addSubview(phoneLine)
        
        textFieldPassword = UITextField.init(frame: CGRect(x: 0, y:textFieldPhone.bottomY , width: centerView.width, height: 66))
        textFieldPassword.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        textFieldPassword.placeholder = "请设置登录密码"
        centerView.addSubview(textFieldPassword)
        let passwordLine = UIView.init(frame: CGRect(x: 0, y: textFieldPassword.bottomY, width: centerView.width, height: 0.3))
        passwordLine.backgroundColor = kWangjiColor
        centerView.addSubview(passwordLine)
    }
    
    private func setupLoginBtn() {
//        loginBtn.backgroundColor = kNavColor
        loginBtn.frame = CGRect(x: 0, y: textFieldPassword.bottomY + 30, width: (bgView.width - 2*leftSpace), height: 50)
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitle("下一步", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.clipsToBounds = true
        loginBtn.backgroundColor = UIColor.gray
        centerView.addSubview(loginBtn)
    }
    
    private func setupOtherView() {
        let zhuceBtn = UIButton.init(type: .custom)
        zhuceBtn.frame = CGRect(x: 0, y: loginBtn.bottomY + 15, width: 80, height: 25)
        zhuceBtn.setTitle("注册账号", for: .normal)
        zhuceBtn.setTitleColor(kWangjiColor, for: .normal)
        centerView.addSubview(zhuceBtn)
        
        let wangjiBtn = UIButton.init(type: .custom)
        wangjiBtn.frame = CGRect(x: centerView.width - 90, y: loginBtn.bottomY + 15, width: 90, height: 25)
        wangjiBtn.setTitle("忘记密码?", for: .normal)
        wangjiBtn.setTitleColor(kWangjiColor, for: .normal)
        centerView.addSubview(wangjiBtn)
    }
}

extension MLAccountView {
    @objc private func loginClick() {

        delegate?.loginClick(LoginView: self, pwdText: textFieldPassword.text!)
    }
}
