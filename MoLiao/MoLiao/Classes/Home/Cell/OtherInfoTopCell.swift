//
//  OtherInfoTopCell.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/16.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class OtherInfoTopCell: UITableViewCell {
    var model:HomeModel!
   
    var img_NameLabel:UILabel!
    
    var topOneLabel:UILabel!
    var topTwoLabel:UILabel!
    var topThreeLabel:UILabel!
    var guanzhuBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cell(tableView: UITableView) -> OtherInfoTopCell{
        let indentifier:String = "OtherInfoTopCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        
        if cell == nil {
            cell = OtherInfoTopCell(style: .default, reuseIdentifier: indentifier)
            cell?.separatorInset = UIEdgeInsets.init(top: 0, left: kScreenWidth, bottom: 0, right: 0)
            cell?.backgroundColor = UIColor.white
            cell?.selectionStyle = .none;
        }
        
        return cell  as! OtherInfoTopCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
   
    override func layoutSubviews() {
        setupFrame()
    }
    
}
// MARK:- 事件点击
extension OtherInfoTopCell {
    @objc private func guanzhuClick(sender:UIButton) {
        if sender.isSelected {
            
        }else {
            
        }
        sender.isSelected = !sender.isSelected
    }
}

// MARK:- UI创建
extension OtherInfoTopCell {
    private func setUpUI() {
        
        img_NameLabel = UILabel()
        img_NameLabel.text = "孙小美"
        img_NameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        img_NameLabel.textColor = kLabelBlackColor
        self.contentView.addSubview(img_NameLabel)
        
        topOneLabel = UILabel()
        topOneLabel.text = "北京"
        topOneLabel.font = UIFont.systemFont(ofSize: 12.0)
        topOneLabel.textColor = kLabelBlackColor
        self.contentView.addSubview(topOneLabel)
        
        topTwoLabel = UILabel()
        topTwoLabel.text = "24岁"
        topTwoLabel.font = UIFont.systemFont(ofSize: 12.0)
        topTwoLabel.textColor = kLabelBlackColor
        self.contentView.addSubview(topTwoLabel)
        
        topThreeLabel = UILabel()
        topThreeLabel.text = "大学本科"
        topThreeLabel.font = UIFont.systemFont(ofSize: 12.0)
        topThreeLabel.textColor = kLabelBlackColor
        self.contentView.addSubview(topThreeLabel)
        
        guanzhuBtn = UIButton.init(type: .custom)
        guanzhuBtn.setTitle("关注", for: .normal)
        guanzhuBtn.setTitle("已关注", for: .selected)
        guanzhuBtn.titleEdgeInsets = UIEdgeInsets.init(top: 8, left: 0, bottom: 8, right: 0)
        guanzhuBtn.backgroundColor = UIColor.orange
        guanzhuBtn.layer.cornerRadius = 15
        guanzhuBtn.clipsToBounds = true
        guanzhuBtn.addTarget(self, action: #selector(guanzhuClick(sender:)), for: .touchUpInside)
        self.contentView.addSubview(guanzhuBtn)
    }
    
    private func setupFrame() {
        let guanzhuH:CGFloat = 30
        var expectSize = CGSize(width: 0, height: 0)
        expectSize = img_NameLabel.sizeThatFits(CGSize(width: 999, height: 25))
        
        var topOneLabelSize = CGSize(width: 0, height: 0)
        topOneLabelSize = topOneLabel.sizeThatFits(CGSize(width: 999, height: 22))
        
        var topTwoLabelSize = CGSize(width: 0, height: 0)
        topTwoLabelSize = topTwoLabel.sizeThatFits(CGSize(width: 999, height: 22))
        
        var topThreeLabelSize = CGSize(width: 0, height: 0)
        topThreeLabelSize = topThreeLabel.sizeThatFits(CGSize(width: 999, height: 22))
        
        let topSpeace:CGFloat = 16
        let labelSpace:CGFloat = 24
        img_NameLabel.frame = CGRect(x: labelSpace , y: topSpeace, width: expectSize.width, height: 25)
        
        topOneLabel.frame = CGRect(x:labelSpace , y: img_NameLabel.bottomY, width: topOneLabelSize.width, height: 22)
        topTwoLabel.frame = CGRect(x:topOneLabel.rightX + 2, y: img_NameLabel.bottomY, width: topTwoLabelSize.width, height: 22)
        
        topThreeLabel.frame = CGRect(x:topTwoLabel.rightX + 2 , y: img_NameLabel.bottomY, width: topThreeLabelSize.width, height: 22)
        
        guanzhuBtn.frame = CGRect(x: kScreenWidth - 100, y: (self.height - guanzhuH) / 2.0, width: 80, height: guanzhuH)
    }
}
