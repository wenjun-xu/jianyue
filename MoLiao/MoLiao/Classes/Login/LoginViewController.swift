
//
//  LoginViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/6.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController,UITextFieldDelegate {
    var window: UIWindow?
    var centerView:UIView!
    var textFieldPhone:UITextField!
    var textFieldPassword:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        let leftSpace:CGFloat = 30
        view.backgroundColor = UIColor.white
        
        centerView = UIView.init(frame: CGRect(x: leftSpace, y: 80, width: (kScreenWidth - 2*leftSpace), height: 250))
        view.addSubview(centerView)
        textFieldPhone = UITextField.init(frame: CGRect(x: 0, y: 0, width: centerView.width, height: 65))
        textFieldPhone.placeholder = "输入手机号"
        textFieldPhone.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        textFieldPhone.delegate = self
        centerView.addSubview(textFieldPhone)
        let phoneLine = UIView.init(frame: CGRect(x: 0, y: textFieldPhone.bottomY, width: centerView.width, height: 0.3))
        phoneLine.backgroundColor = kWangjiColor
        centerView.addSubview(phoneLine)
        
        textFieldPassword = UITextField.init(frame: CGRect(x: 0, y:textFieldPhone.bottomY , width: centerView.width, height: 66))
        textFieldPassword.delegate = self
        textFieldPassword.setValue(kWangjiColor, forKeyPath: "_placeholderLabel.textColor")
        textFieldPassword.placeholder = "输入密码"
        centerView.addSubview(textFieldPassword)
        let passwordLine = UIView.init(frame: CGRect(x: 0, y: textFieldPassword.bottomY, width: centerView.width, height: 0.3))
        passwordLine.backgroundColor = kWangjiColor
        centerView.addSubview(passwordLine)
        
        let loginBtn = UIButton.init(type: .custom)
        loginBtn.backgroundColor = kNavColor
        loginBtn.frame = CGRect(x: 0, y: textFieldPassword.bottomY + 30, width: (kScreenWidth - 2*leftSpace), height: 50)
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitle("登 录", for: .normal)
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
        centerView.addSubview(wangjiBtn)
        
    }
 
    @objc func loginClick() {
        
        if (textFieldPassword.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) || (textFieldPhone.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            print("用户名和密码不能为空")
            return
        }
        
        //执行登录的请求
        EMClient.shared().login(withUsername: textFieldPhone.text, password: textFieldPassword.text) { (aUsername, aError) in
            if (aError != nil) {
                print("登录失败 \(aError!.code)")
                
                if (aError?.code == EMErrorUserAuthenticationFailed) {
                    print("密码错误 \(aError!.code)")
                    
                } else if (aError?.code == EMErrorUserNotFound) {
                    print("用户不存在 \(aError!.code)")
                }
                
            }else {
                print("登录成功")
                
                //自动登录(内部会把用户名和密码保存到用户的偏好设置里)
//                EMClient.shared().options.isAutoLogin = self.autoLoginSwitch.isOn
                
                self.saveLastLoginUsername()
                self.saveLastLoginIsAutoLogin()
                
                self.view.window?.rootViewController = BaseTabBarController()

            }
        }
            
    }
    
    
    
    
    private func saveLastLoginUsername() {
        let username = EMClient.shared().currentUsername
        if username != nil && (!username!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(username, forKey: "mb_lastLogin_username")
            userDefaults.synchronize()
        }
    }
    
    private func saveLastLoginIsAutoLogin() {
        let isAutoLogin = EMClient.shared().options.isAutoLogin
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(isAutoLogin, forKey: "mb_lastLogin_isAutoLogin")
        userDefaults.synchronize()
    }
    
    private var lastLoginUsername : String? {
        let userDefaults = UserDefaults.standard
        let username = userDefaults.value(forKey: "mb_lastLogin_username") as? String
        
        if username != nil && (!username!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty) {
            return username
        }
        
        return nil
    }
    
    private var lastLoginIsAutoLogin : Bool {
        let userDefaults = UserDefaults.standard
        let isAutoLogin = userDefaults.value(forKey: "mb_lastLogin_isAutoLogin") as? Bool
        
        return isAutoLogin ?? false
    }
    
    
    
    // MARK:- 5 点击手势
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        loginFallingAnimate()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        loginRisingAnimate()
        return true
    }
    // MARK:- 3 uitextfield编辑完成后逻辑处理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginFallingAnimate()
        return true
    }
 
    
    
    // MARK:- 6 上升动画
    func loginRisingAnimate() {
        UIView.animate(withDuration: 0.5, animations: {
//            self.centerView.y = self.topview.bottomY
        })
    }
    
    // MARK:- 7 下降动画
    func loginFallingAnimate() {
        UIView.animate(withDuration: 0.5, animations: {
//            self.topview.y =  80
//            self.centerView.y = 200
        })
    }
    

}
