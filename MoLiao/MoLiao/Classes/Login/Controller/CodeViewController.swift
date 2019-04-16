

//
//  CodeViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/9.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

/// 验证手机号
class CodeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = kBgColor
        self.title = "验证手机"
        
        let codeView = MLCodeView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 64))
        codeView.delegate = self
        self.view.addSubview(codeView)
    }
    
}

extension CodeViewController: MLCodeViewDelegate {
    func loginClick(CodeView: MLCodeView, codeText: String) {
        let vc = RegistEightController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
