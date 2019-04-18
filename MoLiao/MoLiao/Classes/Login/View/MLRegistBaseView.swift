//
//  MLRegistBaseView.swift
//  MoLiao
//
//  Created by study on 2019/4/18.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class MLRegistBaseView: UIView {

    let bgView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBGView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLRegistBaseView {
    private func setupBGView() {
        bgView.frame = CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        self.addSubview(bgView)
    }
}
