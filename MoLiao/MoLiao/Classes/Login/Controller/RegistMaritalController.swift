//
//  RegistMaritalController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

/// "完善信息(6/7)" - 婚姻状况
class RegistMaritalController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(6/7)"
        view.backgroundColor = kBgColor

        
        let educationView = MLRegistMaritalView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        educationView.delegate = self
        self.view.addSubview(educationView)
    }
}

extension RegistMaritalController: MLRegistMaritalViewDelegate {
    func maritalClick(pageView: MLRegistMaritalView, education: String) {
        let vc = RegistSevenController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
