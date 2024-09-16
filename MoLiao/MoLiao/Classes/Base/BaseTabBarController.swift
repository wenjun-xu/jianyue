//
//  BaseTabBarController.swift
//  LiaoLiao
//
//  Created by 徐庆标 on 2018/12/24.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    private var arrTitle = ["推荐","消息","动态","我"]
    private var arrImage = ["首页","消息","发现","我的"]
    private var arrseletImage = ["首页选中","消息选中","发现选中","我的选中"];
    private var arrVC = [HomeNewController(),
                         ConverListViewController(),
                         WJDynamicViewController(),
                         MeNewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.createViewControllers()
        
//        for i in 0...arrTitle.count - 1 {
//            addChildViewController(vc: arrVC[i], title: arrTitle[i], image: arrImage[i], selectedImage: arrseletImage[i])
//        }
    }
    
    func createViewControllers() {
        var arrNav = [BaseNavgationController]()
        for i in 0...arrTitle.count - 1 {
            let vc = arrVC[i]
            vc.title = arrTitle[i]
            let nav = BaseNavgationController(rootViewController: vc)
            nav.tabBarItem.title = arrTitle[i]
            nav.tabBarItem.image = UIImage(named: arrImage[i])?.withRenderingMode(.alwaysOriginal)
            nav.tabBarItem.selectedImage = UIImage(named: arrseletImage[i])?.withRenderingMode(.alwaysOriginal)
//            nav.navigationBar.barTintColor = kNavColor  //navigationBar的颜色
//            nav.navigationBar.tintColor = UIColor.white   //返回按钮的颜色
//            nav.navigationBar.titleTextAttributes = {[
//                NSAttributedString.Key.foregroundColor: UIColor.white,
//                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
//                ]}()
            arrNav.append(nav)
        }
        
        viewControllers = arrNav
        tabBar.barTintColor = kNavColor   //tabBar的颜色
        tabBar.tintColor = UIColor.gray        //tabBar的字体颜色
        tabBar.isTranslucent = false
        
        tabBar.layer.borderWidth = 0.3;
        tabBar.layer.borderColor = UIColor.white.cgColor
        tabBar.barStyle = .blackOpaque
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabBar.layer.shadowOpacity = 0.3
        
    }
    
    func addChildViewController(vc:UIViewController,title:String,image:String,selectedImage:String) {
        vc.view.backgroundColor = UIColor.red
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: image)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)
        self.addChild(vc)
    }
}
