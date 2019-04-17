//
//  RegistStatureController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

/// "完善信息(3/7)" - 身高
class RegistStatureController: BaseViewController {
  
    var rulerView:TDScrollRulerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(3/7)"
        
        view.backgroundColor = kBgColor
        
        let heightView = MLRegistStatureView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        heightView.delegate = self
        self.view.addSubview(heightView)
    }
    
}

extension RegistStatureController:MLRegistStatureViewDelegate {
    func statureBtnClick(pageView: MLRegistStatureView, height: String) {
        print("height = \(height)")
        let vc = RegistCompanyAreaController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}






































