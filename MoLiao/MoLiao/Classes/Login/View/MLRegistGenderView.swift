//
//  MLRegistGenderController.swift
//  MoLiao
//
//  Created by study on 2019/4/17.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

enum typeGender {
    /// 女性
    case genderFemale
    /// 男性
    case genderMale
    /// 中性
    case genderNeutral
}

protocol MLRegistGenderViewDelegate: NSObjectProtocol {
    /// 性别按钮
    func genderBtnClick(pageView: MLRegistGenderView, gender: typeGender)
}

/// 完善信息 - 性别选择
class MLRegistGenderView: MLRegistBaseView {
    
    weak var delegate: MLRegistGenderViewDelegate?
    
    private var aGenderType = typeGender.genderNeutral
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTopicView(title: "你的性别是")
        setupContent()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 点击事件
extension MLRegistGenderView {
    @objc func nextClick(sender:UIButton) {
        
        if sender.tag == 1000 {
            aGenderType = typeGender.genderMale
            
        } else {
            aGenderType = typeGender.genderFemale
        }
        
        self.delegate?.genderBtnClick(pageView: self, gender: aGenderType)
    }
}


// MARK:- UI创建
extension MLRegistGenderView {
    private func setupContent() {

        // 创建男性
        let maleFrame = CGRect(x: FRegist_leftSpace, y: 150, width: FRegist_imageWidth, height: FRegist_imageWidth)
        setupView(image: "shuaige", text: "男", frame: maleFrame)
        
        // 创建女性
        let aFmX: CGFloat = 2 * FRegist_leftSpace + FRegist_imageWidth
        let femaleFrame = CGRect(x: aFmX, y: 150, width: FRegist_imageWidth, height: FRegist_imageWidth)
        setupView(image: "meinv", text: "女", frame: femaleFrame)
    }
    
    private func setupView(image: String, text: String, frame: CGRect) {
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.frame = frame
        leftBtn.setImage(UIImage(named: image), for: .normal)
        leftBtn.layer.cornerRadius = frame.width / 2.0
        leftBtn.clipsToBounds = true
        leftBtn.tag = 1000
        leftBtn.addTarget(self, action: #selector(nextClick(sender:)), for: .touchUpInside)
        bgView.addSubview(leftBtn)
        
        
        let leftLabel = UILabel.init(frame: CGRect(x: frame.origin.x, y: leftBtn.bottomY + 10, width: frame.width, height: 22))
        leftLabel.text = text
        leftLabel.font = UIFont.systemFont(ofSize: 16.0)
        leftLabel.textColor = UIColor.black.alpha(0.7)
        leftLabel.textAlignment = .center
        bgView.addSubview(leftLabel)
    }
}
