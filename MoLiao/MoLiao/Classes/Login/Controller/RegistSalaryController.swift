//
//  RegistSalaryController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

/// "完善信息(7/7)" - 收入
class RegistSalaryController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(7/7)"
        view.backgroundColor = kBgColor

        let salaryView = MLRegistSalaryView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        salaryView.delegate = self
        self.view.addSubview(salaryView)
    }
}

extension RegistSalaryController: MLRegistSalaryViewDelegate {
    func salaryBtnClick(pageView: MLRegistSalaryView, salary: String) {
        print("salary = \(salary)")
        let vc = AccountViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
