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
class MLRegistGenderView: UIView {

    private let bgView = UIView()
    weak var delegate: MLRegistGenderViewDelegate?
    
    private var aGenderType = typeGender.genderNeutral
    
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
    private func setupBGView() {
        bgView.frame = CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        self.addSubview(bgView)
    }
    
    private func setupContent() {
        
        let imgWidth:CGFloat = 100
        let leftSpace:CGFloat = (kScreenWidth - 2*imgWidth) / 3.0
        let titleBttomY:CGFloat = 90
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 80, width: bgView.width, height: 40))
        topTitle.text = "你的性别是"
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)
        
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.frame = CGRect(x: leftSpace, y: topTitle.bottomY + titleBttomY, width: imgWidth, height: imgWidth)
        leftBtn.setImage(UIImage(named: "shuaige"), for: .normal)
        leftBtn.layer.cornerRadius = imgWidth/2.0
        leftBtn.clipsToBounds = true
        leftBtn.tag = 1000
        leftBtn.addTarget(self, action: #selector(nextClick(sender:)), for: .touchUpInside)
        bgView.addSubview(leftBtn)
        
        
        let leftLabel = UILabel.init(frame: CGRect(x: leftSpace, y: leftBtn.bottomY + 10, width: imgWidth, height: 22))
        leftLabel.text = "男"
        leftLabel.font = UIFont.systemFont(ofSize: 16.0)
        leftLabel.textColor = UIColor.black.alpha(0.7)
        leftLabel.textAlignment = .center
        bgView.addSubview(leftLabel)
        
        
        let rightBtn = UIButton.init(type: .custom)
        rightBtn.frame = CGRect(x: 2*leftSpace + imgWidth, y: topTitle.bottomY + titleBttomY, width: imgWidth, height: imgWidth)
        rightBtn.setImage(UIImage(named: "meinv"), for: .normal)
        rightBtn.layer.cornerRadius = imgWidth/2.0
        rightBtn.clipsToBounds = true
        leftBtn.tag = 1001
        rightBtn.addTarget(self, action: #selector(nextClick(sender:)), for: .touchUpInside)
        bgView.addSubview(rightBtn)
        
        let rightLabel = UILabel.init(frame: CGRect(x: 2*leftSpace + imgWidth, y: rightBtn.bottomY + 10, width: imgWidth, height: 22))
        rightLabel.text = "女"
        rightLabel.font = UIFont.systemFont(ofSize: 16.0)
        rightLabel.textColor = UIColor.black.alpha(0.7)
        rightLabel.textAlignment = .center
        bgView.addSubview(rightLabel)
    }
    
   
}
