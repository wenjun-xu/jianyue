//
//  MLRegistMaritalView.swift
//  MoLiao
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit


protocol MLRegistMaritalViewDelegate: NSObjectProtocol {
    /// 婚姻状况
    func maritalClick(pageView: MLRegistMaritalView, marital: String)
}

///  "完善信息(6/7)" - 婚姻
class MLRegistMaritalView: MLRegistBaseView {
    
    var tempBtn: UIButton!
        
    weak var delegate: MLRegistMaritalViewDelegate?
    
    /// 身高
    private var heightString = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK:- 按钮点击
extension MLRegistMaritalView {
    @objc func clickAction(sender:UIButton)  {
        if tempBtn == nil {
            sender.isSelected = true
            tempBtn = sender
            tempBtn.backgroundColor = kNavColor
            
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
        UserDefaults.standard.set(sender.tag, forKey: "sixtemptag")
        
        self.delegate?.maritalClick(pageView: self, marital: sender.currentTitle ?? "")
    }
}

// MARK:- UI创建
extension MLRegistMaritalView {
    
    private func setupContent() {
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 80, width: bgView.width, height: 40))
        topTitle.text = "你的婚姻状况"
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)
        let temptag:Int = UserDefaults.standard.integer(forKey: "sixtemptag")

        let arrTitle = ["未婚","离异","丧偶"]
        for i in 1..<4 {
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
