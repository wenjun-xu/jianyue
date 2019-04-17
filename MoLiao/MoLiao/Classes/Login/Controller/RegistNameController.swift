
//
//  RegistNameController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

/// 为自己起一个有趣的名字
class RegistNameController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        view.backgroundColor = kBgColor
        
        let nameView = MLRegistNameView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        nameView.delegate = self
        self.view.addSubview(nameView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension RegistNameController: MLRegistNameViewDelegate {
    func loginClick(pageView: MLRegistNameView, name: String, pwd: String) {
        
        self.view.window?.rootViewController = BaseTabBarController()
    }
}

/*
 EMClient.shared()?.register(withUsername: name, password: pwd) { (aUsername, aError) in
 if (aError != nil) {
 print("注册失败 \(aError!.code)")
 } else {
 self.login(userName: name, password: pwd)
 print("注册成功")
 }
 }
 */

/*
 private func login(userName: String, password: String) {
 //执行登录的请求
 EMClient.shared().login(withUsername: userName, password: password) { (aUsername, aError) in
 if (aError != nil) {
 print("登录失败 \(aError!.code)")
 
 if (aError?.code == EMErrorUserAuthenticationFailed) {
 print("密码错误 \(aError!.code)")
 
 } else if (aError?.code == EMErrorUserNotFound) {
 print("用户不存在 \(aError!.code)")
 }
 
 } else {
 print("登录成功")
 
 self.view.window?.rootViewController = BaseTabBarController()
 }
 }
 }
 */
