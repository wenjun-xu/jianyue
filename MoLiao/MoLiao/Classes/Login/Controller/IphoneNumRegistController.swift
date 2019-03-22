//
//  IphoneNumRegistController.swift
//  MoLiao
//
//  Created by 华通众和 on 2019/3/22.
//  Copyright © 2019年 徐庆标. All rights reserved.
//

import UIKit

/// 手机号登陆注册
class IphoneNumRegistController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 显示导航栏
        self.navigationController?.navigationBar.isHidden = false
        
        // 导航栏
        setNavigation()
        
        view.backgroundColor = UIColor.white
        
        let loginView = UserNameLoginView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        loginView.delegate = self
        view.addSubview(loginView)
    }
}

// MARK: - 导航栏
extension IphoneNumRegistController {
    private func setNavigation() {
        self.navigationItem.leftBarButtonItem = setupLeftBarItem()
        
        self.navigationItem.rightBarButtonItem = setupRightIconBarItem(rightTitle: "登录遇到困难？")
    }
    
    /// 导航栏 左侧按钮
    override func setupLeftBarItemClick() {
        _ = self.navigationController?.popViewController(animated: true)
        
        print("点击了 导航栏 左侧按钮")
    }
    
    /// 导航栏 右侧按钮
    override func setupRightBarItemClick() {
        
        print("点击了 导航栏 右侧按钮")
    }
}

// MARK: - UserNameLoginViewDelegate
extension IphoneNumRegistController: UserNameLoginViewDelegate {
    func loginPhotoClick(LoginView: UserNameLoginView) {
        print("点击了 手机号验证码登录 ")
    }
    
    func loginAreaClick(LoginView: UserNameLoginView) {
        print("点击了 选择区号 ")
    }
    
    func loginWeiXinClick(LoginView: UserNameLoginView) {
        print("点击了 微信登录 ")
    }
    
    func loginQQClick(LoginView: UserNameLoginView) {
        print("点击了 qq登录 ")
    }
    
    func loginButtonClick(LoginView: UserNameLoginView, userName: String, password: String) {
        // 执行登录的请求
        
        print("点击了账号界面的 登录按钮")
        print("userName = \(userName)")
        print("password = \(password)")
    }
}
