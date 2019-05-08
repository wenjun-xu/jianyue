//
//  UserNameLoginView.swift
//  MoLiao
//
//  Created by 华通众和 on 2019/2/28.
//  Copyright © 2019年 徐庆标. All rights reserved.
//

import UIKit

protocol UserNameLoginViewDelegate: NSObjectProtocol {
    /// 点击了登录按钮
    func loginButtonClick(LoginView: UserNameLoginView, userName: String, password: String)
    /// 点击了 “ 注册”
    func loginRegistClick(LoginView: UserNameLoginView)
    /// 点击了 "忘记密码"
    func loginForgetPwdClick(LoginView: UserNameLoginView)
}

class UserNameLoginView: UIView {
    /// 账号
    let aTFPhone =  UITextField()
    /// 密码
    let aTFPassword =  UITextField()
    
    weak var delegate: UserNameLoginViewDelegate?
    
    //////// frame值 ////////
    /// x的值
    private let loginXSpace: CGFloat = 40
    /// 标题
    private let aTitleL = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 1. 标题
        setUpUIViewWithLabel()
                
        // 2. 账号登录界面
        let nameAndPwdView = setUIViewWithLoginView()
        self.addSubview(nameAndPwdView)
        
        // 3. 登录按钮
        let lgBtn = CGRect(x: loginXSpace, y: nameAndPwdView.frame.maxY + 20, width: nameAndPwdView.frame.width, height: 88)
        let loginBtnView = setupUIViewWithLoginBtn(frame: lgBtn)
        self.addSubview(loginBtnView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK: - 注册 忘记面膜
extension UserNameLoginView {
    /// 注册
    @objc private func setPhoneClick() {
        delegate?.loginRegistClick(LoginView: self)
    }
    
    /// 忘记面膜
    @objc private func setAreaCodeClick() {
        delegate?.loginForgetPwdClick(LoginView: self)
    }
}

// MARK: - 登录账号 View
extension UserNameLoginView {
    /// 头像 View
    private func setUpUIViewWithLabel() {
        let aPY: CGFloat = 64
        let aPW: CGFloat = 180
        let aPH: CGFloat = 40

        aTitleL.frame = CGRect(x: loginXSpace, y: aPY, width: aPW, height: aPH)
        aTitleL.font = UIFont.systemFont(ofSize: 38)
        aTitleL.textColor = UIColor.white
        aTitleL.text = "登录账号"
        addSubview(aTitleL)
    }
}

// MARK: - 用户名和密码 View
extension UserNameLoginView {
    
    /// 用户名和密码 View
    private func setUIViewWithLoginView() -> UIView {
        
        /// 背景View
        let centerView = UIView()
        let aCY: CGFloat = aTitleL.frame.maxY + 90
        let aCW: CGFloat = kScreenWidth - 2 * loginXSpace
        let aCH: CGFloat = 80

        centerView.frame = CGRect(x: loginXSpace, y: aCY, width: aCW, height: aCH)
        
        // UITexField 高度
        let tfHeight: CGFloat = frameLoginView.FNameAndPwd.frame
        // UITexField下边线的高度
        let tfLine: CGFloat = frameLoginView.Fline.frame
        
        // 简约号/邮箱/手机号
        aTFPhone.frame = CGRect(x: 0, y: 0, width: centerView.width, height: tfHeight)
        aTFPhone.placeholder = "请输入账号"
        aTFPhone.delegate = self
        aTFPhone.font = UIFont.systemFont(ofSize: 18)
        centerView.addSubview(aTFPhone)
        
        let phoneLine = UIView.init(frame: CGRect(x: 0, y: aTFPhone.bottomY, width: centerView.width, height: tfLine))
        phoneLine.backgroundColor = kWangjiColor
        centerView.addSubview(phoneLine)

        // 登录密码
        aTFPassword.frame = CGRect(x: 0, y: aTFPhone.bottomY + 10, width: centerView.width, height: tfHeight)
        aTFPassword.delegate = self
        aTFPassword.placeholder = "请输入登录"
        aTFPassword.font = UIFont.systemFont(ofSize: 18)
        centerView.addSubview(aTFPassword)
        
        let passwordLine = UIView.init(frame: CGRect(x: 0, y: aTFPassword.bottomY, width: centerView.width, height: tfLine))
        passwordLine.backgroundColor = kWangjiColor
        centerView.addSubview(passwordLine)
        
        
        return centerView
    }
}

// MARK: - 登录View
extension UserNameLoginView {
    private func setupUIViewWithLoginBtn(frame: CGRect) -> UIView{
        let bgView = UIView(frame: frame)
        
        let loginBtn = UIButton(type: .custom)
        loginBtn.backgroundColor = kNavColor
        
        let aLBW: CGFloat = kScreenWidth - 2 * loginXSpace
        let aLBH: CGFloat = frameLoginView.FLoginBtn.frame
            
        loginBtn.frame = CGRect(x: 0, y: 0, width:aLBW, height: aLBH)
        loginBtn.layer.cornerRadius = 16
        loginBtn.setTitle("进入陌聊", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.clipsToBounds = true
        loginBtn.backgroundColor = UIColor(red: 246/255.0, green: 115/255.0, blue: 109/255.0, alpha: 1)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        bgView.addSubview(loginBtn)

        
        let registBtn = UIButton(type: .custom)
        registBtn.frame = CGRect(x: 0, y: loginBtn.bottomY + 13, width:120, height: 16)
        registBtn.setTitle("注册", for: .normal)
        registBtn.contentHorizontalAlignment = .left
        registBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        registBtn.addTarget(self, action: #selector(setPhoneClick), for: .touchUpInside)
        bgView.addSubview(registBtn)

        
        let forgetPwd = UIButton(type: .custom)
        forgetPwd.frame = CGRect(x: bgView.width - 90, y: loginBtn.bottomY + 15, width: 90, height: 16)
        forgetPwd.setTitle("忘记密码", for: .normal)
        forgetPwd.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        forgetPwd.addTarget(self, action: #selector(setAreaCodeClick), for: .touchUpInside)
        bgView.addSubview(forgetPwd)
        
        return bgView
    }
}


// MARK: - 登录按钮的点击事件
extension UserNameLoginView {
    @objc private func loginClick() {
        
        if (aTFPassword.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) || (aTFPhone.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            print("用户名和密码不能为空")
            return
        }
        
        delegate?.loginButtonClick(LoginView: self, userName: aTFPhone.text ?? "", password: aTFPassword.text ?? "")
    }
}

// MARK: - UITextFieldDelegate
extension UserNameLoginView: UITextFieldDelegate {
    // MARK:- 5 点击手势
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//        loginFallingAnimate()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        loginRisingAnimate()
        return true
    }
    // MARK:- 3 uitextfield编辑完成后逻辑处理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        loginFallingAnimate()
        return true
    }
}
