//
//  UserNameController.swift
//  MoLiao
//
//  Created by 华通众和 on 2019/3/4.
//  Copyright © 2019年 徐庆标. All rights reserved.
//

import UIKit

/// 账号登录界面
class UserNameController: BaseViewController {
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.isHidden = true
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "login")!)
//        // 导航栏
//        setNavigation()
        
        let loginView = UserNameLoginView(frame: CGRect(x: 0, y: 20, width: kScreenWidth, height: kScreenHeight - 64))
        loginView.delegate = self
        view.addSubview(loginView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏导航栏
//        self.navigationBar?.navigationBar.isHidden = true
        self.navigationBar.isHidden = true
    }
    
    /// 状态栏 北京色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - 导航栏
extension UserNameController {
    private func setNavigation() {
       self.navigationItem.leftBarButtonItem = setupLeftBarItem()
        
       self.navigationItem.rightBarButtonItem = setupRightIconBarItem(rightTitle: "登录遇到困难？")
    }
    
    /// 导航栏 左侧按钮
    override func setupLeftBarItemClick() {
//        _ = self.navigationController?.popViewController(animated: true)
        
        print("点击了 导航栏 左侧按钮")
    }
    
    /// 导航栏 右侧按钮
    override func setupRightBarItemClick() {
        
        print("点击了 导航栏 右侧按钮")
    }
}

// MARK: - UserNameLoginViewDelegate
extension UserNameController: UserNameLoginViewDelegate {
    func loginRegistClick(LoginView: UserNameLoginView) {
        print("点击了 注册码登录 ")
    }
    
    func loginForgetPwdClick(LoginView: UserNameLoginView) {
        print("点击了 忘记密码登录 ")
    }
    
    func loginButtonClick(LoginView: UserNameLoginView, userName: String, password: String) {
        // 执行登录的请求
        
        print("点击了账号界面的 登录按钮")
        print("userName = \(userName)")
        print("password = \(password)")
    }
}


/*  现在用不到的代码
 
 
 
 EMClient.shared().login(withUsername: userName, password: password) { (aUsername, aError) in
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
 */
