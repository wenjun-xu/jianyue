//
//  RegistThreeController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/8.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class RegistThreeController: BaseViewController ,DYScrollRulerDelegate{
  
    var rulerView:TDScrollRulerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "完善信息(3/7)"
        
        view.backgroundColor = kBgColor
        let bgView = UIView.init(frame: CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace))
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        view.addSubview(bgView)
        
        let topTitle = UILabel.init(frame: CGRect(x: 0, y: 80, width: bgView.width, height: 40))
        topTitle.text = "你的身高是"
        topTitle.textAlignment = .center
        topTitle.font = UIFont.boldSystemFont(ofSize: 24.0)
        bgView.addSubview(topTitle)
        
        let rulerView = DYScrollRulerView.init(frame: CGRect(x: 20, y: topTitle.bottomY + 50, width: kScreenWidth - 40 - 2*kBgViewSpace, height: 200), theMinValue: 140, theMaxValue: 220, theStep: 1, theUnit: "com", theNum: 5)
        rulerView?.setDefaultValue(155, animated: true)
        rulerView?.bgColor = UIColor.gray
        rulerView?.triangleColor = UIColor.white
        rulerView?.delegate = self
        rulerView?.scrollByHand = true
        bgView.addSubview(rulerView!)
        
        let nextBtn = UIButton.init(type: .custom)
        nextBtn.frame = CGRect(x: 20, y: kScreenHeight - kStatusBarH - kNavH - 100, width: kScreenWidth - 40 - 2*kBgViewSpace, height: 45)
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.layer.cornerRadius = 8
        nextBtn.clipsToBounds = true
        nextBtn.backgroundColor = kNavColor
        nextBtn.addTarget(self, action: #selector(nextClick), for: .touchUpInside)
        bgView.addSubview(nextBtn)
    }
    @objc func nextClick() {
        let vc = RegistFourController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func dyScrollRulerView(_ rulerView: DYScrollRulerView!, valueChange value: Float) {
        
    }
    
}






































