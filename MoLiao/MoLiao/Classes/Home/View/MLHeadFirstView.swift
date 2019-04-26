//
//  MLHeadFirstView.swift
//  MoLiao
//
//  Created by study on 2019/4/26.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

/// 左侧标题  右侧副标题
class MLHeadFirstView: UIView {

    /// 左侧标题
    private let leftLabel = UILabel()
    private let moreBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 创建UI界面
extension MLHeadFirstView {
    /// 创建UI界面
    private func setupUIView() {
        self.backgroundColor = UIColor.orange
        
        leftLabel.frame = CGRect(x: leftSpace_20, y: 0, width: 200, height: 50)
        leftLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight(rawValue: 1.2))
        self.addSubview(leftLabel)
        
        moreBtn.frame = CGRect(x: kScreenWidth - leftSpace_20 - 60, y: leftLabel.y, width: 60, height: 50)
        moreBtn.setTitleColor(UIColor.gray, for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        moreBtn.titleLabel?.textAlignment = .right
        moreBtn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        self.addSubview(moreBtn)
    }
}

// MARK:- /// 查看更多
extension MLHeadFirstView {
    /// 查看更多
    @objc private func moreClick() {
        print("查看更多")
//        let vc = MoreSelectController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK:- /// 查看更多
extension MLHeadFirstView {
    
    /// 外界传值
    ///
    /// - Parameters:
    ///   - leftLabel: 左侧标题
    ///   - rightLabel: 右侧副标题，可点击
    public func setupContext(leftLabel: String, rightLabel: String?) {
        self.leftLabel.text = leftLabel
        
        guard let rightL = rightLabel else {
            return
        }
         moreBtn.setTitle(rightL, for: .normal)
    }
}
