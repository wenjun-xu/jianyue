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

class BaseViewController: UIViewController,UIGestureRecognizerDelegate{
    var tableView: UITableView?
    
    let itemX:CGFloat = 80
    
    /// 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    
    
    /// 自定义导航条目
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        /// 取消侧滑返回
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override var title: String? {
        didSet{
            navItem.title = title
        }
    }
    
    func hideKeyboard() {
        
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

// MARK:- UI创建
extension BaseViewController {
    
    fileprivate func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        // 取消自动缩进
        automaticallyAdjustsScrollViewInsets = false
        
        if #available(iOS 11.0, *) {
            navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 64))
            // 设置状态栏
            let vi : UIWindow = UIApplication.shared.value(forKey: "statusBarWindow") as! UIWindow
            let v : UIView = vi.value(forKey: "statusBar") as! UIView
//            v.backgroundColor = UIColor(red: 4/255.0, green: 137/255.0, blue: 185/255.0, alpha: 1)
        }
        
        setupNavigationBar()
        
        setupTableView()
    }
    
    /// 设置导航条
    fileprivate func setupNavigationBar() {
        // 添加导航条
        view.addSubview(navigationBar)
        // 将item 设置给bar
        navigationBar.items = [navItem]
        // 不透明
        navigationBar.isTranslucent = false
        // 设置navBar背景颜色
        navigationBar.barTintColor = UIColor(red: 4/255.0, green: 137/255.0, blue: 185/255.0, alpha: 1)
        // 设置navBar 字体颜色
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // 设置系统按钮的文字渲染颜色
        navigationBar.tintColor = UIColor.orange
    }
    
    /// 设置表格视图
    public func setupTableView() {
        tableView = UITableView(frame:view.bounds,style:.plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        let tableBGV = UIImageView(image: UIImage(named: "pic_bg"))
        tableBGV.isUserInteractionEnabled = true
        tableView?.backgroundView = tableBGV
        
        // 设置数据源和代理
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = .none
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                               right: 0)
        //MARK: - 10.22
        if #available(iOS 11.0, *) {
            tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height-20,
                                                   left: 0,
                                                   bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                                   right: 0)
        }
        
        tableView?.scrollIndicatorInsets = (tableView?.contentInset)!
    }
    
    public func setupLoad() {
        print("网络请求")
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension BaseViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// 点击其他地方，键盘取消
        tableView.endEditing(true)
    }
}



extension BaseViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
