//
//  WJMeDetailController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/1.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
import BRPickerView
import TZImagePickerController

class WJMeDetailController: BaseViewController, TZImagePickerControllerDelegate{
    var userImg:UIImage!
    fileprivate var arrDataCommon = [MessageModel]()
    private let topScetionStyle = [FoundStyle.top,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.bottom];
    private let bottomScetionStyle = [FoundStyle.top,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.normal,FoundStyle.bottom];

    var toptitleArr = ["头像","昵称","性别","生日","内心独白"]
    var topRightTitleArr = ["女","1991-08-08","我的一生"]
    var bottomArr = ["身高","年收入","工作地区","学历","婚姻状况","职业","籍贯","星座"]
    var titleArr = ["170com","8000-10000","北京","本科","未婚","测试工程师","山东济南","白羊座"]
    private var shengaoSource = ["150com-155com","155com-160com","160com-165com","165com-170com","170com-175com","175com-180com","180com-185com"]
    private var nianlingSource = ["18岁-20岁","20岁-25岁","25岁-30岁","30岁-35岁","35岁-40岁","40岁-45岁","45岁-50岁"]
    private var shouruSource = ["5W-10W","10W-15W","15W-20W","20W-25W","25W-30W","30W-35W","35W-40W","40W-45W","45W-50W","50W-100W"]
    private var gongzuodiquSource = ["处女座","摩羯座","白羊座","天秤座","巨蟹座","水瓶座","金牛座","双子座"]
    private var xingzuoSource = ["处女座","摩羯座","白羊座","天秤座","巨蟹座","水瓶座","金牛座","双子座"]
    private var jiguanSource = ["处女座","摩羯座","白羊座","天秤座","巨蟹座","水瓶座","金牛座","双子座"]
    private var xueliSource = ["大专以下", "大专","本科", "硕士", "博士", "博士后"]
    private var zhiyeSource = ["销售","客户服务","计算机/互联网","通信/电子","生产/制造","物流/仓储","商贸/采购","人事行政","高级管理","广告/市场","传媒/艺术","生物/制药","医疗/护理","金融/银行/保险","建筑/房地产","咨询/顾问","法律","财会/审计","教育/科研","服务业","交通运输","政府机构","军人/警察","自由职业","在校学生","待业","模特","其他职业"]
    private var zhufangSource = ["和家人同住","已购房","租房","打算婚后购房","住在宿舍单位"]
    private var hunyinSource = ["未婚","离异","丧偶"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的资料"
        
        let rightBarButtonItem = UIBarButtonItem(title: "保存", style: .done, target: self, action: #selector(rightClick))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.tableView!.height = kScreenHeight - kNavH - kStatusBarH
        tableView!.register(MeDetailCell.self, forCellReuseIdentifier: "MeDetailCell")
        
        let strDataPath = Bundle.main.path(forResource: "message", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        
        let json = DataJson().data2JSON(data: data! as Data)
        buildMessageByJson(json["data"])
    }
    
    @objc func rightClick() {
        let vc = WJDynamicNewController()
        navigationController?.pushViewController(vc, animated: true)
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return toptitleArr.count
        }else {
            return bottomArr.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MeDetailCell") as? MeDetailCell
//        if (cell == nil) {
            cell = MeDetailCell(style: .default, reuseIdentifier: "MeDetailCell")
//        }
        cell?.selectionStyle = .none
        cell!.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
        cell?.leftLabel.textColor = UIColor.gray
        cell?.rightLabel.textColor = UIColor.gray
        cell?.rightTextView.textColor = UIColor.gray
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell!.iconImg.isHidden = false
                if userImg == nil {
                    
                }else {
                    cell?.iconImg.image = userImg
                }
                cell?.rightLabel.text = ""
            }else {
                if indexPath.row == 1 {
                    cell?.rightTextView.isHidden = false
                    cell?.rightLabel.isHidden = true
                }else {
                    cell?.rightTextView.isHidden = true
                    cell?.rightLabel.isHidden = false
                    cell?.rightLabel.text = topRightTitleArr[indexPath.row - 2]
                }
                cell!.iconImg.isHidden = true
            }
            cell!.cellStyle = topScetionStyle[indexPath.row]
            cell?.leftLabel.text = toptitleArr[indexPath.row]

        }else if indexPath.section == 1 {
            cell?.iconImg.isHidden = true
            cell!.cellStyle = bottomScetionStyle[indexPath.row]
            cell?.leftLabel.text = bottomArr[indexPath.row]
            cell?.rightLabel.text = titleArr[indexPath.row]
        }
       
        return cell!
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 120
            }else {
                return 50
            }
        }else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool){
        for img in photos {
            userImg = img
        }
        self.tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:MeDetailCell = tableView.cellForRow(at: indexPath) as! MeDetailCell

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let option1 = SelectViewInfo(title: "更换用户头像", color: UIColor.black)
                let option2 = SelectViewInfo(title: " ", color: UIColor.green)
                BottomSelectView.show(title: "更换用户头像", options:[option1,option2], cancelTitle: nil, selectCallBack: { index in
                    if index == 0  {
                        let imagePickerVc = TZImagePickerController.init(maxImagesCount: 1, columnNumber: 3, delegate: self, pushPhotoPickerVc: true)
                        imagePickerVc?.allowPickingVideo = false
                        imagePickerVc?.showSelectBtn = false
                        imagePickerVc?.allowCrop = true
                        imagePickerVc?.isStatusBarDefault = false
                        imagePickerVc?.sortAscendingByModificationDate = false
                        self.present(imagePickerVc!, animated: true, completion: nil)
                    }
                })
            }else if indexPath.row == 2 {
                BRStringPickerView.showStringPicker(withTitle: "性别", dataSource: ["男","女"], defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (nianlingStr) in
                    let aaaa = nianlingStr as! String
                    cell.rightLabel.text = aaaa
                }
            }else if indexPath.row == 3 {
                BRDatePickerView.showDatePicker(withTitle: "出生日期", dateType: .YMD, defaultSelValue: nil, minDate: nil, maxDate: nil, isAutoSelect: true, themeColor: picViewColor) { (nianlingStr) in
                    let aaaa = nianlingStr as! String
                    cell.rightLabel.text = aaaa
                }
            }else if indexPath.row == 4 {
                let vc = MonologueViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                BRStringPickerView.showStringPicker(withTitle: "身高", dataSource: shengaoSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (nianlingStr) in
                    let aaaa = nianlingStr as! String
                    cell.rightLabel.text = aaaa
                }
            }else if indexPath.row == 1 {
                BRStringPickerView.showStringPicker(withTitle: "年收入", dataSource: shouruSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                    cell.rightLabel.text = xueliStr as! String
                }
            } else if indexPath.row == 2 {
                BRAddressPickerView.showAddressPicker(withShowType: .city, defaultSelected: nil, isAutoSelect: true, themeColor: picViewColor, resultBlock: { (province, city, area) in
                    let str1 = province?.name
                    let str2 = city?.name
                    cell.rightLabel.text = str1! + " " + str2!
                    
                }) {
                    
                }
            }else if indexPath.row == 3 {
                BRStringPickerView.showStringPicker(withTitle: "学历", dataSource: xueliSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                    cell.rightLabel.text = xueliStr as! String
                }
            }else if indexPath.row == 4 {
                BRStringPickerView.showStringPicker(withTitle: "婚姻状况", dataSource: hunyinSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                    cell.rightLabel.text = xueliStr as! String
                }
            }else if indexPath.row == 5 {
                BRStringPickerView.showStringPicker(withTitle: "职业", dataSource: zhiyeSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                    cell.rightLabel.text = xueliStr as! String
                }
            }else if indexPath.row == 6 {
                BRAddressPickerView.showAddressPicker(withShowType: .city, defaultSelected: nil, isAutoSelect: true, themeColor: picViewColor, resultBlock: { (province, city, area) in
                    let str1 = province?.name
                    let str2 = city?.name
                    cell.rightLabel.text = str1! + " " + str2!
                }) {
                    
                }
            }else if indexPath.row == 7 {
                BRStringPickerView.showStringPicker(withTitle: "星座", dataSource: xingzuoSource, defaultSelValue: nil, isAutoSelect: true, themeColor: picViewColor) { (xueliStr) in
                    cell.rightLabel.text = xueliStr as! String
                }
            }
            
        }
    }
    
}



































