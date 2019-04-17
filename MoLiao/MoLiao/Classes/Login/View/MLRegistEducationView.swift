//
//  MLRegistEducationView.swift
//  MoLiao
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol MLRegistEducationViewDelegate: NSObjectProtocol {
    /// 学历
    func educationClick(pageView: MLRegistEducationView, education: String)
}

///  "完善信息(5/7)" - 学历
class MLRegistEducationView: UIView {
    var tempBtn: UIButton!
    
    private let bgView = UIView()
    weak var delegate: MLRegistEducationViewDelegate?
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

// MARK:- 点击事件
extension MLRegistEducationView {
    @objc func clickAction(sender: UIButton)  {
        if tempBtn == nil {
            sender.isSelected = true
            tempBtn = sender
            tempBtn.backgroundColor = UIColor.blue //kNavColor
            
        }else if (tempBtn != nil && tempBtn == sender){
            sender.isSelected = true
            sender.backgroundColor = kNavColor
        }else if (tempBtn != sender && tempBtn != nil) {
            tempBtn.isSelected = false
            sender.isSelected = true
            tempBtn.backgroundColor = UIColor.clear
            sender.backgroundColor = kNavColor
            tempBtn = sender
        }
        UserDefaults.standard.set(sender.tag, forKey: "temptag")
        
        let str = sender.currentTitle ?? ""
        self.delegate?.educationClick(pageView: self, education: str)
    }
}

// MARK:- UI创建
extension MLRegistEducationView {
    
    private func setupBGView() {
        bgView.frame = CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        self.addSubview(bgView)
    }
    
    private func setupContent() {
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 80, width: bgView.width, height: 40))
        topTitle.text = "你的学历是"
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)
        
        let temptag:Int = UserDefaults.standard.integer(forKey: "temptag")
        let arrTitle = ["高中及以下","中专","大专","大学本科","硕士","博士"]
        for i in 1..<7 {
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect(x: 20, y:150 + 50*(i - 1), width: Int(bgView.width - 40), height: 40)
            btn.layer.cornerRadius = 5
            btn.clipsToBounds = true
            btn.layer.borderColor = kNavColor.cgColor
            btn.layer.borderWidth = 0.4
            btn.setTitle(arrTitle[i - 1], for: .normal)
            btn.setTitleColor(UIColor.lightGray, for: .normal)
            btn.setTitleColor(UIColor.white, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            btn.addTarget(self, action: #selector(clickAction(sender:)), for: .touchUpInside)
            btn.tag = i
            if i == temptag {
                btn.isSelected = true
                btn.backgroundColor = kNavColor
                tempBtn = btn
            }
            
            bgView.addSubview(btn)
        }
    }
}
