//
//  HomeNewController.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/21.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
import Kingfisher

typealias HomeNewDelegate = NewPagedFlowViewDelegate & NewPagedFlowViewDataSource

/// 首页 - 推荐
class HomeNewController: BaseTabViewController  {
    
    var userLabel:UILabel!
    var userDetailLabel:UILabel!
    var pageFlowView:NewPagedFlowView!
    var centerFlowView:NewPagedFlowView!
    fileprivate var arrDataCommon = [HomeModel]()
    fileprivate var titlesGroup = ["楚秋燕","王丽丽","海燕","月月","丽丽","王格格","好雨知时节"]
    fileprivate var detailTitleArr = ["北京 | 27岁 | 人力资源总监","北京 | 29岁 | 测试工程师","北京 | 26岁 | 销售经理","北京 | 26岁 | 产品经理","北京 | 27岁 | 人力资源总监","北京 | 29岁 | 测试工程师","北京 | 26岁 | 销售经理"]
    fileprivate var topGroup = ["home_one","home_two","home_three"]
    fileprivate var iconGroup = ["0000","1111","2222","3333","4444","5555"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 导航栏创建
        setupNavView()
        /// Json 数据
        getJsonData()
        /// tableView 的基本数据
        setupBaseTableView()
        /// 创建 Ui
        setupView()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

// MARK:-  UI创建
extension HomeNewController {
    /// 导航栏创建
    private func setupNavView() {
        self.title = "推荐"
        
        navigationController?.navigationBar.shadowImage = UIImage.init()
        
        /// 导航栏搜索右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "sousuo"), style: .plain, target: self, action: #selector(SearchNavClick))
    }
    
    /// Json 数据
    private func getJsonData() {
        let strDataPath = Bundle.main.path(forResource: "home", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        let json = DataJson().data2JSON(data: data! as Data)
        buildModelCommonByJson(json["data"])
    }
    
    /// tableView 的基本数据
    private func setupBaseTableView() {
        tableView.height = kScreenHeight - kTabbarHeight - kStatusBarH - kNavH
        tableView.register(HomeCell.self, forCellReuseIdentifier: "HomeCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none//去除分割线
    }
    /// 广告轮播器
    private func setupHeadView() {
        /// 广告轮播器
        pageFlowView = NewPagedFlowView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 170))
        pageFlowView.delegate = self
        pageFlowView.dataSource = self
        let pageControl = UIPageControl.init(frame: CGRect(x: 0, y: pageFlowView.frame.size.height - 8, width: kScreenWidth, height: 8))
        pageControl.pageIndicatorTintColor = UIColor.gray.alpha(0.3)
        pageControl.currentPageIndicatorTintColor = UIColor.orange.alpha(0.7)
        pageFlowView.pageControl = pageControl
        pageFlowView.addSubview(pageControl)
        pageFlowView.reloadData()
        
        tableView.tableHeaderView = pageFlowView
    }
    
    private func setupView() {
//        let headerView = UIView.init()
        
        /// 广告轮播器
        setupHeadView()
        
        
        
        /*
        centerFlowView = NewPagedFlowView.init(frame: CGRect(x: 0, y: leftLabel.bottomY, width: kScreenWidth, height: 140*widthRatio))
        centerFlowView.leftRightMargin = 40
        centerFlowView.isOpenAutoScroll = false
        centerFlowView.delegate = self
        centerFlowView.dataSource = self
        centerFlowView.reloadData()
        headerView.addSubview(centerFlowView)
        
        userLabel = UILabel.init(frame: CGRect(x: 0, y: centerFlowView.bottomY, width: kScreenWidth, height: 20))
        userLabel.text = titlesGroup[0]
        userLabel.textAlignment = .center
        userLabel.font = UIFont.systemFont(ofSize: 14.0)
        headerView.addSubview(userLabel)
        
        userDetailLabel = UILabel.init(frame: CGRect(x: leftSpace_20, y: userLabel.bottomY, width: kScreenWidth - 2 * leftSpace_20, height: 20))
        userDetailLabel.textAlignment = .center
        userDetailLabel.text = detailTitleArr[0]
        userDetailLabel.textColor = UIColor.gray
        userDetailLabel.font = UIFont.systemFont(ofSize: 14.0)
        headerView.addSubview(userDetailLabel)
        
        let meiriLabel = UILabel.init(frame: CGRect(x: leftSpace_20, y: userDetailLabel.bottomY + 5, width: 200, height: 30))
        meiriLabel.text = "真心推荐"
        meiriLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight(rawValue: 1.2))
        headerView.addSubview(meiriLabel)
        
        headerView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: pageFlowView.height + centerFlowView.height + leftLabel.height + userLabel.height + 30 + meiriLabel.height + userDetailLabel.height)
        tableView.tableHeaderView = headerView
 
 */
    }
}

extension HomeNewController {
    
}

extension HomeNewController {
    
}

// MARK:- UITableViewDelegate || UITableViewDataSource
extension HomeNewController: HomeNewDelegate {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        else {
            print("section = \(section)")
            return arrDataCommon.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell
        if (cell == nil) {
            cell = HomeCell(style: .default, reuseIdentifier: "HomeCell")
        }
        cell?.selectionStyle = .none
        let model = arrDataCommon[indexPath.row]
        cell?.model = model
        cell?.topOneLabel.text = model.topTwoTitle
        cell?.topTwoLabel.text = "| " + model.topThreeTitle
        cell?.topThreeLabel.text = "| " +  model.centerTwoTitle
        cell?.centerOneLabel.text = "| " + model.topOneTitle
        cell?.userImg.image = UIImage(named: model.Picture)
        cell?.img_NameLabel.text = model.Title
        cell?.img_BottomLabel.text = model.Content
        if model.isHuiYuan {
            cell?.img_huiyuan.isHidden = false
        }else {
            cell?.img_huiyuan.isHidden = true
        }
        
        return cell!
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OtherInformationController()
        vc.isNavHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK:- UITableViewHeaderView
extension HomeNewController {
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        if indexPath.section == 0 {
//            return 100
//        }
//        return 140
//    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    /// 使用 viewForHeaderInSection -> UIView 必须实现 heightForHeaderInSection -> CGFloat 方法，否则没有View
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { // 最佳匹配
            let headView = MLHeadFirstView(frame: CGRect(x: leftSpace_20, y:  20, width: 200, height: 50))
            headView.setupContext(leftLabel: "最佳匹配", rightLabel: "查看更多")
            return headView
        } else if section == 1 { // 真心推荐
            let headView = MLHeadFirstView(frame: CGRect(x: leftSpace_20, y:  20, width: 200, height: 50))
            headView.setupContext(leftLabel: "真心推荐", rightLabel: nil)
            return headView
        }
        
        let  view = UIView()
        view.backgroundColor = UIColor.black
        return UIView()
    }
}

// MARK:- UIScrollViewDelegate
extension HomeNewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        
        if currentOffsetY >= kNavH + kStatusBarH {
            navigationController?.navigationBar.shadowImage = getImageWithColor(color: UIColor.gray.alpha(0.3))
        }else {
            navigationController?.navigationBar.shadowImage = UIImage.init()
        }
    }
}

// MARK:- NewPagedFlowViewDelegate & NewPagedFlowViewDataSource
extension HomeNewController {
    func didScroll(toPage pageNumber: Int, in flowView: NewPagedFlowView!) {
        if flowView == pageFlowView {
            
        }else {
            userLabel.text = titlesGroup[pageNumber]
            userDetailLabel.text = detailTitleArr[pageNumber]
        }
    }
    func didSelectCell(_ subView: PGIndexBannerSubiew!, withSubViewIndex subIndex: Int) {
        let vc = OtherInformationController()
        vc.isNavHidden = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sizeForPage(in flowView: NewPagedFlowView!) -> CGSize {
        if flowView == pageFlowView {
            return CGSize(width: kScreenWidth - 60, height: 140)
        }else {
            return CGSize(width: 120*widthRatio, height: 120*widthRatio)
        }
    }
    
    func numberOfPages(in flowView: NewPagedFlowView!) -> Int {
        
        if flowView == pageFlowView {
            return topGroup.count
        }else {
            return iconGroup.count
        }
    }
    
    func flowView(_ flowView: NewPagedFlowView!, cellForPageAt index: Int) -> PGIndexBannerSubiew! {
        if flowView == pageFlowView {
            var bannerView = flowView.dequeueReusableCell()
            if !(bannerView != nil) {
                bannerView = PGIndexBannerSubiew.init()
                bannerView?.tag = index
                bannerView?.layer.cornerRadius = 4
                bannerView?.layer.masksToBounds = true
            }
            bannerView?.mainImageView.image = UIImage(named: topGroup[index])
            return bannerView
        }else {
            var bannerView = flowView.dequeueReusableCell()
            if !(bannerView != nil) {
                bannerView = PGIndexBannerSubiew.init()
                bannerView?.tag = index
                bannerView?.layer.cornerRadius = 4
                bannerView?.layer.masksToBounds = true
            }
            bannerView?.mainImageView.image = UIImage(named: iconGroup[index])
            return bannerView
        }
        
    }
}

// MARK:- 获取 JSON 里面的数据
extension HomeNewController {
    /// 获取 JSON 里面的数据 给 arrDataCommon 赋值
    func buildModelCommonByJson(_ json: JSON){
        print("json==",json)
        
        self.arrDataCommon.removeAll()
        
        for item in json.arrayValue {
            let model = HomeModel()
            model.Title = item["Title"].stringValue
            model.Content = item["Content"].stringValue
            model.isHuiYuan = item["isHuiYuan"].boolValue
            model.isDuBai = item["isDuBai"].boolValue
            model.Picture = item["Picture"].stringValue
            model.topOneTitle = item["topOneTitle"].stringValue
            model.topTwoTitle = item["topTwoTitle"].stringValue
            model.topThreeTitle = item["topThreeTitle"].stringValue
            model.centerOneTitle = item["centerOneTitle"].stringValue
            model.centerTwoTitle = item["centerTwoTitle"].stringValue
            model.centerThreeTitle = item["centerThreeTitle"].stringValue
            self.arrDataCommon.append(model)
        }
    }
}

// MARK:- 按钮点击事件 - 查看更多 || 导航栏搜索按钮
extension HomeNewController {
    
    /// 导航栏搜索按钮
    @objc private func SearchNavClick() {
        let vc = ConditionSearchController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
