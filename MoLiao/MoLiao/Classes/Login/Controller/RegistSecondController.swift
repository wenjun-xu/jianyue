//
//  RegistSecondController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/7.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import BRPickerView
class RegistSecondController: BaseViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(2/7)"
        view.backgroundColor = kBgColor
        let bgView = UIView.init(frame: CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace))
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        view.addSubview(bgView)
        
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 80, width: bgView.width, height: 40))
        topTitle.text = "你的出生日期是"
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)
        
        let datepicker = UIDatePicker()
        datepicker.frame = CGRect(x: 12, y: topTitle.bottomY + 40, width: kScreenWidth - 24 - 2*kBgViewSpace, height: 200)
        bgView.addSubview(datepicker)
        let oneYear = TimeInterval(60 * 60 * 24 * 365)
        let nowYear = TimeInterval(60 * 60 * 24 * 365 * 31)
        let new1971 = Date(timeIntervalSince1970: oneYear)
        let new2020 = Date(timeIntervalSince1970: nowYear)

        datepicker.minimumDate = new1971
        datepicker.maximumDate = new2020
        datepicker.datePickerMode = .date
        datepicker.locale = Locale.init(identifier: "zh")
        datepicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)

        let nextBtn = UIButton.init(type: .custom)
        nextBtn.frame = CGRect(x: 20, y: kScreenHeight - kStatusBarH - kNavH - 100, width: kScreenWidth - 40 - 2*kBgViewSpace, height: 45)
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.layer.cornerRadius = 8
        nextBtn.clipsToBounds = true
        nextBtn.backgroundColor = kNavColor
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        bgView.addSubview(nextBtn)
    }
    // MARK: - 日期选择器响应方法
    @objc func dateChanged(datePicker:UIDatePicker)
    {
        // 更新提醒时间文本框
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let date = datePicker.date
        _ = formatter.string(from: date)
        
    }
    

    @objc func nextClick() {
        let vc = RegistThreeController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}























































