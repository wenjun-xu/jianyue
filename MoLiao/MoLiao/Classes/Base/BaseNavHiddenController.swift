//
//  BaseNavHiddenController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/17.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class BaseNavHiddenController: BaseViewController {
    var aTableView = UITableView()
    var naviView = UIView()
    var navTitle = ""
    fileprivate var tuijianlabel = UILabel()
    fileprivate var sousuo = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.isTranslucent = false //0点在导航栏下面
        
        buildBaseTableView()
        
        naviView.frame = CGRect(x: 0, y: 0, width:kScreenWidth, height:  kNavH + kStatusBarH)
        naviView.backgroundColor = kNavColor
        tuijianlabel = UILabel.init(frame: CGRect(x: (kScreenWidth - 100) / 2.0, y: 8 + kStatusBarH, width: 100, height: 22))
        tuijianlabel.textColor = UIColor.white
        tuijianlabel.textAlignment = .center
        tuijianlabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        naviView.addSubview(tuijianlabel)
        
        let sousuoView = UIView.init(frame: CGRect(x: 15, y: kStatusBarH, width: kNavH, height: kNavH))
        naviView.addSubview(sousuoView)
        sousuo = UIImageView.init(frame: CGRect(x: 0, y: 8, width: 21, height: 21))
        sousuo.image = UIImage(named:"nav_back")
        sousuoView.addSubview(sousuo)
        view.addSubview(naviView)
        
    }
    
    func buildBaseTableView() {
        //        self.navigationController?.navigationBar.isTranslucent = true //0点在导航栏
        
        aTableView = UITableView(frame: CGRect.init(x: 0, y: kNavH + kStatusBarH, width: kScreenWidth, height: kScreenHeight - kNavH - kStatusBarH), style: .plain)
        aTableView.dataSource = self
        aTableView.delegate = self
        aTableView.tableFooterView = UIView()
        aTableView.tableHeaderView = UIView()
        aTableView.separatorStyle = .singleLine
        aTableView.backgroundColor = kBgColor
        view.addSubview(aTableView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tuijianlabel.text = navTitle
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
