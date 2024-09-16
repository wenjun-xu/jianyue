//
//  HomePageController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/7.
//  Copyright © 2019 徐庆标. All rights reserved.
//


import UIKit

/// 引导页Controller
class HomePageController: UIViewController {
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let codeView = MLHomePageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        codeView.delegate = self
        self.view.addSubview(codeView)
        
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
}

extension HomePageController: MLHomePageViewDelegate {
    func loginClick(pageView: MLHomePageView) {
        let vc = UserNameController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func registerClick(pageView: MLHomePageView) {
        let vc = MLRegistGenderController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
