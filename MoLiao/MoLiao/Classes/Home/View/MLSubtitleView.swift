//
//  MLSubtitleView.swift
//  MoLiao
//
//  Created by study on 2019/4/28.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol MLSubtitleViewDelegate: NSObjectProtocol {
    func nextPageClick(view: MLSubtitleView)
}

/// 竖线 左侧标题  右侧副标题
class MLSubtitleView: UIView {
    
    /// 左侧标题
    private let leftLine = UILabel()
    private let leftLabel = UILabel()
    private let moreBtn = UIButton()
    
    weak var delegate: MLSubtitleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 创建UI界面
extension MLSubtitleView {
    /// 创建UI界面
    private func setupUIView() {
        let viewH: CGFloat = frame.size.height
        leftLine.frame = CGRect(x: leftSpace_20, y: (viewH - 20) * 0.5, width: 5, height: 20)
        leftLine.backgroundColor = UIColor.yellow
        self.addSubview(leftLine)
        
        leftLabel.frame = CGRect(x: leftLine.frame.maxX + 10, y: 0, width: 200, height: viewH)
        leftLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight(rawValue: 1.2))
        self.addSubview(leftLabel)
        
        moreBtn.frame = CGRect(x: kScreenWidth - leftSpace_20 - 60, y: leftLabel.y, width: 60, height: viewH)
        moreBtn.setTitleColor(UIColor.gray, for: .normal)
        moreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        moreBtn.titleLabel?.textAlignment = .right
        moreBtn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        self.addSubview(moreBtn)
    }
}

// MARK:- 按钮的点击事件
extension MLSubtitleView {
    /// 按钮的点击事件
    @objc private func moreClick() {
        self.delegate?.nextPageClick(view: self)
    }
}

// MARK:- 外界传值
extension MLSubtitleView {
    
    /// 外界传值
    ///
    /// - Parameters:
    ///   - leftLabel: 左侧标题
    ///   - rightLabel: 右侧副标题，可点击
    public func setupContext(leftLabel: String, rightLabel: String?) {
        self.leftLabel.text = leftLabel
        
        guard let rightL = rightLabel else {
            // 隐藏
            moreBtn.isHidden = true
            return
        }
        
        // 显示
        moreBtn.isHidden = false
        moreBtn.setTitle(rightL, for: .normal)
    }
}
