//
//  RegistCompanyAreaController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

/// "完善信息(4/7)" - 工作地区
class RegistCompanyAreaController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(4/7)"
        
        view.backgroundColor = kBgColor
        
        
        let companyAreaView = MLRegistCompanyAreaView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        companyAreaView.delegate = self
        self.view.addSubview(companyAreaView)
        
    }
}

extension RegistCompanyAreaController: MLRegistCompanyAreaViewDelegate {
    func companyAreaBtnClick(pageView: MLRegistCompanyAreaView, area: String) {
        
        print("公司地址 = \(area)")
        
        let vc = RegistEducationController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
