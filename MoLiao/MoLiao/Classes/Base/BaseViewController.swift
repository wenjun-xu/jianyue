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

extension BaseViewController {
    
    /// 导航栏左侧按钮 - 图片形式
    public func setupLeftBarItem(leftImage: String = "nav_back") -> UIBarButtonItem {
        let leftBarItem = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        leftBarItem.setImage(UIImage(named:leftImage), for: .normal)
        //leftBarItem.
        leftBarItem.addTarget(self, action: #selector(setupLeftBarItemClick), for: .touchUpInside)
        return UIBarButtonItem(customView: leftBarItem)
    }
    
    /// 导航栏右侧按钮 - 图片形式
    public func setupRightIconBarItem(rightImage: String) -> UIBarButtonItem{
        let rightItem = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        rightItem.setImage(UIImage(named:rightImage), for: .normal)
        rightItem.addTarget(self, action: #selector(setupRightBarItemClick), for: .touchUpInside)
        return UIBarButtonItem(customView: rightItem)
    }
    
    /// 导航栏右侧按钮 - 文字形式
    public func setupRightIconBarItem(rightTitle: String) -> UIBarButtonItem{
        let rightItem = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 20))
//        rightItem.setImage(UIImage(named:rightImage), for: .normal)
        rightItem.setTitle(rightTitle, for: .normal)
        rightItem.setTitleColor(kWangjiColor, for: .normal)
        rightItem.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        rightItem.addTarget(self, action: #selector(setupRightBarItemClick), for: .touchUpInside)
        return UIBarButtonItem(customView: rightItem)
    }
    
    /// 导航栏左侧按钮的点击事件
    @objc public func setupLeftBarItemClick() {
        
    }
    
    /// 导航栏右侧按钮的点击事件
    @objc public func setupRightBarItemClick() {
        
    }
}
