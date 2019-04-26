//
//  MLBastContentCell.swift
//  MoLiao
//
//  Created by study on 2019/4/26.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

protocol MLBastContentCellDelegate: NSObjectProtocol {
    func didSelectCell(_ view: MLBastContentCell!, withSubViewIndex subIndex: Int)
}

/// 最佳匹配
class MLBastContentCell: UITableViewCell {
    fileprivate var iconGroup = ["0000","1111","2222","3333","4444","5555"]
    
    private var centerFlowView: NewPagedFlowView!
    private var userLabel:UILabel!
    private var userDetailLabel:UILabel!
    
    weak var delegate: MLBastContentCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    class func cell(tableView: UITableView) -> MLBastContentCell{
        let indentifier:String = "MLBastContentCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        
        if cell == nil {
            cell = MLBastContentCell(style: .default, reuseIdentifier: indentifier)
            cell?.backgroundColor = UIColor.white
            cell?.selectionStyle = .none;
        }
        
        return cell  as! MLBastContentCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(#function)
    }
}

// MARK:- UI赋值
extension MLBastContentCell {
    public func setupData(userString: String, detail: String) {
        userLabel.text =  userString
        userDetailLabel.text = detail 
    }
}

// MARK:- UI创建
extension MLBastContentCell {
    private func setupCellUI(){
        centerFlowView = NewPagedFlowView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 140 * widthRatio))
        centerFlowView.leftRightMargin = 40
        centerFlowView.isOpenAutoScroll = false
        centerFlowView.delegate = self
        centerFlowView.dataSource = self
        centerFlowView.reloadData()
        
        contentView.addSubview(centerFlowView)
        
        userLabel = UILabel.init(frame: CGRect(x: 0, y: centerFlowView.bottomY, width: kScreenWidth, height: 20))
        userLabel.textAlignment = .center
        userLabel.font = UIFont.systemFont(ofSize: 14.0)
        contentView.addSubview(userLabel)

        userDetailLabel = UILabel.init(frame: CGRect(x: leftSpace_20, y: userLabel.bottomY, width: kScreenWidth - 2 * leftSpace_20, height: 20))
        userDetailLabel.textAlignment = .center
        userDetailLabel.textColor = UIColor.gray
        userDetailLabel.font = UIFont.systemFont(ofSize: 14.0)
        contentView.addSubview(userDetailLabel)
    }
}

// MARK:- NewPagedFlowViewDelegate, NewPagedFlowViewDataSource
extension MLBastContentCell: NewPagedFlowViewDelegate, NewPagedFlowViewDataSource {
    func numberOfPages(in flowView: NewPagedFlowView!) -> Int {
        return iconGroup.count
    }
    
    func flowView(_ flowView: NewPagedFlowView!, cellForPageAt index: Int) -> PGIndexBannerSubiew! {
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
    
    func didScroll(toPage pageNumber: Int, in flowView: NewPagedFlowView!) {
//        userLabel.text = titlesGroup[pageNumber]
//        userDetailLabel.text = detailTitleArr[pageNumber]
    }
    
    func didSelectCell(_ subView: PGIndexBannerSubiew!, withSubViewIndex subIndex: Int) {
        self.delegate?.didSelectCell(self, withSubViewIndex: subIndex)

    }
    
    func sizeForPage(in flowView: NewPagedFlowView!) -> CGSize {
        return CGSize(width: 120 * widthRatio, height: 120 * widthRatio)
    }
}
