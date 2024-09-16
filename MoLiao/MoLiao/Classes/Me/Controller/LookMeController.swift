//
//  LookMeController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/18.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
class LookMeController: BaseViewController {
    fileprivate var arrDataCommon = [WJDynamicModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView!.height = kScreenHeight - kNavH - kStatusBarH
        tableView!.register(LookMeCell.self, forCellReuseIdentifier: "LookMeCell")
        let strDataPath = Bundle.main.path(forResource: "dynamic", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        let json = DataJson().data2JSON(data: data as! Data)
        buildWJDynamicModelByJson(json["data"])
    }
    
    
    func buildWJDynamicModelByJson(_ json: JSON){
        print("json==",json)
        self.arrDataCommon.removeAll()
        for item in json.arrayValue {
            let model = WJDynamicModel()
            model.Title = item["Title"].stringValue
            model.Content = item["Content"].stringValue
            model.isZan = item["isZan"].boolValue
            model.isGuanZhu = item["isGuanZhu"].boolValue
            model.isPingLun = item["isPingLun"].boolValue
            model.Picture = item["Picture"].stringValue
            model.topOneTitle = item["topOneTitle"].stringValue
            model.topTwoTitle = item["topTwoTitle"].stringValue
            model.topThreeTitle = item["topThreeTitle"].stringValue
            model.pinglunNumber = item["pinglunNumber"].intValue
            model.zanNumber = item["zanNumber"].intValue
            self.arrDataCommon.append(model)
        }
    }
    
    
    @objc func rightClick() {
        let vc = WJDynamicNewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDataCommon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "LookMeCell") as? LookMeCell
        if (cell == nil) {
            cell = LookMeCell(style: .default, reuseIdentifier: "LookMeCell")
        }
        cell?.selectionStyle = .none
        cell?.separatorInset = UIEdgeInsets.init(top: 0, left: kScreenWidth, bottom: 0, right: 0)
        let model = arrDataCommon[indexPath.row]
        cell?.userName.text = model.Title
        cell?.userImg.image = UIImage(named: model.Picture)
        cell?.topOneLabel.text = model.topOneTitle
        cell?.topTwoLabel.text = "| " + model.topTwoTitle
        cell?.topThreeLabel.text = "| " +  model.topThreeTitle
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OtherInformationController()
        vc.isNavHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
