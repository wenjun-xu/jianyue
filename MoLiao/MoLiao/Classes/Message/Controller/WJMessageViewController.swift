//
//  WJMessageViewController.swift
//  LiaoLiao
//
//  Created by 徐庆标 on 2018/12/24.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
class WJMessageViewController: MyLikeController {
    fileprivate var arrDataCommon = [MessageModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView!.height = kScreenHeight - kNavH - kStatusBarH - kTabbarHeight
        tableView!.register(MessageCell.self, forCellReuseIdentifier: "MessageCell")

        let strDataPath = Bundle.main.path(forResource: "message", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        
        let json = DataJson().data2JSON(data: data! as Data)
        buildMessageByJson(json["data"])
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false //0点在导航栏下面
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        return arrDataCommon.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell") as? MessageCell
        if (cell == nil) {
            cell = MessageCell(style: .default, reuseIdentifier: "MessageCell")
        }
        cell?.selectionStyle = .none
       let model = arrDataCommon[indexPath.section]
        cell?.userNameLabel.text = model.Title
        cell?.contentLabel.text = model.Content
        cell?.timeLabel.text = model.Time
        if model.xiaoxiNumber == 0 {
            cell?.xiaoxiLabel.isHidden = true
        }else {
            cell?.xiaoxiLabel.text = model.xiaoxiNumber.description
        }
        cell?.userImg.image = UIImage(named: model.Picture)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 1
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = EaseMessageViewController.init(conversationChatter: "xuwenjun", conversationType: .init(0))
        let vc = ConverListViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
