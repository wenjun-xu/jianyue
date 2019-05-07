//
//  OtherInformationController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/15.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
//import SDCycleScrollView
import JCyclePictureView
class OtherInformationController: BaseTabViewController {
    
    fileprivate var arrDataCommon = [HomeModel]()
    private var naviView = UIView()
    fileprivate var tuijianlabel = UILabel()
    fileprivate var sousuo = UIImageView()
    fileprivate var rightImg = UIImageView()
    var isNavHidden:Bool = true
    fileprivate var arrImgUrl = ["img_nine","img_five","img_two","img_three"]
    fileprivate var sectionH:CGFloat = 200
    
    private var personData: [MLPersonDataModel] = {
        return MLBastMatchJsonTool.getPersonDataJsonData().aModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        naviView.isHidden = false
        if isNavHidden {
            self.navigationController?.navigationBar.isHidden = true
        }else {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        naviView.isHidden = true
        if isNavHidden {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isNavHidden {
        }else {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    // 导航栏渐变
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentOffsetY = scrollView.contentOffset.y
////        print("currentOffsetY==",currentOffsetY)
//
//        var alpha:CGFloat = 0
//        if (-currentOffsetY <= (kStatusBarH + kNavH)) {
//            alpha = 1
//            tuijianlabel.isHidden = false
//
//        }else if (-currentOffsetY > kStatusBarH + kNavH) && (-currentOffsetY < (kInfoSDrecycleViewH + 20)){
//            alpha = (kInfoSDrecycleViewH + currentOffsetY) / (kInfoSDrecycleViewH - kStatusBarH - kNavH)
//            tuijianlabel.isHidden = true
//
//        }else {
//            alpha = 0
//            tuijianlabel.isHidden = true
//        }
//
//        if (-currentOffsetY < (kNavH + 2 * kStatusBarH)) {
//            tableView.showsVerticalScrollIndicator = true
//        }else {
//            tableView.showsVerticalScrollIndicator = false
//        }
//        naviView.backgroundColor = kNavColor.alpha(alpha)
//    }
}

// MARK:- 导航栏右上角 - 弹出框View 创建
extension OtherInformationController {
    private func setupUIView() {
        tableView.y = -kStatusBarH
        tableView.height = kScreenHeight + kStatusBarH - 50
        tableView.showsVerticalScrollIndicator = false
        
        tableView.contentInset = UIEdgeInsets(top: kInfoSDrecycleViewH, left: 0, bottom: 0, right: 0)
        tableView.register(OtherInfoTopCell.self, forCellReuseIdentifier: "OtherInfoTopCell")
        let cyclePictureView: WJCyclePictureView = WJCyclePictureView(frame: CGRect(x: 0, y: -kInfoSDrecycleViewH, width: kScreenWidth, height: kInfoSDrecycleViewH), pictures: arrImgUrl)
        cyclePictureView.direction = .left
        cyclePictureView.autoScrollDelay = 10
        cyclePictureView.pageControlStyle = .center
        cyclePictureView.placeholderImage = UIImage(named: "shouyebanner")
        cyclePictureView.didTapAtIndexHandle = { index in
            print("点击了第 (index + 1) 张图片")
        }
        tableView.addSubview(cyclePictureView)
        
        naviView.frame = CGRect(x: 0, y: 0, width:kScreenWidth, height:  kNavH + kStatusBarH)
        naviView.backgroundColor = UIColor(white: 1, alpha: 0)
        tuijianlabel = UILabel.init(frame: CGRect(x: (kScreenWidth - 100) / 2.0, y: 8 + kStatusBarH, width: 100, height: 22))
        tuijianlabel.text = "楚秋燕"
        tuijianlabel.textColor = UIColor.gray
        tuijianlabel.textAlignment = .center
        tuijianlabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        naviView.addSubview(tuijianlabel)
        
        let sousuoView = UIView.init(frame: CGRect(x: 15, y: kStatusBarH, width: kNavH, height: kNavH))
        naviView.addSubview(sousuoView)
        sousuo = UIImageView.init(frame: CGRect(x: 0, y: 8, width: 21, height: 21))
        sousuo.image = UIImage(named:"fanhui")
        sousuoView.addSubview(sousuo)
        
        let rightView = UIView.init(frame: CGRect(x: kScreenWidth - 15 - kNavH, y: kStatusBarH, width: kNavH, height: kNavH))
        naviView.addSubview(rightView)
        rightImg = UIImageView.init(frame: CGRect(x: kNavH - 21, y: 8, width: 21, height: 21))
        rightImg.image = UIImage(named:"gengduo")
        rightView.addSubview(rightImg)
        // MARK:- 点击手势
        let rightTapGR = UITapGestureRecognizer(target: self, action: #selector(self.rightClick))
        rightView.isUserInteractionEnabled = true
        rightView.addGestureRecognizer(rightTapGR)
        
        // MARK:- 点击手势
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.pushAdvertising))
        sousuoView.isUserInteractionEnabled = true
        sousuoView.addGestureRecognizer(tapGR)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        view.addSubview(naviView)
        view.addSubview(bottomView())
    }
    
    
}

// MARK:- 导航栏右上角 - 弹出框 点击事件
extension OtherInformationController {
    
    @objc func pushAdvertising() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightClick() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "屏蔽此人", style: .default, handler: nil)
        let del = UIAlertAction(title: "举报此人", style: .default, handler: nil)
        let ok = UIAlertAction(title: "取消", style: .cancel, handler: {
            ACTION in
            print("你点击了OK")
        })
        alert.addAction(del)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func nextClick() {
        let vc = OtherDynamicController()
        vc.selfTitle = self.tuijianlabel.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK:-  最底下 - 打招呼聊天View
extension OtherInformationController {
    private func bottomView() -> UIView {
        let bottomH:CGFloat = 50
        let bottomV = UIView.init(frame: CGRect(x: 0, y: kScreenHeight - 50, width: kScreenWidth, height: bottomH))
        bottomV.backgroundColor = UIColor.white
        let leftBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth / 2.0 - 2, height: bottomH))
        leftBtn.setTitle("聊天", for: .normal)
        leftBtn.tag = 10000
        leftBtn.setTitleColor(UIColor.black, for: .normal)
        leftBtn.setImage(UIImage(named: "guanzhu"), for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        leftBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        leftBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
        leftBtn.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
        bottomV.addSubview(leftBtn)
        
        let centerLine = UIView.init(frame: CGRect(x: kScreenWidth / 2.0 - 1, y: 10, width: 2, height: bottomH - 20))
        centerLine.backgroundColor = UIColor.gray.alpha(0.3)
        bottomV.addSubview(centerLine)
        
        let rightBtn = UIButton.init(frame: CGRect(x: kScreenWidth / 2.0 + 2, y: 0, width: kScreenWidth / 2.0 - 2, height: bottomH))
        rightBtn.tag = 10001
        rightBtn.setTitle("打招呼", for: .normal)
        rightBtn.setTitleColor(UIColor.black, for: .normal)
        rightBtn.setImage(UIImage(named: "guanzhu"), for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        rightBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        rightBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
        rightBtn.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
        bottomV.addSubview(rightBtn)
        
        
        bottomV.layer.shadowColor = UIColor.gray.alpha(0.3).cgColor
        bottomV.layer.shadowOpacity = 1
        bottomV.layer.shadowRadius = 2
        return bottomV
    }
}

// MARK:- 打招呼聊天View 点击事件
extension OtherInformationController {
    /// 打招呼聊天View 点击事件
    @objc func click(sender:UIButton) {
        if sender.tag == 10000 {
            let vc = EaseMessageViewController.init(conversationChatter: "xuwenjun", conversationType: .init(0))
            vc?.title = "与徐文俊的聊天"
            self.navigationController?.pushViewController(vc!, animated: true)
        }else {
            let vc = EaseMessageViewController.init(conversationChatter: "xuwenjun", conversationType: .init(0))
            vc?.title = "与徐文俊的聊天"
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

// MARK:- <#zhushi#>
extension OtherInformationController {
    
}

// MARK:- tableView: cellForRowAt
extension OtherInformationController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {  // 头部 - 个人信息
            let cell = OtherInfoTopCell.cell(tableView: tableView)
            return cell
            
        } else if indexPath.section == 1 { // 动态
            let cell = MLDynamicCell.cell(tableView: tableView)
            return cell
            
        } else if indexPath.section == 2 { // 个人标准
 
            let cell = MLPersonDataCell.cell(tableView: tableView)
            cell.setupData(model: personData)
            
            //下面这两个语句一定要添加，否则第一屏显示的collection view尺寸，以及里面的单元格位置会不正确
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.backgroundColor = UIColor.lightGray
            return cell
            
        } else { // 择偶标准
            let cell = MLPersonDataCell.cell(tableView: tableView)
            cell.setupData(model: personData)
            
            //下面这两个语句一定要添加，否则第一屏显示的collection view尺寸，以及里面的单元格位置会不正确
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.backgroundColor = UIColor.lightGray
            return cell
        }
    }
}


// MARK:- UITableViewDelegate || UITableViewDataSource
extension OtherInformationController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        return sectionH
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default:
            return 1
        }
        
    }
}

// MARK:- UITableViewHeaderView
extension OtherInformationController {
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 50
    }
    
    /// 使用 viewForHeaderInSection -> UIView 必须实现 heightForHeaderInSection -> CGFloat 方法，否则没有View
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 { // 动态
            let aView = MLSubtitleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
            aView.setupContext(leftLabel: "动态", rightLabel: "查看更多")
            return aView
        } else if section == 2 { // 个人资料
            let aView = MLSubtitleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
            aView.setupContext(leftLabel: "个人资料", rightLabel: nil)
            return aView
        }
        else if section == 3 { // 择偶标准
            let aView = MLSubtitleView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
            aView.setupContext(leftLabel: "择偶标准", rightLabel: nil)
            return aView
        }
        
        
        return UIView()
    }
}
