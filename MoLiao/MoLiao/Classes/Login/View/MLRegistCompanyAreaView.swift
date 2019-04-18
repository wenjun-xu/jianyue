//
//  MLRegistCompanyAreaView.swift
//  MoLiao
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol MLRegistCompanyAreaViewDelegate: NSObjectProtocol {
    /// 公司所在地
    func companyAreaBtnClick(pageView: MLRegistCompanyAreaView, area: String)
}

///  "完善信息(4/7)" - 工作地区
class MLRegistCompanyAreaView: MLRegistBaseView {

    weak var delegate: MLRegistCompanyAreaViewDelegate?
    
    /// 地址
    private var areaString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTopicView(title: "你的工作地区在哪里")
        setupContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 点击事件
extension MLRegistCompanyAreaView {
    @objc func nextClick() {
        self.delegate?.companyAreaBtnClick(pageView: self, area: areaString)
    }
}

// MARK:- PickerDelegate
extension MLRegistCompanyAreaView: PickerDelegate{
    //MARK: - PickerDelegate
    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
        
        areaString = procince.region_name! + city.region_name! + area.region_name!
        
    }
}

// MARK:- UI创建
extension MLRegistCompanyAreaView {
        
    private func setupContent() {
        
        let pickerView = BHJPickerView.init(self, frame: CGRect(x: 20, y: FRegist_titleY, width: kScreenWidth - 40 - 2*kBgViewSpace, height: 200))
        pickerView.pickerDelegate = self
        bgView.addSubview(pickerView)
        
        let nextBtn = UIButton.init(type: .custom)
        nextBtn.frame = CGRect(x: 20, y: kScreenHeight - kStatusBarH - kNavH - 100, width: kScreenWidth - 40 - 2*kBgViewSpace, height: 45)
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.layer.cornerRadius = 8
        nextBtn.clipsToBounds = true
        nextBtn.backgroundColor = UIColor.blue //kNavColor
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        bgView.addSubview(nextBtn)
        // Do any additional setup after loading the view.
    }
}
