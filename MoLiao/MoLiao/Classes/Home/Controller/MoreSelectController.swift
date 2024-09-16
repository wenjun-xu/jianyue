//
//  MoreSelectController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/29.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
class MoreSelectController: BaseViewController {
    fileprivate var arrDataCommon = [HomeModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title  = "更多精选"
        tableView!.separatorStyle = .none//去除分割线
        tableView!.register(HomeCell.self, forCellReuseIdentifier: "HomeCell")
        let strDataPath = Bundle.main.path(forResource: "home", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        let json = DataJson().data2JSON(data: data! as Data)
        buildModelCommonByJson(json["data"])
        
    }
    
    
    func buildModelCommonByJson(_ json: JSON){
        print("json==",json)
//        self.arrDataCommon.removeAll()
//        for item in json.arrayValue {
//            let model = HomeCellModel()
//            model.Title = item["Title"].stringValue
//            model.Content = item["Content"].stringValue
//            model.isHuiYuan = item["isHuiYuan"].boolValue
//            model.isDuBai = item["isDuBai"].boolValue
//            model.Picture = item["Picture"].stringValue
//            model.topOneTitle = item["topOneTitle"].stringValue
//            model.topTwoTitle = item["topTwoTitle"].stringValue
//            model.topThreeTitle = item["topThreeTitle"].stringValue
//            model.centerOneTitle = item["centerOneTitle"].stringValue
//            model.centerTwoTitle = item["centerTwoTitle"].stringValue
//            model.centerThreeTitle = item["centerThreeTitle"].stringValue
//            self.arrDataCommon.append(model)
//        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDataCommon.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell
        if (cell == nil) {
            cell = HomeCell(style: .default, reuseIdentifier: "HomeCell")
            
        }
        cell?.selectionStyle = .none
        let model = arrDataCommon[indexPath.row]
//        cell?.model = model
//        cell?.topOneLabel.text = model.topTwoTitle
//        cell?.topTwoLabel.text = "| " + model.topThreeTitle
//        cell?.topThreeLabel.text = "| " +  model.centerTwoTitle
//        cell?.centerOneLabel.text = "| " + model.topOneTitle
//        cell?.userImg.image = UIImage(named: model.Picture)
//        cell?.img_NameLabel.text = model.Title
//        cell?.img_BottomLabel.text = model.Content
//        if model.isHuiYuan {
//            cell?.img_huiyuan.isHidden = false
//        }else {
//            cell?.img_huiyuan.isHidden = true
//        }
        
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OtherInformationController()
        vc.isNavHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
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
