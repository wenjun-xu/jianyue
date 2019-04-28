

//
//  HomeCell.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/27.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    private var bgView: UIView!
    private var model: HomeModel!
    /// 用户头像
    private var userImg: UIImageView!
    /// 会员图片
    private var img_huiyuan: UIImageView!
    /// 名字
    private var img_NameLabel: UILabel!
    
    /// 北京
    private var topOneLabel: UILabel!
    /// 24岁
    private var topTwoLabel: UILabel!
    /// 大学本科
    private var topThreeLabel: UILabel!
    
    /// 160cm
    private var centerOneLabel: UILabel!
    /// 简介
    private var img_BottomLabel: UILabel!
    
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
    
    class func cell(tableView: UITableView) -> HomeCell{
        let indentifier:String = "HomeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        
        if cell == nil {
            cell = HomeCell(style: .default, reuseIdentifier: indentifier)
            cell?.backgroundColor = UIColor.white
            cell?.selectionStyle = .none;
        }
        
        return cell  as! HomeCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
        
    }
    
    override func layoutSubviews() {
        setupFrame()
    }
}

// MARK:- 外界传值
extension HomeCell {
    public func setupData(model: HomeCellModel) {
 
        userImg.image = UIImage(named: model.Picture)
        img_NameLabel.text = model.Title
        topOneLabel.text = model.topTwoTitle
        topTwoLabel.text = "| " + model.topThreeTitle
        topThreeLabel.text = "| " +  model.centerTwoTitle
        centerOneLabel.text = "| " + model.topOneTitle
        img_BottomLabel.text = model.Content
        
        if model.isHuiYuan {
            img_huiyuan.isHidden = false
        }else {
            img_huiyuan.isHidden = true
        }

        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 5
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14.0),
                          NSAttributedString.Key.paragraphStyle: paraph]
        img_BottomLabel.attributedText = NSAttributedString(string: img_BottomLabel.text!, attributes: attributes)
    }
}

// MARK:- UI创建
extension HomeCell {
    
    /// UI创建
    private func setUpUI() {
        bgView = UIView()
        bgView.backgroundColor = UIColor.white
        //        bgView.layer.cornerRadius = 5
        bgView.layer.shadowColor = UIColor.gray.alpha(0.3).cgColor
        bgView.layer.shadowRadius = 5
        bgView.layer.shadowOpacity = 0.6
        bgView.layer.shadowOffset = CGSize(width: 1, height: 2)
        
        self.contentView.addSubview(bgView)
        userImg = UIImageView()
        bgView.addSubview(userImg)
        
        img_NameLabel = UILabel()
        img_NameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        img_NameLabel.textColor = kLabelBlackColor
        bgView.addSubview(img_NameLabel)
        
        topOneLabel = UILabel()
        topOneLabel.font = UIFont.systemFont(ofSize: 12.0)
        topOneLabel.textColor = kLabelBlackColor
        bgView.addSubview(topOneLabel)
        
        topTwoLabel = UILabel()
        topTwoLabel.font = UIFont.systemFont(ofSize: 12.0)
        topTwoLabel.textColor = kLabelBlackColor
        bgView.addSubview(topTwoLabel)
        
        topThreeLabel = UILabel()
        topThreeLabel.font = UIFont.systemFont(ofSize: 12.0)
        topThreeLabel.textColor = kLabelBlackColor
        bgView.addSubview(topThreeLabel)
        
        centerOneLabel = UILabel()
        centerOneLabel.font = UIFont.systemFont(ofSize: 12.0)
        centerOneLabel.textColor = kLabelBlackColor
        bgView.addSubview(centerOneLabel)
        
        img_BottomLabel = UILabel()
        
        img_BottomLabel.textColor = kBlackAlphaColor
        img_BottomLabel.numberOfLines = 0
        img_BottomLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        
        bgView.addSubview(img_BottomLabel)
        img_huiyuan = UIImageView()
        img_huiyuan.image = UIImage(named: "huiyuan")
        bgView.addSubview(img_huiyuan)
        
    }
    
    /// 尺寸
    private func setupFrame() {
        var expectSize = CGSize(width: 0, height: 0)
        expectSize = img_NameLabel.sizeThatFits(CGSize(width: 999, height: 25))
        
        var topOneLabelSize = CGSize(width: 0, height: 0)
        topOneLabelSize = topOneLabel.sizeThatFits(CGSize(width: 999, height: 22))
        
        var topTwoLabelSize = CGSize(width: 0, height: 0)
        topTwoLabelSize = topTwoLabel.sizeThatFits(CGSize(width: 999, height: 22))
        
        var topThreeLabelSize = CGSize(width: 0, height: 0)
        topThreeLabelSize = topThreeLabel.sizeThatFits(CGSize(width: 999, height: 22))
        
        var centerOneLabelSize = CGSize(width: 0, height: 0)
        centerOneLabelSize = centerOneLabel.sizeThatFits(CGSize(width: 999, height: 20))
        
        let leftSpeace:CGFloat = 10
        let topSpeace:CGFloat = 10
        let bgLeft:CGFloat = 16
        let bgTop:CGFloat = 8
        let imgH:CGFloat = 80
        let labelSpace:CGFloat = 10
        
        bgView.frame = CGRect(x: bgLeft, y: bgTop, width: self.width - 2*bgLeft, height: self.height - 2*bgTop)
        userImg.frame = CGRect(x: leftSpeace, y: topSpeace, width: imgH, height: imgH)
        img_NameLabel.frame = CGRect(x:userImg.rightX + labelSpace , y: topSpeace, width: expectSize.width, height: 25)
        img_huiyuan.frame = CGRect(x: img_NameLabel.rightX + 2, y: topSpeace + 3, width: 15, height: 15)
        
        topOneLabel.frame = CGRect(x:userImg.rightX + labelSpace , y: img_NameLabel.bottomY, width: topOneLabelSize.width, height: 22)
        topTwoLabel.frame = CGRect(x:topOneLabel.rightX + 2, y: img_NameLabel.bottomY, width: topTwoLabelSize.width, height: 22)
        
        topThreeLabel.frame = CGRect(x:topTwoLabel.rightX + 2 , y: img_NameLabel.bottomY, width: topThreeLabelSize.width, height: 22)
        
        centerOneLabel.frame = CGRect(x:topThreeLabel.rightX + 2 , y: img_NameLabel.bottomY, width: centerOneLabelSize.width, height: 20)
        
        img_BottomLabel.frame = CGRect(x:userImg.rightX + labelSpace , y: centerOneLabel.bottomY + 10, width: bgView.width - 2*leftSpeace - userImg.width - labelSpace, height: 50)
        
        
    }
}
