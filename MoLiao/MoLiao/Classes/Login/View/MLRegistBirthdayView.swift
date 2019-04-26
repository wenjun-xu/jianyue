//
//  MLRegistBirthdayView.swift
//  MoLiao
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit


protocol MLRegistBirthdayViewDelegate: NSObjectProtocol {
    /// 生日按钮
    func birthdayBtnClick(pageView: MLRegistBirthdayView, birthday: String)
}

/// 完善信息(2/7) - 出生日期
class MLRegistBirthdayView: MLRegistBaseView {
    weak var delegate: MLRegistBirthdayViewDelegate?
    /// 生日
    private var birthdayString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTopicView(title: "你的出生日期是")
        setupContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 点击事件
extension MLRegistBirthdayView {
    // MARK: - 日期选择器响应方法
    @objc func dateChanged(datePicker:UIDatePicker) {
        // 更新提醒时间文本框
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let date = datePicker.date
        let birString = formatter.string(from: date)
        
        birthdayString = birString
    }
    
    @objc func nextClick() {
        
        self.delegate?.birthdayBtnClick(pageView: self, birthday: birthdayString)
    }
}

// MARK:- UI创建
extension MLRegistBirthdayView {    
    private func setupContent() {
        
        let datepicker = UIDatePicker()
        datepicker.frame = CGRect(x: 12, y: FRegist_titleY, width: kScreenWidth - 24 - 2 * kBgViewSpace, height: 200)
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
        nextBtn.backgroundColor = UIColor.blue //kNavColor
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        bgView.addSubview(nextBtn)
    }
}
