//
//  ConditionSearchController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/28.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit
import BRPickerView
class ConditionSearchController: BaseViewController {

    private var arrTitle = ["身高","年龄","年收入","工作地区","星座","籍贯","学历","职业","住房情况","婚姻状况"]
    private var shengaoSource = ["150com-155com","155com-160com","160com-165com","165com-170com","170com-175com","175com-180com","180com-185com"]
    private var nianlingSource = ["不限","18岁-20岁","20岁-25岁","25岁-30岁","30岁-35岁","35岁-40岁","40岁-45岁","45岁-50岁"]
    private var shouruSource = ["5W-10W","10W-15W","15W-20W","20W-25W","25W-30W","30W-35W","35W-40W","40W-45W","45W-50W","50W-100W"]
    private var gongzuodiquSource = ["处女座","摩羯座","白羊座","天秤座","巨蟹座","水瓶座","金牛座","双子座"]
    private var xingzuoSource = ["处女座","摩羯座","白羊座","天秤座","巨蟹座","水瓶座","金牛座","双子座"]
    private var jiguanSource = ["处女座","摩羯座","白羊座","天秤座","巨蟹座","水瓶座","金牛座","双子座"]
    private var xueliSource = ["大专以下", "大专","本科", "硕士", "博士", "博士后"]
    private var zhiyeSource = ["不限","销售","客户服务","计算机/互联网","通信/电子","生产/制造","物流/仓储","商贸/采购","人事行政","高级管理","广告/市场","传媒/艺术","生物/制药","医疗/护理","金融/银行/保险","建筑/房地产","咨询/顾问","法律","财会/审计","教育/科研","服务业","交通运输","政府机构","军人/警察","自由职业","在校学生","待业","模特","其他职业"]
    private var zhufangSource = ["不限","和家人同住","已购房","租房","打算婚后购房","住在宿舍单位"]
    private var hunyinSource = ["不限","未婚","离异","丧偶"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索"
        tableView!.register(ConditionSearchCell.self, forCellReuseIdentifier: "ConditionSearchCell")
        tableView!.showsVerticalScrollIndicator = true
        tableView!.showsHorizontalScrollIndicator = false
        
        let btnView = UIView.init(frame: CGRect(x: 0, y: kScreenHeight - 50 - kNavH - kStatusBarH, width: kScreenWidth, height: 50))
        btnView.backgroundColor = UIColor.red
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.setTitle("重置", for: .normal)
        leftBtn.backgroundColor = UIColor(red: 216/255.0, green: 170/255.0, blue: 100/255.0, alpha: 1)
        leftBtn.frame = CGRect(x: 0, y: 0, width: kScreenWidth / 2.0, height: 50)
        btnView.addSubview(leftBtn)
        let rightBtn = UIButton.init(type: .custom)
        rightBtn.setTitle("确定", for: .normal)
        rightBtn.backgroundColor = UIColor(red: 60/255.0, green: 63/255.0, blue: 80/255.0, alpha: 1)
        rightBtn.frame = CGRect(x: kScreenWidth / 2.0, y: 0, width: kScreenWidth / 2.0, height: 50)
        btnView.addSubview(rightBtn)
        view.addSubview(btnView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ConditionSearchCell") as? ConditionSearchCell
        if (cell == nil) {
            cell = ConditionSearchCell(style: .default, reuseIdentifier: "ConditionSearchCell")
        }
        cell?.selectionStyle = .none
        cell?.leftLabel.text = arrTitle[indexPath.row]
        cell?.rightLabel.text = "不限"
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:ConditionSearchCell = tableView.cellForRow(at: indexPath) as! ConditionSearchCell
        if indexPath.row == 0 {
            BRStringPickerView.showStringPicker(withTitle: "身高", dataSource: shengaoSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (nianlingStr) in
                let aaaa = nianlingStr as! String
                cell.rightLabel.text = aaaa
//                cell.rightLabel.text = "\(aaaa[0] as! String)-\(aaaa[1] as! String)"
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }
        }else if indexPath.row == 1 {
            BRStringPickerView.showStringPicker(withTitle: "年龄", dataSource: nianlingSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (nianlingStr) in
//                let aaaa = nianlingStr as! Array<Any>
//                cell.rightLabel.text = "\(aaaa[0] as! String)-\(aaaa[1] as! String)"
                let aaaa = nianlingStr as! String
                cell.rightLabel.text = aaaa
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }
            
        }else if indexPath.row == 2 {
            BRStringPickerView.showStringPicker(withTitle: "年收入", dataSource: shouruSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = xueliStr as? String
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }
        }else if indexPath.row == 3 {
            
            BRAddressPickerView.showAddressPicker(withShowType: .city, defaultSelected: nil, isAutoSelect: true, themeColor: picViewColor, resultBlock: { (province, city, area) in
                let str1 = province?.name
                let str2 = city?.name
                cell.rightLabel.text = str1! + " " + str2!
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }) {
                
            }
        }else if indexPath.row == 4 {
            BRStringPickerView.showStringPicker(withTitle: "星座", dataSource: xingzuoSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = xueliStr as? String
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }
        }else if indexPath.row == 5 {
            
            BRAddressPickerView.showAddressPicker(withShowType: .city, defaultSelected: nil, isAutoSelect: true, themeColor: picViewColor, resultBlock: { (province, city, area) in
                let str1 = province?.name
                let str2 = city?.name
                cell.rightLabel.text = str1! + " " + str2!
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }) {
                
            }
        }
        else if indexPath.row == 6 {
            BRStringPickerView.showStringPicker(withTitle: "学历", dataSource: xueliSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = xueliStr as? String
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }
        }else if indexPath.row == 7 {
            BRStringPickerView.showStringPicker(withTitle: "职业", dataSource: zhiyeSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = xueliStr as? String
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }
        }else if indexPath.row == 8 {
            BRStringPickerView.showStringPicker(withTitle: "住房情况", dataSource: zhufangSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = (xueliStr as! String)
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }
        }else if indexPath.row == 9 {
            BRStringPickerView.showStringPicker(withTitle: "婚姻状况", dataSource: hunyinSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                cell.rightLabel.text = (xueliStr as! String)
                cell.rightLabel.textColor = UIColor(red: 218/255.0, green: 172/255.0, blue: 102/255.0, alpha: 1)
            }
        }
        
    }
    

}
