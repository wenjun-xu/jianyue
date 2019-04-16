
//
//  RegistEightController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class RegistEightController: BaseViewController {
    var textView:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        view.backgroundColor = kBgColor
        let bgView = UIView.init(frame: CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace))
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        view.addSubview(bgView)
        
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 80, width: bgView.width, height: 40))
        topTitle.text = "为自己起一个有趣的名字吧"
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)
      
        
        textView = UITextView.init(frame: CGRect(x: (bgView.width - 220) / 2.0, y: topTitle.bottomY + 50, width: 220, height: 60))
        textView.font = UIFont.boldSystemFont(ofSize: 20.0)
        textView.textAlignment = .center
        textView.backgroundColor = UIColor.gray.alpha(0.3)
        textView.textAlignment = .center
        bgView.addSubview(textView)
        

        let nextBtn = UIButton.init(type: .custom)
        nextBtn.frame = CGRect(x: 20, y: kScreenHeight - kStatusBarH - kNavH - 100, width: kScreenWidth - 40 - 2*kBgViewSpace, height: 45)
        nextBtn.setTitle("进入陌聊", for: .normal)
        nextBtn.layer.cornerRadius = 8
        nextBtn.clipsToBounds = true
        nextBtn.backgroundColor = kNavColor
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        bgView.addSubview(nextBtn)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func nextClick() {
        let loginPwd:String = UserDefaults.standard.object(forKey: "loginPwd") as! String
        //用户不存在后就注册
        //执行注册的请求
        print("loginPwd==",loginPwd)
        print("textView==",textView.text)
        EMClient.shared()?.register(withUsername: textView.text, password: loginPwd) { (aUsername, aError) in
            if (aError != nil) { 
                print("注册失败 \(aError!.code)")
            }else {
                self.login(userName: self.textView.text, password: loginPwd)
                print("注册成功")
            }
        }
    }
    
    func login(userName:String,password:String) {
        //执行登录的请求
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
                self.view.window?.rootViewController = BaseTabBarController()
                
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
