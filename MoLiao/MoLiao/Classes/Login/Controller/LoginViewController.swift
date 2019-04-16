
//
//  LoginViewController.swift
//  MoLiao
//
//  Created by 文瑶 on 2019/1/6.
//  Copyright © 2019 文瑶. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController,UITextFieldDelegate {
    var window: UIWindow?
    var centerView:UIView!
    var textFieldPhone:UITextField!
    var textFieldPassword:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.title = "登录"
        
        view.backgroundColor = UIColor.white
        
        let logFrame = CGRect(x: 0, y: kScreenHeight - 140, width: kScreenWidth, height: 140)

        let loginView = LoginView(frame: logFrame)
        loginView.backgroundColor = UIColor.orange
        loginView.delegate = self
        self.view.addSubview(loginView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("kScreenHeight = \(kScreenHeight)")
        // 隐藏导航栏
        self.navigationController?.navigationBar.isHidden = true
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
