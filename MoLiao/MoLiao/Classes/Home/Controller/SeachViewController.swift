
//
//  SeachViewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/27.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit
import BetterSegmentedControl
class SeachViewController: BaseViewController {
    var control:BetterSegmentedControl!
    var scrollView:WJScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜索"
        
        scrollView = WJScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        scrollView.contentSize = CGSize.init(width: kScreenWidth * 2, height: kScreenHeight)
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self

        self.view.addSubview(scrollView)
        
       let vc = BiaoQianSearchController()
        vc.view.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.addChild(vc)
        scrollView.addSubview(vc.view)
        
        let convc = ConditionSearchController()
        convc.view.frame = CGRect(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight)
        self.addChild(convc)
        scrollView.addSubview(convc.view)
        
        control = BetterSegmentedControl(
            frame: CGRect(x: (kScreenWidth - 150) / 2.0, y: 0, width: 150, height: 30),
            segments: LabelSegment.segments(withTitles: ["标签","筛选"],
                                            normalFont: UIFont.systemFont(ofSize: 14.0),
                                            normalTextColor: .black,
                                            selectedFont: UIFont.systemFont(ofSize: 14.0),
                                            selectedTextColor: .black),
            index: 0,
            options: [.backgroundColor(kLightGrayColor),
                      .indicatorViewBackgroundColor(kWhiteColor)])
        control.cornerRadius = 5
        control.addTarget(self, action: #selector(self.controlValueChanged(_:)), for: .valueChanged)
        navigationItem.titleView = control
        
        NotificationCenter.default.addObserver(self, selector: #selector(shouyRefresh), name: NSNotification.Name(rawValue: "shouyRefresh"), object: nil)
    }
    
    @objc func shouyRefresh(notifation:Notification){
        let userInfo = notifation.userInfo
        let aa:String = userInfo!["isScrolleView"] as! String
        if aa == "scrollviewTrue" {
             self.scrollView.isScrollEnabled = true
        }else {
             self.scrollView.isScrollEnabled = false
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }
    
    @objc func controlValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }else if sender.index == 1{
            scrollView.setContentOffset(CGPoint(x: kScreenWidth, y: 0), animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isEqual(self.scrollView) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "biaoqianshouyRefresh"), object: self, userInfo: ["isScrolleView":"scrollviewFalse"])
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "biaoqianshouyRefresh"), object: self, userInfo: ["isScrolleView":"scrollviewTrue"])

    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexx = (scrollView.contentOffset.x)/scrollView.frame.size.width
        control.setIndex(UInt(indexx), animated: true)
    }
    
}






































