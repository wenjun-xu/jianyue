//
//  BaseNavgationController.swift
//  LiaoLiao
//
//  Created by 徐庆标 on 2018/12/24.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

class BaseNavgationController: UINavigationController {
    fileprivate var isEnableEdegePan = true
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.interactivePopGestureRecognizer?.delegate = self
//        self.delegate = self
    }
    
//    /// 启用、禁用屏幕边缘侧滑手势
//    func enableScreenEdgePanGestureRecognizer(_ isEnable: Bool) {
//
//        isEnableEdegePan = isEnable
//    }
//
//    /// 获取屏幕边缘侧滑手势
//    func getScreenEdgePanGestureRecognizer() -> UIScreenEdgePanGestureRecognizer? {
//
//        var edgePan: UIScreenEdgePanGestureRecognizer?
//        if let recognizers = view.gestureRecognizers, recognizers.count > 0 {
//            for recognizer in recognizers {
//                if recognizer is UIScreenEdgePanGestureRecognizer {
//                    edgePan = recognizer as? UIScreenEdgePanGestureRecognizer
//                    break
//                }
//            }
//        }
//        return edgePan
//    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        UIApplication.shared.keyWindow?.endEditing(true)
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            //设置统一的返回按钮
            let backBtn = BackButton(target: self, action: #selector(backBtnClicked))
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        }
        super.pushViewController(viewController, animated: true)
    }
    
    // 导航栏返回按钮点击
    @objc fileprivate func backBtnClicked() {
        popViewController(animated: true)
    }

    //如果UIViewController是存在于自定义的UINavigationController中，需要在自定义的UINavigationController中重写childForStatusBarHidden和childForStatusBarStyle两个方法:为什么要重写这个东西呢？
   // 因为这两个方法默认返回值是nil。
   // 也就是当我们调用setNeedsStatusBarAppearanceUpdate的时候,系统会调用Container(容器控制器)的preferredStatusBarStyle这个方法(window?.rootViewController的preferred的方法,一般我们用UINavigationController或者UITabBarController来做Container),也就是根本不会调用子控制器(我们所看到的UIViewcontroller)的preferredStatusBarStyle方法。
    //这个时候childForStatusBarHidden和childForStatusBarStyle两个方法就派上用场了。
    
//    override var childForStatusBarHidden: UIViewController? {
//        return self.topViewController
//    }
//
//    override var childForStatusBarStyle: UIViewController? {
//        return self.topViewController
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension BaseNavgationController : UINavigationControllerDelegate, UIGestureRecognizerDelegate{
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//
//        if !isEnableEdegePan { // 禁用边缘侧滑手势
//            return false
//        }
//        return children.count > 1
//    }
//
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//
//        if viewControllers.count == 1 { // 回到首页，打开左侧抽屉手势
//
//        }
//    }
//}
