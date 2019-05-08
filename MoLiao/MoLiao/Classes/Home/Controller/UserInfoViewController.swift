//
//  UserInfoViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/23.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit
let level2:CGFloat = kNavH + kStatusBarH
let  level3:CGFloat = kInfoSDrecycleViewH - kStatusBarH
class UserInfoViewController: BaseViewController {
    var changeColorButtonId:NSInteger = 10000
    var down:UIPanGestureRecognizer!
    var scrContainView:UIView!
    var _lasty:CGFloat!
    var currentIndex:NSInteger!
    fileprivate var arrDataCommon = [HomeModel]()
    var isNavHidden:Bool = true
    fileprivate var arrImgUrl = ["img_nine","img_five","img_two","img_three"]
    fileprivate var sectionH:CGFloat = 200
    override func viewDidLoad() {
        super.viewDidLoad()
        let navController = navigationController as? BaseNavgationController
        if let edgePan = navController?.getScreenEdgePanGestureRecognizer() {
            //在某个方法识别失败后才继续当前手势的识别
            //如果导航栏的侧滑手势识别失败，才会执行scrolleview的手势
            scrollView.panGestureRecognizer.require(toFail: edgePan)
        }
        
        let cyclePictureView: WJCyclePictureView = WJCyclePictureView(frame: CGRect(x: 0, y: -kStatusBarH, width: kScreenWidth, height: kInfoSDrecycleViewH), pictures: arrImgUrl)
        cyclePictureView.direction = .left
        cyclePictureView.autoScrollDelay = 10
        cyclePictureView.pageControlStyle = .center
        cyclePictureView.placeholderImage = UIImage(named: "shouyebanner")
        cyclePictureView.didTapAtIndexHandle = { index in
            print("点击了第 (index + 1) 张图片")
        }
        view.addSubview(cyclePictureView)
        view.addSubview(self.bottomTableView)
       
        makeConstraints()
//        view.addSubview(bottomView())

        view.addSubview(self.naviView)
        naviView.addSubview(self.tuijianlabel)
        naviView.addSubview(self.sousuoView)
        
        down = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(pan:)))
        down.delegate = self
        down.addObserver(self, forKeyPath: "state", options: NSKeyValueObservingOptions.new, context: nil)
        view.addGestureRecognizer(down)
        _lasty = level3
        self.currentIndex = 0
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
        leftTableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
        rightTableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)

        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "state" {
            let pan:UIPanGestureRecognizer = object as! UIPanGestureRecognizer
            let frame = bottomTableView.frame
          
            if pan.state == .began {
                if frame.origin.y == level2 {
                    pan.isEnabled = true
                    self.tableViewArr[self.currentIndex].isScrollEnabled = false
                }else if frame.origin.y > level2 {
                    self.tableViewArr[self.currentIndex].isScrollEnabled = false
                    pan.isEnabled = true
                }
                _lasty = frame.origin.y
            }
            
            if pan.state == .ended && frame.origin.y == level2 {
                pan.isEnabled = false
                self.tableViewArr[self.currentIndex].isScrollEnabled = true
                _lasty = frame.origin.y
            }
            
        }else {
            

            if self.tableViewArr[self.currentIndex].contentOffset.y > 0 && bottomTableView.origin.y == level2{
                self.tableViewArr[self.currentIndex].isScrollEnabled = true
                down.isEnabled = false
            }
            
            if self.tableViewArr[self.currentIndex].contentOffset.y == 0 && bottomTableView.origin.y == level2{
                self.tableViewArr[self.currentIndex].isScrollEnabled = false
                
                down.isEnabled = true
            }
        }
        
    }
    
    @objc func handlePan(pan:UIPanGestureRecognizer) {
        let pos:CGPoint = pan.translation(in: pan.view)
        let y:CGFloat = pos.y + _lasty
        if y<=level2 && self.tableViewArr[self.currentIndex].isScrollEnabled == false  {
            self.ruleScrFrame(top: level2, withAnimate: false)
            naviView.backgroundColor = UIColor.white
            bottomLine.backgroundColor = UIColor.gray.alpha(0.3)
        }else if y>=level3 && self.tableViewArr[self.currentIndex].isScrollEnabled == false {
            self.ruleScrFrame(top: level3, withAnimate: false)
            naviView.backgroundColor = UIColor.white.alpha(0)
            bottomLine.backgroundColor = UIColor.gray.alpha(0)
        }else if y < level3 && y > level2 && self.tableViewArr[self.currentIndex].isScrollEnabled == false {
            UIView.animate(withDuration: 0.1) {
                var rect:CGRect = self.bottomTableView.frame
                rect.origin.y = y
                rect.size.height = kScreenHeight - y
                self.bottomTableView.frame = rect
                self.naviView.backgroundColor = UIColor.white.alpha(0)
                self.bottomLine.backgroundColor = UIColor.gray.alpha(0)
            }
        }
    }
    
    func ruleScrFrame(top:CGFloat,withAnimate:Bool) {
        let duration:CGFloat = withAnimate ? 0.1:0
        UIView.animate(withDuration: TimeInterval(duration)) {
            let y:CGFloat = top
            var rect:CGRect = self.bottomTableView.frame
            rect.origin.y = y
            rect.size.height = kScreenHeight - top
            self.bottomTableView.frame = rect
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index:NSInteger = NSInteger(scrollView.contentOffset.x / kScreenWidth)
        if scrollView.isEqual(self.scrollView) {
            let tempBtnChange:UIButton = view.viewWithTag(10000 + index) as! UIButton
            let restore:UIButton = view.viewWithTag(changeColorButtonId) as! UIButton
            restore.setTitleColor(UIColor.gray, for: .normal)
            tempBtnChange.setTitleColor(UIColor.red, for: .normal)
            changeColorButtonId = NSInteger(10000 + index)
        }else  {
            
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index:NSInteger = NSInteger(scrollView.contentOffset.x / kScreenWidth)
        self.currentIndex = index
        self.tableViewArr[currentIndex].isScrollEnabled = true

    }
    
    deinit {
        leftTableView.removeObserver(self, forKeyPath: "contentOffset")
        rightTableView.removeObserver(self, forKeyPath: "contentOffset")
    }

    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) {
            let pan:UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
            let pos = pan.velocity(in: pan.view)
            let y:CGFloat = bottomTableView.origin.y
            if (pos.y != 0 && y > level2) || (pos.y != 0 && y < level3) {
                self.tableViewArr[self.currentIndex].isScrollEnabled = false
                return true
            }else {
                return false
            }
        }
        
        if gestureRecognizer.isKind(of: UIPanGestureRecognizer.classForCoder()) {
            let pan = gestureRecognizer as? UIPanGestureRecognizer
            if ((pan?.translation(in: scrollView).x) ?? 0 > CGFloat(0)) && (scrollView.contentOffset.x == CGFloat(0)) {
                return false
            }
        }
        
        return false
        
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView {
            if indexPath.section == 0 {
                var cell = tableView.dequeueReusableCell(withIdentifier: "OtherInfoTopCell")
                if (cell == nil) {
                    cell = OtherInfoTopCell(style: .default, reuseIdentifier: "OtherInfoTopCell")
                }
                cell?.selectionStyle = .none
                cell?.separatorInset = UIEdgeInsets.init(top: 0, left: kScreenWidth, bottom: 0, right: 0)
                return cell!
            }else if indexPath.section == 1 {
                
                let otherHomeNewsCell = "center"
                var cell = tableView.dequeueReusableCell(withIdentifier: otherHomeNewsCell)
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: otherHomeNewsCell)
                    cell?.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
                    cell?.selectionStyle = .none
                }
                cell?.addSubview(addSectionView())
                return cell!
            }else {
                let otherHomeNewsCell = "bottom"
                var cell = tableView.dequeueReusableCell(withIdentifier: otherHomeNewsCell)
                if cell == nil {
                    cell = UITableViewCell(style: .default, reuseIdentifier: otherHomeNewsCell)
                    cell?.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
                    cell?.selectionStyle = .none
                }
                cell?.addSubview(biaozhun())
                return cell!
            }
        }else if tableView == rightTableView {
            let otherHomeNewsCell = "heheh"
            var cell = tableView.dequeueReusableCell(withIdentifier: otherHomeNewsCell)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: otherHomeNewsCell)
                cell?.selectionStyle = .none
            }
            cell?.textLabel?.text = "徐"
            return cell!
        }else if tableView == self.bottomTableView{
            let otherHomeNewsCell = "hedasdsaheh"
            var cell = tableView.dequeueReusableCell(withIdentifier: otherHomeNewsCell)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: otherHomeNewsCell)
                cell?.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
                cell?.selectionStyle = .none
            }
            cell?.addSubview(self.segmentView)
            cell!.addSubview(self.scrollView)

            return cell!
        }else {
            let otherHomeNewsCell = "hedadadadasdsaheh"
            var cell = tableView.dequeueReusableCell(withIdentifier: otherHomeNewsCell)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: otherHomeNewsCell)
                cell?.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
                cell?.selectionStyle = .none
            }
            cell?.textLabel?.text = "庆"

            return cell!
        }        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == leftTableView {
            if indexPath.section == 0 {
                return 80
            }
            return sectionH
        }else if tableView == bottomTableView {
            return kScreenHeight - kStatusBarH - kInfoSDrecycleViewH - 50
        }else {
            return 50
        }
      
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == bottomTableView {
            return 1
        }else {
            return 8
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
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
        firstlabel.layer.cornerRadius = 12
        firstlabel.textColor = kLabelGrayColor
        firstlabel.clipsToBounds = true
        firstlabel.textAlignment = .center
        firstlabel.font = UIFont.systemFont(ofSize: 12.0)
        firstlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(firstlabel)
        
        let secondlabel = UILabel.init(frame: CGRect(x: firstlabel.rightX + middleSpace, y: topLabel.bottomY + 30, width: 60, height: 24))
        secondlabel.text = "24-28岁"
        secondlabel.layer.cornerRadius = 12
        secondlabel.textColor = kLabelGrayColor
        secondlabel.clipsToBounds = true
        secondlabel.textAlignment = .center
        secondlabel.font = UIFont.systemFont(ofSize: 12.0)
        secondlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(secondlabel)
        
        let threelabel = UILabel.init(frame: CGRect(x: secondlabel.rightX + middleSpace, y: topLabel.bottomY + 30, width: 150, height: 24))
        threelabel.text = "工作地区:北京东城区"
        threelabel.layer.cornerRadius = 12
        threelabel.textColor = kLabelGrayColor
        threelabel.clipsToBounds = true
        threelabel.textAlignment = .center
        threelabel.font = UIFont.systemFont(ofSize: 12.0)
        threelabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(threelabel)
        
        let fourlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 90, height: 24))
        fourlabel.text = "150-170com"
        fourlabel.layer.cornerRadius = 12
        fourlabel.textColor = kLabelGrayColor
        fourlabel.clipsToBounds = true
        fourlabel.textAlignment = .center
        fourlabel.font = UIFont.systemFont(ofSize: 12.0)
        fourlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(fourlabel)
        
        let fivelabel = UILabel.init(frame: CGRect(x: fourlabel.rightX + middleSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        fivelabel.text = "47-80kg"
        fivelabel.layer.cornerRadius = 12
        fivelabel.textColor = kLabelGrayColor
        fivelabel.clipsToBounds = true
        fivelabel.textAlignment = .center
        fivelabel.font = UIFont.systemFont(ofSize: 12.0)
        fivelabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(fivelabel)
        
        let sixlabel = UILabel.init(frame: CGRect(x: fivelabel.rightX + middleSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 140, height: 24))
        sixlabel.text = "月收入:8000-12000"
        sixlabel.layer.cornerRadius = 12
        sixlabel.textColor = kLabelGrayColor
        sixlabel.clipsToBounds = true
        sixlabel.textAlignment = .center
        sixlabel.font = UIFont.systemFont(ofSize: 12.0)
        sixlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(sixlabel)
        
        let sevenlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: fourlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        sevenlabel.text = "本科"
        sevenlabel.layer.cornerRadius = 12
        sevenlabel.textColor = kLabelGrayColor
        sevenlabel.clipsToBounds = true
        sevenlabel.textAlignment = .center
        sevenlabel.font = UIFont.systemFont(ofSize: 12.0)
        sevenlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(sevenlabel)
        
        return sectionView
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
        firstlabel.layer.cornerRadius = 12
        firstlabel.textColor = kLabelGrayColor
        firstlabel.clipsToBounds = true
        firstlabel.textAlignment = .center
        firstlabel.font = UIFont.systemFont(ofSize: 12.0)
        firstlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(firstlabel)
        
        let secondlabel = UILabel.init(frame: CGRect(x: firstlabel.rightX + middleSpace, y: topLabel.bottomY + 30, width: 60, height: 24))
        secondlabel.text = "24岁"
        secondlabel.layer.cornerRadius = 12
        secondlabel.textColor = kLabelGrayColor
        secondlabel.clipsToBounds = true
        secondlabel.textAlignment = .center
        secondlabel.font = UIFont.systemFont(ofSize: 12.0)
        secondlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(secondlabel)
        
        let threelabel = UILabel.init(frame: CGRect(x: secondlabel.rightX + middleSpace, y: topLabel.bottomY + 30, width: 150, height: 24))
        threelabel.text = "工作地区:北京东城区"
        threelabel.layer.cornerRadius = 12
        threelabel.textColor = kLabelGrayColor
        threelabel.clipsToBounds = true
        threelabel.textAlignment = .center
        threelabel.font = UIFont.systemFont(ofSize: 12.0)
        threelabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(threelabel)
        
        let fourlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        fourlabel.text = "166com"
        fourlabel.layer.cornerRadius = 12
        fourlabel.textColor = kLabelGrayColor
        fourlabel.clipsToBounds = true
        fourlabel.textAlignment = .center
        fourlabel.font = UIFont.systemFont(ofSize: 12.0)
        fourlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(fourlabel)
        
        let fivelabel = UILabel.init(frame: CGRect(x: fourlabel.rightX + middleSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 60, height: 24))
        fivelabel.text = "47kg"
        fivelabel.layer.cornerRadius = 12
        fivelabel.textColor = kLabelGrayColor
        fivelabel.clipsToBounds = true
        fivelabel.textAlignment = .center
        fivelabel.font = UIFont.systemFont(ofSize: 12.0)
        fivelabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(fivelabel)
        
        let sixlabel = UILabel.init(frame: CGRect(x: fivelabel.rightX + middleSpace, y: firstlabel.bottomY + centerMiddleSpace, width: 140, height: 24))
        sixlabel.text = "月收入:8000-12000"
        sixlabel.layer.cornerRadius = 12
        sixlabel.textColor = kLabelGrayColor
        sixlabel.clipsToBounds = true
        sixlabel.textAlignment = .center
        sixlabel.font = UIFont.systemFont(ofSize: 12.0)
        sixlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(sixlabel)
        
        let sevenlabel = UILabel.init(frame: CGRect(x: topLabel.x + centerLeftSpace, y: fourlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        sevenlabel.text = "狮子座"
        sevenlabel.layer.cornerRadius = 12
        sevenlabel.textColor = kLabelGrayColor
        sevenlabel.clipsToBounds = true
        sevenlabel.textAlignment = .center
        sevenlabel.font = UIFont.systemFont(ofSize: 12.0)
        sevenlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(sevenlabel)
        
        let eightlabel = UILabel.init(frame: CGRect(x: sevenlabel.rightX + middleSpace, y: fourlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        eightlabel.text = "销售"
        eightlabel.layer.cornerRadius = 12
        eightlabel.textColor = kLabelGrayColor
        eightlabel.clipsToBounds = true
        eightlabel.textAlignment = .center
        eightlabel.font = UIFont.systemFont(ofSize: 12.0)
        eightlabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(eightlabel)
        
        let ninelabel = UILabel.init(frame: CGRect(x: eightlabel.rightX + middleSpace, y: fourlabel.bottomY + centerMiddleSpace, width: 70, height: 24))
        ninelabel.text = "本科"
        ninelabel.layer.cornerRadius = 12
        ninelabel.textColor = kLabelGrayColor
        ninelabel.clipsToBounds = true
        ninelabel.textAlignment = .center
        ninelabel.font = UIFont.systemFont(ofSize: 12.0)
        ninelabel.backgroundColor = UIColor.orange.alpha(0.3)
        sectionView.addSubview(ninelabel)
        return sectionView
    }
    
    
    
    lazy var leftTableView:UITableView = {
        let tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kStatusBarH - kInfoSDrecycleViewH - 50), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = kBgColor
        tableView.showsVerticalScrollIndicator = false
        tableView.register(OtherInfoTopCell.self, forCellReuseIdentifier: "OtherInfoTopCell")
        return tableView
    }()
    
    lazy var tableViewArr:[UITableView] = {
        let tableViewArr = [self.leftTableView,self.rightTableView]
        return tableViewArr
    }()
    
    lazy var rightTableView:UITableView = {
        let tableView = UITableView(frame: CGRect.init(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight - kStatusBarH - kInfoSDrecycleViewH - 50), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.blue
        tableView.showsVerticalScrollIndicator = false
        tableView.register(OtherInfoTopCell.self, forCellReuseIdentifier: "OtherInfoTopCell")
        
        return tableView
    }()
    
//    lazy var containView:UIView = {
//        let containView = UIView.init(frame: CGRect(x: 0, y: level3, width: kScreenWidth, height: kScreenHeight - kStatusBarH - kInfoSDrecycleViewH - 50))
//        containView.backgroundColor = UIColor.white
//        containView.addSubview(self.segmentView)
//        containView.addSubview(self.scrollView)
//        containView.isUserInteractionEnabled = true
//        return containView
//    }()
    
    lazy var bottomTableView:UITableView = {
        let tableView = UITableView(frame: CGRect.init(x: 0, y: level3, width: kScreenWidth, height: kScreenHeight - kStatusBarH - kInfoSDrecycleViewH - 50), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = kBgColor
        tableView.showsVerticalScrollIndicator = false
        tableView.register(OtherInfoTopCell.self, forCellReuseIdentifier: "OtherInfoTopCell")
        
        return tableView
    }()
    
    

    private lazy var segmentView: UIScrollView = {
        let segmentView = UIScrollView.init(frame: CGRect(x: 20, y: 0, width: 100, height: 50))
        segmentView.contentSize = CGSize.init(width: 100, height: 50)
        segmentView.delegate = self
        let btnWidth:CGFloat = segmentView.width / 2.0
        let titleArr = ["资料","动态"]
        for i in 0...titleArr.count - 1 {
            let titleBtn = UIButton.init(type: .custom)
            titleBtn.setTitle(titleArr[i], for: .normal)
            titleBtn.setTitleColor(UIColor.gray, for: .normal)
            if i == 0 {
                titleBtn.setTitleColor(UIColor.red, for: .normal)
            }
            titleBtn.tag = 10000 + i
            titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20.0)
            titleBtn.frame = CGRect(x: btnWidth*CGFloat(i), y: 0, width: btnWidth, height: 50)
            titleBtn.addTarget(self, action: #selector(customBtnClick(sender:)), for: .touchUpInside)
            segmentView.addSubview(titleBtn)
        }
        return segmentView
    }()
    
    @objc func customBtnClick(sender:UIButton) {
        let tempBtn:UIButton = self.view.viewWithTag(changeColorButtonId) as! UIButton
        tempBtn.setTitleColor(UIColor.gray, for: .normal)
        changeColorButtonId = sender.tag
        let index = sender.tag - 10000
        var offset = self.scrollView.contentOffset
        offset.x = CGFloat(index)*self.scrollView.frame.size.width
        self.scrollView.setContentOffset(offset, animated: true)
        self.currentIndex = index
    }
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect(x: 0, y: segmentView.bottomY, width: kScreenWidth, height: kScreenHeight - kStatusBarH - kInfoSDrecycleViewH - 50))
        scrollView.backgroundColor = UIColor.red
        scrollView.bounces = false
        scrollView.contentSize = CGSize.init(width: kScreenWidth*2, height: bottomTableView.height - segmentView.height)
        self.scrContainView = UIView.init()
        self.scrContainView.backgroundColor = UIColor.blue
        scrollView.addSubview(self.scrContainView)
        self.scrContainView.addSubview(self.leftTableView)
        self.scrContainView.addSubview(self.rightTableView)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var tuijianlabel:UILabel = {
        let tuijianlabel = UILabel.init(frame: CGRect(x: (kScreenWidth - 100) / 2.0, y: 8 + kStatusBarH, width: 100, height: 22))
        tuijianlabel.text = "个人"
        tuijianlabel.textColor = UIColor.white
        tuijianlabel.textAlignment = .center
        tuijianlabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        return tuijianlabel
    }()
    
    lazy var naviView:UIView = {
        let naviView = UIView()
        naviView.frame = CGRect(x: 0, y: 0, width:kScreenWidth, height:  kNavH + kStatusBarH)
        naviView.backgroundColor = UIColor(white: 1, alpha: 0)
        naviView.addSubview(self.bottomLine)
        return naviView
    }()
    
    lazy var bottomLine:UIView = {
        let bottomLine = UIView.init(frame: CGRect(x: 0, y: kNavH + kStatusBarH - 0.5, width: kScreenWidth, height: 0.5))
        bottomLine.backgroundColor = UIColor.gray.alpha(0)
        return bottomLine
    }()
    
    lazy var sousuoView:UIView = {
        let sousuoView = UIView.init(frame: CGRect(x: 15, y: kStatusBarH, width: kNavH, height: kNavH))
        let sousuo = UIImageView.init(frame: CGRect(x: 0, y: 8, width: 21, height: 21))
        sousuo.image = UIImage(named:"fanhui")
        sousuoView.addSubview(sousuo)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.pushAdvertising))
        sousuoView.isUserInteractionEnabled = true
        sousuoView.addGestureRecognizer(tapGR)
        return sousuoView
    }()
    
    
    
    func makeConstraints() {
//        scrollView.snp.makeConstraints { (make) in
//            make.top.equalTo(segmentView.bottomY)
//            make.left.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.right.equalToSuperview()
//        }
        
        scrContainView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(kScreenWidth*2)
        }
        
        bottomTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(kScreenWidth*2)
        }
        
        leftTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalTo(rightTableView.left)
            make.height.equalToSuperview()
        }
        rightTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(kScreenWidth)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    
}
