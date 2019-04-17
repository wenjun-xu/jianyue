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
    func companyAreaBtnClick(pageView: MLRegistCompanyAreaView, height: String)
}

///  "完善信息(4/7)" - 工作地区
class MLRegistCompanyAreaView: UIView {
    private let bgView = UIView()
    weak var delegate: MLRegistCompanyAreaViewDelegate?
    /// 身高
    private var heightString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBGView()
        
        setupContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MLRegistCompanyAreaView: PickerDelegate{
    //MARK: - PickerDelegate
    func selectedAddress(_ pickerView: BHJPickerView, _ procince: AddressModel, _ city: AddressModel, _ area: AddressModel) {
        
        let messge = procince.region_name! + city.region_name! + area.region_name!
        print("messge==",messge)
    }
}

extension MLRegistCompanyAreaView {
    
    private func setupBGView() {
        bgView.frame = CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        self.addSubview(bgView)
    }
    
    private func setupContent() {
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 80, width: bgView.width, height: 40))
        topTitle.text = "你的工作地区在哪里"
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)
        
        let pickerView = BHJPickerView.init(self, frame: CGRect(x: 20, y: topTitle.bottomY + 20, width: kScreenWidth - 40 - 2*kBgViewSpace, height: 200))
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
    
    @objc func nextClick() {
        
    }
    
}
