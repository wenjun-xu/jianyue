//
//  RegistBirthdayController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/7.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import BRPickerView

/// 完善信息(2/7) - 出生日期
class RegistBirthdayController: BaseViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(2/7)"
        view.backgroundColor = kBgColor
       
    
        let birthdayView = MLRegistBirthdayView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        birthdayView.delegate = self
        self.view.addSubview(birthdayView)
    }
}

extension RegistBirthdayController: MLRegistBirthdayViewDelegate {
    func birthdayBtnClick(pageView: MLRegistBirthdayView, birthday: String) {
        
        print("birthday = \(birthday)")
        
        let vc = RegistStatureController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}























































