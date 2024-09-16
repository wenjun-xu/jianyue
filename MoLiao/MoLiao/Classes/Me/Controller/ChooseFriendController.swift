//
//  ChooseFriendController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/18.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
import BRPickerView
class ChooseFriendController: BaseViewController {
    var userImg:UIImage!
    fileprivate var arrDataCommon = [MessageModel]()
    private let bottomScetionStyle = [FoundStyle.top,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.bottom];
    var bottomArr = ["年龄","身高","月收入","工作地区","学历","婚姻状况","职业","籍贯","星座","住房情况"]
    var titleArr = ["19","170com","8000-10000","北京","本科","未婚","测试工程师","山东济南","白羊座","和家人同住"]
    private var zhufangSource = ["和家人同住","已购房","租房","打算婚后购房","住在宿舍单位"]
    private var hunyinSource = ["未婚","离异","丧偶"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "择偶标准"
       
        let rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(rightClick))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.tableView!.height = kScreenHeight - kNavH - kStatusBarH
        tableView!.register(MeDetailCell.self, forCellReuseIdentifier: "MeDetailCell")
        
        let strDataPath = Bundle.main.path(forResource: "message", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        
        let json = DataJson().data2JSON(data: data as! Data)
        buildMessageByJson(json["data"])
    }
    
    @objc func rightClick() {
        UIView.animate(withDuration: 0.25) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false //0点在导航栏下面
    }
    
    func buildMessageByJson(_ json: JSON){
        self.arrDataCommon.removeAll()
        for item in json.arrayValue {
            let model = MessageModel()
            model.Title = item["Title"].stringValue
            model.Content = item["Content"].stringValue
            model.Picture = item["Picture"].stringValue
            model.Time = item["Time"].stringValue
            model.xiaoxiNumber = item["xiaoxiNumber"].intValue
            self.arrDataCommon.append(model)
        }
        self.tableView!.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bottomArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MeDetailCell") as? MeDetailCell
        cell = MeDetailCell(style: .default, reuseIdentifier: "MeDetailCell")
        cell?.selectionStyle = .none
        cell!.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
        cell?.leftLabel.textColor = UIColor.gray
        cell?.rightLabel.textColor = UIColor.gray
        cell?.rightTextView.textColor = UIColor.gray
        cell?.iconImg.isHidden = true
        cell!.cellStyle = bottomScetionStyle[indexPath.row]
        cell?.leftLabel.text = bottomArr[indexPath.row]
        cell?.rightLabel.text = titleArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:MeDetailCell = tableView.cellForRow(at: indexPath) as! MeDetailCell
        if indexPath.row == 0 {
            let dataSource = [arrWithPlist(string: "myolder"),arrWithPlist(string: "myolder")]
            BRStringPickerView.showStringPicker(withTitle: "年龄", dataSource: dataSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (selectValue) in
                let aaaa = selectValue as! Array<Any>
                cell.rightLabel.text = "\(aaaa[0] as! String)-\(aaaa[1] as! String)"
            }
        }else if indexPath.row == 1 {
            let dataSource = [arrWithPlist(string: "myheight"),arrWithPlist(string: "myheight")]
            BRStringPickerView.showStringPicker(withTitle: "身高", dataSource: dataSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (selectValue) in
                let aaaa = selectValue as! Array<Any>
                cell.rightLabel.text = "\(aaaa[0] as! String)-\(aaaa[1] as! String)"
            }
        }else if indexPath.row == 2 {
           
            let dataSource = [arrWithPlist(string: "yueshouru"),arrWithPlist(string: "yueshouru")]
            BRStringPickerView.showStringPicker(withTitle: "月收入", dataSource: dataSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (selectValue) in
                let aaaa = selectValue as! Array<Any>
                cell.rightLabel.text = "\(aaaa[0] as! String)-\(aaaa[1] as! String)"
            }
            
        } else if indexPath.row == 3 {
            BRAddressPickerView.showAddressPicker(withShowType: .city, defaultSelected: nil, isAutoSelect: true, themeColor: picViewColor, resultBlock: { (province, city, area) in
                let str1 = province?.name
                let str2 = city?.name
                cell.rightLabel.text = str1! + " " + str2!
                
            }) {
                
            }
        }else if indexPath.row == 4 {
            BRStringPickerView.showStringPicker(withTitle: "学历", dataSource: arrWithPlist(string: "xueli"), defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = xueliStr as? String
            }
        }else if indexPath.row == 5 {
            BRStringPickerView.showStringPicker(withTitle: "婚姻状况", dataSource: hunyinSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = xueliStr as? String
            }
        }else if indexPath.row == 6 {
          
            BRStringPickerView.showStringPicker(withTitle: "职业", dataSource: arrWithPlist(string: "zhiye"), defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = xueliStr as? String
            }
        }else if indexPath.row == 7 {
            BRAddressPickerView.showAddressPicker(withShowType: .city, defaultSelected: nil, isAutoSelect: true, themeColor: picViewColor, resultBlock: { (province, city, area) in
                let str1 = province?.name
                let str2 = city?.name
                cell.rightLabel.text = str1! + " " + str2!
            }) {
                
            }
        }else if indexPath.row == 8 {
           
            BRStringPickerView.showStringPicker(withTitle: "星座", dataSource: arrWithPlist(string: "xingzuo"), defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = xueliStr as? String
            }
        }else {
            BRStringPickerView.showStringPicker(withTitle: "住房情况", dataSource: zhufangSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = xueliStr as? String
            }
        }
    }
  
    
}
