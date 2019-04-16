//
//  AccountViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController {
    var window: UIWindow?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = "完善信息"
        self.title = "创建账号"
        
        let accountView = MLAccountView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        accountView.delegate = self
        self.view.addSubview(accountView)
    }
}

extension AccountViewController: MLAccountViewDelegate {
    
    func loginClick(LoginView: MLAccountView, pwdText: String) {
        UserDefaults.standard.set(pwdText, forKey: "loginPwd")
        let vc = CodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
