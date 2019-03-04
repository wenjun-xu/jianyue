//
//  MeNewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/21.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class MeNewController: BaseViewController {
    var scrollview = UIScrollView()
    var headerImageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSpace:CGFloat = 30
        let topSpace:CGFloat = 150
      scrollview.frame = CGRect(x: 0, y: -kStatusBarH - kNavH, width: kScreenWidth, height: kScreenHeight - kTabbarHeight + kStatusBarH + kNavH)
        scrollview.contentSize = self.view.bounds.size
        scrollview.isScrollEnabled = true
        view.addSubview(scrollview)
        
        headerImageView.frame = CGRect(x: 0, y:0, width: kScreenWidth, height: kMeTabHeadImgH)
        headerImageView.image = UIImage(named: "user_bg_img")
        scrollview.addSubview(headerImageView)
        
        let headerView = UIView.init(frame: CGRect(x: leftSpace, y: topSpace, width: 250, height: 90))
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.headerClick))
        headerView.isUserInteractionEnabled = true
        headerView.addGestureRecognizer(tapGR)
        scrollview.addSubview(headerView)
        
        let user_icon_img = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        user_icon_img.layer.cornerRadius = 45
        user_icon_img.clipsToBounds = true
        user_icon_img.image = UIImage(named: "user_icon")
        user_icon_img.isUserInteractionEnabled = true
        headerView.addSubview(user_icon_img)
        
        let nameLabel = UILabel.init(frame: CGRect(x: user_icon_img.rightX + 15, y: user_icon_img.y + 15, width: 100, height: 30))
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        nameLabel.textColor = UIColor.black.alpha(0.6)
        nameLabel.text = "楚秋燕"
        headerView.addSubview(nameLabel)
        
        let detailOneLabel = UILabel.init(frame: CGRect(x: user_icon_img.rightX + 15, y: nameLabel.bottomY, width: 200, height: 22))
        detailOneLabel.font = UIFont.systemFont(ofSize: 12.0)
        detailOneLabel.textColor = UIColor.gray
        detailOneLabel.text = "查看并编辑个人资料"
        headerView.addSubview(detailOneLabel)
        
        let centerView = UIView.init(frame: CGRect(x: leftSpace, y: headerView.bottomY + 20, width: kScreenWidth - 2*leftSpace, height: 80))
        centerView.backgroundColor = UIColor.white
        centerView.layer.cornerRadius = 3
        //阴影设置
        centerView.layer.shadowColor = UIColor.gray.alpha(0.3).cgColor
        centerView.layer.shadowRadius = 8
        centerView.layer.shadowOpacity = 0.7
        centerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        scrollview.addSubview(centerView)
        
        let centerLine = UIView.init(frame: CGRect(x: centerView.width / 2.0, y: 18, width: 1, height: centerView.height - 36))
        centerLine.backgroundColor = UIColor.gray.alpha(0.3)
        centerView.addSubview(centerLine)
        let centerTitleArr = ["看过我","关注我"]
        for j in 0...1 {
            let leftBtn = UIButton.init(frame: CGRect(x: CGFloat(j)*(centerView.width / 2.0 + 1), y: 0, width: centerView.width / 2.0 - 1, height: centerView.height))
            leftBtn.tag = 2000 + j
            leftBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
            leftBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
            leftBtn.setTitle(centerTitleArr[j], for: .normal)
            leftBtn.setTitleColor(UIColor.black.alpha(0.6), for: .normal)
            leftBtn.setImage(UIImage(named: "guanzhu"), for: .normal)
            leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight(rawValue: 1.2))
            leftBtn.addTarget(self, action: #selector(pushClick(sender:)), for: .touchUpInside)
            centerView.addSubview(leftBtn)
        }
        
        let titleArr = ["择偶标准","我的动态","会员中心","设置"]
        let tabH:CGFloat = 62
        for i in 0...titleArr.count - 1 {
            let tabView = UIView.init(frame: CGRect(x: leftSpace, y: centerView.bottomY + 40 + CGFloat(i)*tabH, width: kScreenWidth - 2*leftSpace, height: tabH))
            let tabViewGR = UITapGestureRecognizer(target: self, action: #selector(self.listViewClick(tabGR:)))
            tabView.isUserInteractionEnabled = true
            tabView.tag = i + 1000
            tabView.addGestureRecognizer(tabViewGR)
            
            let leftLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: tabH))
            leftLabel.text = titleArr[i]
            leftLabel.textColor = UIColor.black.alpha(0.6)
            leftLabel.font = UIFont.systemFont(ofSize: 15.0)
            tabView.addSubview(leftLabel)
            
            let rightImg = UIImageView.init(frame: CGRect(x: tabView.width - leftSpace - 22, y: (tabH - 22) / 2.0, width: 22, height: 22))
            rightImg.image = UIImage(named: "guanzhu")
            tabView.addSubview(rightImg)

            if i < titleArr.count - 1 {
                let linView = UIView.init(frame: CGRect(x: 0, y: tabView.height - 1, width: tabView.width, height: 0.75))
                linView.backgroundColor = UIColor.gray.alpha(0.3)
                tabView.addSubview(linView)
            }
            scrollview.addSubview(tabView)
            
            
        }
        
    }
    
   @objc func pushClick(sender:UIButton) {
        if sender.tag == 2000 {
            let vc = LookSegmentController()
            vc.isLookMe = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let vc = LookSegmentController()
            vc.isLookMe = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func headerClick() {
        let vc = WJMeDetailController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func listViewClick(tabGR:UITapGestureRecognizer) {
        switch tabGR.view?.tag {
        case 1000:
            let vc = ChooseFriendController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1001:
            let vc = OtherDynamicController()
            vc.selfTitle = "我"
            self.navigationController?.pushViewController(vc, animated: true)
        case 1002:
            let vc = VipViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 1003:
            let vc = ShezhiViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = ChooseFriendController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (self.navigationController?.children.count)! > 1 {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
  
}
