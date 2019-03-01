//
//  RegistFiveController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class RegistFiveController: BaseViewController {
    var tempBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(5/7)"
        view.backgroundColor = kBgColor
        let bgView = UIView.init(frame: CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace))
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        view.addSubview(bgView)
        
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 80, width: bgView.width, height: 40))
        topTitle.text = "你的学历是"
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)

        let temptag:Int = UserDefaults.standard.integer(forKey: "temptag")
        let arrTitle = ["高中及以下","中专","大专","大学本科","硕士","博士"]
        for i in 1..<7 {
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect(x: 20, y:150 + 50*(i - 1), width: Int(bgView.width - 40), height: 40)
            btn.layer.cornerRadius = 5
            btn.clipsToBounds = true
            btn.layer.borderColor = kNavColor.cgColor
            btn.layer.borderWidth = 0.4
            btn.setTitle(arrTitle[i - 1], for: .normal)
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            btn.addTarget(self, action: #selector(clickAction(sender:)), for: .touchUpInside)
            btn.tag = i
            if i == temptag {
                btn.isSelected = true
                btn.backgroundColor = kNavColor
                tempBtn = btn
            }
            
            bgView.addSubview(btn)
        }
        
    }
    
    @objc func clickAction(sender:UIButton)  {
        if tempBtn == nil {
            sender.isSelected = true
            tempBtn = sender
            tempBtn.backgroundColor = kNavColor

        }else if (tempBtn != nil && tempBtn == sender){
            sender.isSelected = true
            sender.backgroundColor = kNavColor
        }else if (tempBtn != sender && tempBtn != nil) {
            tempBtn.isSelected = false
            sender.isSelected = true
            tempBtn.backgroundColor = UIColor.clear
            sender.backgroundColor = kNavColor
            tempBtn = sender
        }
        UserDefaults.standard.set(sender.tag, forKey: "temptag")
        let vc = RegistSixController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}







































