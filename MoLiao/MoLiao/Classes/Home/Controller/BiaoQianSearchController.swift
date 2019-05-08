//
//  BiaoQianSearchController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/28.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
class BiaoQianSearchController: BaseViewController {
    fileprivate var biaoqianModels = [BiaoQianModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let strDataPath = Bundle.main.path(forResource: "biaoqian", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        
        let json = DataJson().data2JSON(data: data as! Data)
        buildBiaoqianByJson(json["data"])
        tableView!.register(BiaoQianCell.self, forCellReuseIdentifier: "BiaoQianCell")
        tableView!.showsVerticalScrollIndicator = true
        tableView!.showsHorizontalScrollIndicator = false
        NotificationCenter.default.addObserver(self, selector: #selector(biaoqianshouyRefresh), name: NSNotification.Name(rawValue: "biaoqianshouyRefresh"), object: nil)

    }
    @objc func biaoqianshouyRefresh(notifation:Notification){
        let userInfo = notifation.userInfo
        let aa:String = userInfo!["isScrolleView"] as! String
        if aa == "scrollviewTrue" {
            self.tableView!.isScrollEnabled = true
            self.tableView!.bounces = true
        }else {
            self.tableView!.isScrollEnabled = false
            self.tableView!.bounces = false
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(self.tableView) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "shouyRefresh"), object: self, userInfo: ["isScrolleView":"scrollviewFalse"])

        }else {
            
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "shouyRefresh"), object: self, userInfo: ["isScrolleView":"scrollviewTrue"])

    }
    
    func buildBiaoqianByJson(_ json: JSON){
        self.biaoqianModels.removeAll()
        for item in json.arrayValue {
            let model = BiaoQianModel()
            model.Title = item["Title"].stringValue
            model.Picture = item["Picture"].stringValue
            self.biaoqianModels.append(model)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return biaoqianModels.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "BiaoQianCell") as? BiaoQianCell
        if (cell == nil) {
            cell = BiaoQianCell(style: .default, reuseIdentifier: "BiaoQianCell")
        }
        let model = biaoqianModels[indexPath.row]
        cell?.selectionStyle = .none
        cell!.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
        cell?.centerLabel.text = model.Title
        cell?.img.image = UIImage(named: model.Picture)
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
