//
//  ShezhiViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/21.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
class ShezhiViewController: BaseViewController {
    private var topTitle = ["更换手机号","修改密码"]
    private var topImgArr = ["standard-service","iconfontdongtaidianji"]
    private var arrTitle = ["意见反馈","不良信息举报","清除缓存"]
    private var arrImg = ["kanguo","guanzhu","zan"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        tableView!.height = kScreenHeight - kNavH - kStatusBarH
        tableView!.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else if section == 1 {
            return 3
        }
        return 1
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let otherHomeNewsCell = "gonggaoHomeNewsCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: otherHomeNewsCell)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: otherHomeNewsCell)
        }
        cell?.backgroundColor = UIColor.white.alpha(0.8)
        cell?.selectionStyle = .none
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        if indexPath.section == 0 {
            cell?.textLabel?.text = topTitle[indexPath.row]
        }else if indexPath.section == 1 {
            cell?.textLabel?.text = arrTitle[indexPath.row]
        }else {
            cell?.addSubview(addOutView())
        }        
        return cell!
    }
    func addOutView() -> UIView {
        let outV = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
       let btn = UIButton.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
        btn.setTitle("退出登录", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        outV.addSubview(btn)
        outV.backgroundColor = UIColor.white
        return outV
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let vc = ChooseFriendController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let vc = LookSegmentController()
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                
            }
        }
    }
}
