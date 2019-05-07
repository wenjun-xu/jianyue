//
//  MLDetailBottomView.swift
//  MoLiao
//
//  Created by study on 2019/5/7.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol MLDetailBottomViewDelegate: NSObjectProtocol {
    /// 打招呼界面
    func nextPageSayHelloClick(view: MLDetailBottomView)
    /// 聊天界面
    func nextPageChatClick(view: MLDetailBottomView)
}

/// 首页 - 详情页面 - 底部View 聊天，打招呼
class MLDetailBottomView: UIView {
    
    /// 左侧标题
    private let leftLine = UILabel()
    private let leftLabel = UILabel()
    private let moreBtn = UIButton()
    
    weak var delegate: MLDetailBottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 创建UI界面
extension MLDetailBottomView {
    /// 创建UI界面
    private func setupUIView() {
        let bottomH: CGFloat = 50
        
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: bottomH))
        bgView.backgroundColor = UIColor.white
        
        /// 聊天
        let chatBtn = UIButton(frame: CGRect(x: 0, y: 0, width: kScreenWidth / 2.0 - 2, height: bottomH))
        chatBtn.setTitle("聊天", for: .normal)
        chatBtn.tag = 10000
        chatBtn.setTitleColor(UIColor.black, for: .normal)
        chatBtn.setImage(UIImage(named: "guanzhu"), for: .normal)
        chatBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        chatBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        chatBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
        chatBtn.addTarget(self, action: #selector(chatClick), for: .touchUpInside)
        bgView.addSubview(chatBtn)
        
        /// 中间的竖线
        let centerLine = UIView(frame: CGRect(x: kScreenWidth / 2.0 - 1, y: 10, width: 2, height: bottomH - 20))
        centerLine.backgroundColor = UIColor.gray.alpha(0.3)
        bgView.addSubview(centerLine)
        
        /// 打招呼
        let sayHelloBtn = UIButton(frame: CGRect(x: kScreenWidth / 2.0 + 2, y: 0, width: kScreenWidth / 2.0 - 2, height: bottomH))
        sayHelloBtn.tag = 10001
        sayHelloBtn.setTitle("打招呼", for: .normal)
        sayHelloBtn.setTitleColor(UIColor.black, for: .normal)
        sayHelloBtn.setImage(UIImage(named: "guanzhu"), for: .normal)
        sayHelloBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        sayHelloBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        sayHelloBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
        sayHelloBtn.addTarget(self, action: #selector(sayHelloClick), for: .touchUpInside)
        bgView.addSubview(sayHelloBtn)
        
        
        bgView.layer.shadowColor = UIColor.gray.alpha(0.3).cgColor
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowRadius = 2
        
        self.addSubview(bgView)
    }
}

// MARK:- 按钮的点击事件
extension MLDetailBottomView {
    /// 打招呼
    @objc private func sayHelloClick(){
        self.delegate?.nextPageSayHelloClick(view: self)
    }
    
    /// 聊天
    @objc private func chatClick() {
        self.delegate?.nextPageChatClick(view: self)
    }
}

// MARK:- 外界传值
extension MLDetailBottomView {
    
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
