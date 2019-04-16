//
//  MLCodeView.swift
//  MoLiao
//
//  Created by study on 2019/4/16.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit
protocol MLCodeViewDelegate: NSObjectProtocol {
    /// 验证码页面 - 点击了完成
    ///
    /// - Parameters:
    ///   - CodeView: 验证码页面
    ///   - codeText: 验证码
    func loginClick(CodeView: MLCodeView, codeText: String)
}

class MLCodeView: UIView {

    let bgView = UIView()
    let loginBtn = UIButton()
    /// 倒数60秒
    let rightLabel = UILabel()
    let leftSpace: CGFloat = 30
    /// 验证码输入框
    let textView = UITextView()

    weak var delegate: MLCodeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupBGView()
        
        /// 验证码
        let largeView = setupLargeView()
        bgView.addSubview(largeView)
        
        /// 倒数60秒
        let recView = setupReciprocalView(frame: largeView.frame)
        bgView.addSubview(recView)

        setupLoginBtn(frame: recView.frame)
//        setupOtherView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLCodeView {
    private func setupBGView() {
        self.backgroundColor = kBgColor
        bgView.frame =  CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        self.addSubview(bgView)
    }
    
    /// 验证码
    private func setupLargeView() -> UIView {
        let aBgView = UIView(frame: CGRect(x: 0, y: 30, width: bgView.width, height: 50 + 30))

        let largeLabel = UILabel.init(frame: CGRect(x: 0, y: 30, width: kScreenWidth, height: 50))
        largeLabel.text = "输入你收到的验证码"
        largeLabel.textAlignment = .center
        largeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        aBgView.addSubview(largeLabel)

        let smLabel = UILabel.init(frame: CGRect(x: 0, y: largeLabel.bottomY , width: bgView.width, height: 30))
        smLabel.text = "验证码已通过短信发送至 13716686261"
        smLabel.textAlignment = .center
        aBgView.addSubview(smLabel)
        
        return aBgView
    }
    
    /// 倒数60秒
    private func setupReciprocalView(frame: CGRect) -> UIView {
        let lineW: CGFloat = bgView.width - 100 - 2*leftSpace
        let lineY: CGFloat = frame.maxY + 50

        let aBGView = UIView(frame: CGRect(x: leftSpace, y: lineY, width: lineW, height: 41))
        
        /// 文本框
        textView.frame = CGRect(x: 0, y: 0, width: aBGView.width, height: 40)
        textView.font = UIFont.boldSystemFont(ofSize: 17.0)
        textView.textAlignment = .center
        aBGView.addSubview(textView)
        
        let line = UIView.init(frame: CGRect(x: 0, y: textView.bottomY, width: aBGView.width , height: 1))
        line.backgroundColor = UIColor.gray.alpha(0.3)
        aBGView.addSubview(line)
        
        rightLabel.frame = CGRect(x: textView.rightX + 10, y: 0, width: 90, height: 40)
        rightLabel.layer.cornerRadius = 5
        rightLabel.clipsToBounds = true
        rightLabel.text = "27"
        rightLabel.textColor = UIColor.white
        rightLabel.textAlignment = .center
        rightLabel.backgroundColor = UIColor.green // kNavColor
        aBGView.addSubview(rightLabel)
        
        return aBGView
    }
    
    private func setupLoginBtn(frame: CGRect) {
        let loginBtn = UIButton.init(type: .custom)
        loginBtn.backgroundColor = UIColor.green // kNavColor
        loginBtn.frame = CGRect(x: leftSpace, y: frame.maxY + 30, width: (bgView.width - 2*leftSpace), height: 50)
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitle("完成", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.clipsToBounds = true
        bgView.addSubview(loginBtn)
    }
    
    private func setupOtherView() {
        
    }
}

extension MLCodeView {
    @objc private func loginClick() {

        delegate?.loginClick(CodeView: self, codeText: textView.text)
    }
}
