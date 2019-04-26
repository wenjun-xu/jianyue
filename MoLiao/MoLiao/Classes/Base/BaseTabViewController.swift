//
//  BaseTabViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/24.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

class BaseTabViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate {
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false //0点在导航栏下面

        buildBaseTableView()
    }
    
    func buildBaseTableView() {
//        self.navigationController?.navigationBar.isTranslucent = true //0点在导航栏
        
        tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavH - kStatusBarH), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = kBgColor
        view.addSubview(tableView)
    }
}

extension BaseTabViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?{
        return UIView()
    }
    //MARK:   -------- UITableViewDelegate  删除编辑模式  --------
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return false
    }
    
    
    func actRefresh(){
        
    }
    
    func actLoadMore(){
        
    }
}
