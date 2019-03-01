//
//  BaseViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/24.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit
//#define GestureEnable 1
let GestureEnable = true
class BaseViewController: UIViewController ,UIGestureRecognizerDelegate{
    var navView:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false //0点在导航栏下面
        creatNavigationBarColor(barTintColor: kNavColor, tintColor: UIColor.black.alpha(0.8), barTitleColor: UIColor.black)
    }
   
    
    func creatNavigationBarColor(barTintColor:UIColor,tintColor:UIColor,barTitleColor:UIColor){
//        navigationController?.navigationBar.shadowImage = UIImage.init()
        navigationController?.navigationBar.barTintColor = barTintColor  //navigationBar的颜色
        navigationController?.navigationBar.tintColor = tintColor   //返回按钮的颜色
        navigationController?.navigationBar.titleTextAttributes = {[
            NSAttributedString.Key.foregroundColor: barTitleColor,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
            ]}()
    }
}
