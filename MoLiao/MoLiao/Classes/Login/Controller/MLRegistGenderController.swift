//
//  MLRegistGenderController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/7.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import BRPickerView

/// 完善信息 - 性别选择
class MLRegistGenderController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(1/7)"
        view.backgroundColor = kBgColor

        let codeView = MLRegistGenderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        codeView.delegate = self
        self.view.addSubview(codeView)
    }
}

// MARK:- MLRegistGenderViewDelegate
extension MLRegistGenderController: MLRegistGenderViewDelegate {
    func genderBtnClick(pageView: MLRegistGenderView, gender: typeGender) {
        let vc = RegistBirthdayController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
