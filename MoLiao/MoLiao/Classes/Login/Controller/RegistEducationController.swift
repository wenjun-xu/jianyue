//
//  RegistEducationController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

/// "完善信息(5/7)" - 学历
class RegistEducationController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(5/7)"
        view.backgroundColor = kBgColor
        

        let educationView = MLRegistEducationView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        educationView.delegate = self
        self.view.addSubview(educationView)
    }
}

extension RegistEducationController: MLRegistEducationViewDelegate {
    func educationClick(pageView: MLRegistEducationView, education: String) {
        print("education = \(education)")
        
        let vc = RegistSixController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}







































