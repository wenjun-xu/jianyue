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
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func bottomView() -> UIView {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        print("currentOffsetY==",currentOffsetY)
        var alpha:CGFloat = 0
        if -currentOffsetY<=kStatusBarH + kNavH {
            alpha = 1
            tuijianlabel.isHidden = false
        }else if (-currentOffsetY > kStatusBarH + kNavH) && (-currentOffsetY < (kInfoSDrecycleViewH + 20)){
            alpha = (kInfoSDrecycleViewH + currentOffsetY) / (kInfoSDrecycleViewH - kStatusBarH - kNavH)
            tuijianlabel.isHidden = true
        }else {
            alpha = 0
            tuijianlabel.isHidden = true
        }
        if -currentOffsetY < kNavH + 2*kStatusBarH {
            tableView.showsVerticalScrollIndicator = true
        }else {
            tableView.showsVerticalScrollIndicator = false
        }
        naviView.backgroundColor = kNavColor.alpha(alpha)
    }    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "OtherInfoTopCell")
            if (cell == nil) {
                cell = OtherInfoTopCell(style: .default, reuseIdentifier: "OtherInfoTopCell")
            }
            cell?.selectionStyle = .none
            cell?.separatorInset = UIEdgeInsets.init(top: 0, left: kScreenWidth, bottom: 0, right: 0)
            return cell!
        } else if indexPath.section == 1 {
            let otherHomeNewsCell = "top"
            var cell = tableView.dequeueReusableCell(withIdentifier: otherHomeNewsCell)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: otherHomeNewsCell)
                cell?.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
                cell?.selectionStyle = .none
                cell?.addSubview(addDynamic())
            }
            return cell!
        }
        else if indexPath.section == 2 {
           
            let otherHomeNewsCell = "center"
            var cell = tableView.dequeueReusableCell(withIdentifier: otherHomeNewsCell)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: otherHomeNewsCell)
                cell?.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
                cell?.selectionStyle = .none
                cell?.addSubview(addSectionView())

            }
            return cell!
        }else {
            let otherHomeNewsCell = "bottom"
            var cell = tableView.dequeueReusableCell(withIdentifier: otherHomeNewsCell)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: otherHomeNewsCell)
                cell?.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
                cell?.selectionStyle = .none
                cell?.addSubview(biaozhun())
            }
            return cell!
        }
       
    }
    
    func addDynamic() -> UIView {
        let leftSpace:CGFloat = 12
        let topSpace:CGFloat = 12
        let imgW:CGFloat = (kScreenWidth - 2*leftSpace - 20) / 3.0
        let sectionView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: sectionH))
        let leftView = UIView.init(frame: CGRect(x: leftSpace, y: topSpace + 2, width: 4, height: 15))
        leftView.backgroundColor = UIColor.orange
        sectionView.addSubview(leftView)
        
        let topLabel = UILabel.init(frame: CGRect(x: leftView.rightX + 5, y: topSpace, width: 200, height: 20))
        topLabel.text = "动态"
        topLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        sectionView.addSubview(topLabel)
        
        let rightBtn = UIButton.init(frame: CGRect(x: kScreenWidth - leftSpace - 50, y: topSpace, width: 50, height: 20))
        rightBtn.setTitle("查看更多", for: .normal)
        rightBtn.setTitleColor(UIColor.gray, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        sectionView.addSubview(rightBtn)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.nextClick))
        rightBtn.isUserInteractionEnabled = true
        rightBtn.addGestureRecognizer(tapGR)
        
        for i in 0...2 {
            let img = UIImageView.init(frame: CGRect(x: leftSpace + CGFloat(i)*(imgW + 10), y: topLabel.bottomY + 20, width: imgW, height: imgW))
            img.image = UIImage(named: "0000")
            sectionView.addSubview(img)
        }
        return sectionView
    }
    
   @objc func nextClick() {
        let vc = OtherDynamicController()
        vc.selfTitle = self.tuijianlabel.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func biaozhun() -> UIView {
        let leftSpace:CGFloat = 12
        let topSpace:CGFloat = 12
        let middleSpace:CGFloat = 20
        let centerLeftSpace:CGFloat = 10
        let centerMiddleSpace:CGFloat = 15
        let sectionView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: sectionH))
        
        let leftView = UIView.init(frame: CGRect(x: leftSpace, y: topSpace + 2, width: 4, height: 15))
        leftView.backgroundColor = UIColor.orange
        sectionView.addSubview(leftView)
        
        let topLabel = UILabel.init(frame: CGRect(x: leftView.rightX + 5, y: topSpace, width: 200, height: 20))
        topLabel.text = "择偶标准"
        topLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        sectionView.addSubview(topLabel)
        
        let firstlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: topLabel.bottomY + 30, width: 60, height: 24))
        firstlabel.text = "未婚"
        customLabelLayer(label: firstlabel)
        sectionView.addSubview(firstlabel)
        
        let secondlabel = UILabel.init(frame: CGRect(x: firstlabel.rightX + middleSpace, y: topLabel.bottomY + 30, width: 60, height: 24))
        secondlabel.text = "24-28岁"
        customLabelLayer(label: secondlabel)
        sectionView.addSubview(secondlabel)
        
        let threelabel = UILabel.init(frame: CGRect(x: secondlabel.rightX + middleSpace, y: topLabel.bottomY + 30, width: 150, height: 24))
        threelabel.text = "工作地区:北京东城区"
        customLabelLayer(label: threelabel)
        sectionView.addSubview(threelabel)
        
        let fourlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 90, height: 24))
        fourlabel.text = "150-170com"
        customLabelLayer(label: fourlabel)
        sectionView.addSubview(fourlabel)
        
        let fivelabel = UILabel.init(frame: CGRect(x: fourlabel.rightX + middleSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        fivelabel.text = "47-80kg"
        customLabelLayer(label: fivelabel)
        sectionView.addSubview(fivelabel)
        
        let sixlabel = UILabel.init(frame: CGRect(x: fivelabel.rightX + middleSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 140, height: 24))
        sixlabel.text = "月收入:8000-12000"
        customLabelLayer(label: sixlabel)
        sectionView.addSubview(sixlabel)
        
        let sevenlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: fourlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        sevenlabel.text = "本科"
        customLabelLayer(label: sevenlabel)
        sectionView.addSubview(sevenlabel)
        
        return sectionView
    }
    
    
    func customLabelLayer(label:UILabel) {
        label.layer.cornerRadius = 12
        label.textColor = kLabelGrayColor
        label.layer.borderColor = UIColor.gray.alpha(0.3).cgColor
        label.layer.borderWidth = 0.35
//        label.layer.shadowColor = UIColor.gray.alpha(0.5).cgColor
//        label.layer.shadowRadius = 5
//        label.layer.shadowOpacity = 0.6
//        label.layer.shadowOffset = CGSize(width: 1, height: 2)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0)
    }
    
    func addSectionView() -> UIView {
        let leftSpace:CGFloat = 12
        let topSpace:CGFloat = 12
        let middleSpace:CGFloat = 20
        let centerLeftSpace:CGFloat = 10
        let centerMiddleSpace:CGFloat = 15
        let sectionView = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: sectionH))
        
        let leftView = UIView.init(frame: CGRect(x: leftSpace, y: topSpace + 2, width: 4, height: 15))
        leftView.backgroundColor = UIColor.orange
        sectionView.addSubview(leftView)
        
        let topLabel = UILabel.init(frame: CGRect(x: leftView.rightX + 5, y: topSpace, width: 200, height: 20))
        topLabel.text = "个人资料"
        topLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        sectionView.addSubview(topLabel)
        
        let firstlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: topLabel.bottomY + 30, width: 60, height: 24))
        firstlabel.text = "未婚"
        customLabelLayer(label: firstlabel)
        sectionView.addSubview(firstlabel)
        
        let secondlabel = UILabel.init(frame: CGRect(x: firstlabel.rightX + middleSpace, y: topLabel.bottomY + 30, width: 60, height: 24))
        secondlabel.text = "24岁"
        customLabelLayer(label: secondlabel)
        sectionView.addSubview(secondlabel)
        
        let threelabel = UILabel.init(frame: CGRect(x: secondlabel.rightX + middleSpace, y: topLabel.bottomY + 30, width: 150, height: 24))
        threelabel.text = "工作地区:北京东城区"
        customLabelLayer(label: threelabel)
        sectionView.addSubview(threelabel)
        
        let fourlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        fourlabel.text = "166com"
        customLabelLayer(label: fourlabel)
        sectionView.addSubview(fourlabel)
        
        let fivelabel = UILabel.init(frame: CGRect(x: fourlabel.rightX + middleSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 60, height: 24))
        fivelabel.text = "47kg"
        customLabelLayer(label: fivelabel)
        sectionView.addSubview(fivelabel)
        
        let sixlabel = UILabel.init(frame: CGRect(x: fivelabel.rightX + middleSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 140, height: 24))
        sixlabel.text = "月收入:8000-12000"
        customLabelLayer(label: sixlabel)
        sectionView.addSubview(sixlabel)
        
        let sevenlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: fourlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        sevenlabel.text = "狮子座"
        customLabelLayer(label: sevenlabel)
        sectionView.addSubview(sevenlabel)
        
        let eightlabel = UILabel.init(frame: CGRect(x: sevenlabel.rightX + middleSpace, y: fourlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        eightlabel.text = "销售"
        customLabelLayer(label: eightlabel)
        sectionView.addSubview(eightlabel)
        
        let ninelabel = UILabel.init(frame: CGRect(x: eightlabel.rightX + middleSpace, y: fourlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        ninelabel.text = "本科"
        customLabelLayer(label: ninelabel)
        sectionView.addSubview(ninelabel)
        return sectionView
    }
    
    
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
        if section == 0 {
            return 1
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 15
    }
    
}
