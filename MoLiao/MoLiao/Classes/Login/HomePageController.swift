//
//  HomePageController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/7.
//  Copyright © 2019 徐庆标. All rights reserved.
//


import UIKit

class HomePageController: UIViewController {
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgView = UIImageView.init(frame: self.view.bounds)
        bgView.image = UIImage(named: "img640")
        view.addSubview(bgView)
        
        let centerSpace:CGFloat = 10
        let leftSpace:CGFloat = 17
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.frame = CGRect(x: leftSpace, y: kScreenHeight - 110, width: (kScreenWidth / 2.0 - leftSpace - centerSpace/2.0), height: 45)
        leftBtn.layer.cornerRadius = 6
        leftBtn.tag = 1000
        leftBtn.setTitle("注册", for: .normal)
        leftBtn.backgroundColor = UIColor(red: 234/255.0, green: 142/255.0, blue: 87/255.0, alpha: 1)
        leftBtn.clipsToBounds = true
        leftBtn.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        view.addSubview(leftBtn)
        
        let rightBtn = UIButton.init(type: .custom)
        rightBtn.frame = CGRect(x: kScreenWidth / 2.0 + centerSpace / 2.0, y: kScreenHeight - 110, width: kScreenWidth / 2.0 - leftSpace - centerSpace/2.0, height: 45)
        rightBtn.layer.cornerRadius = 6
        rightBtn.tag = 1001
        rightBtn.setTitle("登录", for: .normal)
        rightBtn.backgroundColor = UIColor(red: 85/255.0, green: 187/255.0, blue: 149/255.0, alpha: 1)
        rightBtn.clipsToBounds = true
        rightBtn.addTarget(self, action: #selector(clickAction(sender:)), for: .touchUpInside)
        view.addSubview(rightBtn)
        
        var arrImageName = [String]()
        arrImageName = ["launimgone","launimgtwo","launimgthree"]
        let launchGuidePage = DHGuidePageHUD.init(frame: view.bounds, imageNameArray: arrImageName, buttonIsHidden: true)
        launchGuidePage?.slideInto = true
        self.view.addSubview(launchGuidePage!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.navigationController?.children.count)! > 1 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    
    @objc func clickAction(sender:UIButton)  {
        if sender.tag == 1000 {
            let vc = RegistViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
