

//
//  CodeViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/9.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class CodeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = kBgColor
        let bgView = UIView.init(frame: CGRect(x: kBgViewSpace, y: kBgViewSpace, width: kScreenWidth - 2*kBgViewSpace, height: kScreenHeight - kStatusBarH - kNavH - 2*kBgViewSpace))
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        view.addSubview(bgView)
        
        
        self.title = "验证手机"
        let leftSpace:CGFloat = 30
        let lineW:CGFloat = bgView.width - 100 - 2*leftSpace
        let largeLabel = UILabel.init(frame: CGRect(x: 0, y: 30, width: kScreenWidth, height: 50))
        largeLabel.text = "输入你收到的验证码"
        largeLabel.textAlignment = .center
        largeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)

        bgView.addSubview(largeLabel)
        
        let smLabel = UILabel.init(frame: CGRect(x: 0, y: largeLabel.bottomY , width: bgView.width, height: 30))
        smLabel.text = "验证码已通过短信发送至 13716686261"
        smLabel.textAlignment = .center
        bgView.addSubview(smLabel)
        
        let textView = UITextView.init(frame: CGRect(x: leftSpace, y: smLabel.bottomY + 50, width: lineW, height: 40))
        textView.font = UIFont.boldSystemFont(ofSize: 17.0)
        textView.textAlignment = .center
        bgView.addSubview(textView)
        
        let line = UIView.init(frame: CGRect(x: leftSpace, y: textView.bottomY, width:lineW , height: 1))
        line.backgroundColor = UIColor.gray.alpha(0.3)
        bgView.addSubview(line)
        
        let rightLabel = UILabel.init(frame: CGRect(x: textView.rightX + 10, y: smLabel.bottomY + 50, width: 90, height: 40))
        rightLabel.layer.cornerRadius = 5
        rightLabel.clipsToBounds = true
        rightLabel.text = "27"
        rightLabel.textColor = UIColor.white
        rightLabel.textAlignment = .center
        rightLabel.backgroundColor = kNavColor
        bgView.addSubview(rightLabel)
        
        
        let loginBtn = UIButton.init(type: .custom)
        loginBtn.backgroundColor = kNavColor
        loginBtn.frame = CGRect(x: leftSpace, y: textView.bottomY + 30, width: (bgView.width - 2*leftSpace), height: 50)
        loginBtn.layer.cornerRadius = 8
        loginBtn.setTitle("完成", for: .normal)
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        loginBtn.clipsToBounds = true
        bgView.addSubview(loginBtn)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @objc func loginClick() {
        let vc = RegistEightController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
