//
//  VipViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/21.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class VipViewController: BaseViewController {
    var scrollview = UIScrollView()
    var selectorBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "会员支付"
        scrollview.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kStatusBarH - kNavH)
        scrollview.contentSize = self.view.bounds.size
        scrollview.showsVerticalScrollIndicator = false
        scrollview.isScrollEnabled = true
        view.addSubview(scrollview)
        
        let titleArr = ["12个月","3个月","1个月"]
        let moneyArr = ["¥388","¥348","¥248"]
        let tabH:CGFloat = 62
        let leftSpace:CGFloat = 20
        for i in 0...titleArr.count - 1 {
            let tabView = UIView.init(frame: CGRect(x: leftSpace, y: CGFloat(i)*tabH, width: kScreenWidth - 2*leftSpace, height: tabH))
            let leftLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: tabH))
            leftLabel.text = titleArr[i]
            leftLabel.textColor = UIColor.black.alpha(0.6)
            leftLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
            tabView.addSubview(leftLabel)
            
            let rightBtn = UIButton.init(frame: CGRect(x: tabView.width - 60, y: (tabH - 22) / 2.0, width: 60, height: 25))
            rightBtn.setTitle(moneyArr[i], for: .normal)
            rightBtn.setTitleColor(kZhifuTitleColor, for: .normal)
            rightBtn.tag = i + 1000
            if i == 0 {
                rightBtn.isSelected = true
                selectorBtn = rightBtn
            }
            rightBtn.setBackgroundImage(getImageWithColor(color:UIColor.white), for: .normal)
            rightBtn.setBackgroundImage(getImageWithColor(color:kZhifuBgColor), for: .selected)
            rightBtn.layer.cornerRadius = 3
            rightBtn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
            
            tabView.addSubview(rightBtn)
            let linView = UIView.init(frame: CGRect(x: 0, y: tabView.height - 1, width: tabView.width, height: 0.75))
            linView.backgroundColor = UIColor.gray.alpha(0.3)
            tabView.addSubview(linView)
            
            scrollview.addSubview(tabView)
            
            let tequanL = UILabel.init(frame: CGRect(x: leftSpace, y: tabH*3 + 20, width: 200, height: 30))
            tequanL.text = "会员特权"
            tequanL.font = UIFont.boldSystemFont(ofSize: 16.0)
            scrollview.addSubview(tequanL)
            
            let zhifuBtn = UIButton.init(frame: CGRect(x: 5, y: kScreenHeight - kNavH - kStatusBarH - 55, width: kScreenWidth - 10, height: 50))
            zhifuBtn.layer.cornerRadius = 5
            zhifuBtn.setTitle("立即支付", for: .normal)
            zhifuBtn.setTitleColor(kZhifuTitleColor, for: .normal)
            zhifuBtn.backgroundColor = kZhifuBgColor
            view.addSubview(zhifuBtn)
        }

        
    }
    
    
    
    @objc func btnClick(sender:UIButton) {
        if (selectorBtn == nil){
            sender.isSelected = true
            selectorBtn = sender
        }
        else if (selectorBtn != nil && selectorBtn == sender){
            sender.isSelected = true
        }
        else if (selectorBtn != sender && selectorBtn != nil){
            selectorBtn.isSelected = false
            sender.isSelected = true
            selectorBtn = sender
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    
}
