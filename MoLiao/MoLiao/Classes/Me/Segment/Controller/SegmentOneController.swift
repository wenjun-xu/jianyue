//
//  SegmentOneController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/2.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class SegmentOneController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UIGestureRecognizerDelegate, UIScrollViewDelegate{
    var tableView = UITableView()
    var scrollView = UIScrollView()
    var canScrolll:Bool!
    var selectedPageIndex:NSNumber!
    override func viewDidLoad() {
        super.viewDidLoad()
        canScrolll = true
        NotificationCenter.default.addObserver(self, selector: #selector(acceptMsg), name: NSNotification.Name(rawValue: "goTop"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(acceptMsg), name: NSNotification.Name(rawValue: "leaveTop"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(acceptMsg), name: NSNotification.Name(rawValue: "CurrentSelectedChildViewControllerIndex"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(acceptMsg), name: NSNotification.Name(rawValue: "SegementViewChildVCBackToTop"), object: nil)

        
        tableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - kNavH - kStatusBarH), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = kBgColor
        view.addSubview(tableView)
    }
    
    @objc func acceptMsg(notification:Notification) {
        let userInfo = notification.userInfo
        if notification.name.rawValue == "goTop" {
            let canScroll:String = userInfo!["canScroll"] as! String
            if canScroll == "1" {
                self.canScrolll = true
                self.scrollView.showsVerticalScrollIndicator = true
            }else {
                canScrolll = false
            }
        }else if notification.name.rawValue == "leaveTop" {
            canScrolll = false
            self.scrollView.contentOffset = .zero
            self.scrollView.showsVerticalScrollIndicator = false
        }else if notification.name.rawValue == "CurrentSelectedChildViewControllerIndex" {
//            let canScroll:String = userInfo!["canScroll"] as! String

        }else if notification.name.rawValue == "SegementViewChildVCBackToTop" {
            self.scrollView.setContentOffset(.zero, animated: true)
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.canScrolll {
            scrollView.setContentOffset(.zero, animated: true)
        }
        let offsetY = scrollView.contentOffset.y
        if offsetY <= 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "leaveTop"), object: self, userInfo: ["canScroll":"1"])
        }
        self.scrollView = scrollView
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        cell.textLabel?.text = "昵称"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 45
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
