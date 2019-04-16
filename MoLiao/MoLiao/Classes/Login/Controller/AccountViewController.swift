//
//  AccountViewController.swift
//  MoLiao
//
//  Created by 文瑶 on 2019/1/8.
//  Copyright © 2019 文瑶. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController,UITextFieldDelegate {
    var window: UIWindow?
    var centerView:UIView!
    var textFieldPassword:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.title = "完善信息"
        self.title = "创建账号"
        let leftSpace:CGFloat = 30
        
        view.backgroundColor = kBgColor
        let bgView = UIView.init(frame: CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace))
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        view.addSubview(bgView)
        
     
        
        centerView = UIView.init(frame: CGRect(x: leftSpace, y: 50, width: (bgView.width - 2*leftSpace), height: 250))
        bgView.addSubview(centerView)
        let textFieldPhone = UITextField.init(frame: CGRect(x: 0, y: 0, width: centerView.width, height: 65))
        textFieldPhone.placeholder = "请输入手机号"
        textFieldPhone.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        textFieldPhone.delegate = self
        centerView.addSubview(textFieldPhone)
        let phoneLine = UIView.init(frame: CGRect(x: 0, y: textFieldPhone.bottomY, width: centerView.width, height: 0.3))
        phoneLine.backgroundColor = kWangjiColor
        centerView.addSubview(phoneLine)
        
        textFieldPassword = UITextField.init(frame: CGRect(x: 0, y:textFieldPhone.bottomY , width: centerView.width, height: 66))
        textFieldPassword.delegate = self
        textFieldPassword.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        textFieldPassword.placeholder = "请设置登录密码"
        centerView.addSubview(textFieldPassword)
        let passwordLine = UIView.init(frame: CGRect(x: 0, y: textFieldPassword.bottomY, width: centerView.width, height: 0.3))
        passwordLine.backgroundColor = kWangjiColor
        centerView.addSubview(passwordLine)
        
        let loginBtn = UIButton.init(type: .custom)
        loginBtn.backgroundColor = kNavColor
        loginBtn.frame = CGRect(x: 0, y: textFieldPassword.bottomY + 30, width: (bgView.width - 2*leftSpace), height: 50)
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitle("下一步", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.clipsToBounds = true
        centerView.addSubview(loginBtn)
        
        let zhuceBtn = UIButton.init(type: .custom)
        zhuceBtn.frame = CGRect(x: 0, y: loginBtn.bottomY + 15, width: 80, height: 25)
        zhuceBtn.setTitle("注册账号", for: .normal)
        zhuceBtn.setTitleColor(kWangjiColor, for: .normal)
        //        centerView.addSubview(zhuceBtn)
        
        let wangjiBtn = UIButton.init(type: .custom)
        wangjiBtn.frame = CGRect(x: centerView.width - 90, y: loginBtn.bottomY + 15, width: 90, height: 25)
        wangjiBtn.setTitle("忘记密码?", for: .normal)
        wangjiBtn.setTitleColor(kWangjiColor, for: .normal)
//        centerView.addSubview(wangjiBtn)
        
    }
    
    @objc func loginClick() {
        UserDefaults.standard.set(textFieldPassword.text, forKey: "loginPwd")
        let vc = CodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
}
