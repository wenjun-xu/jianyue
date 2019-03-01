//
//  WJDynamicCell.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/4.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class WJDynamicCell: UITableViewCell {
    var dataModel:WJDynamicModel!
    var userImg = UIImageView()
    var userName = UILabel()
    var userContent = UILabel()
    var topOneLabel = UILabel()
    var topTwoLabel = UILabel()
    var topThreeLabel = UILabel()
    var userPingLunImg = UIImageView()
    var timeLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContentViewsourceModel(model:WJDynamicModel)-> CGFloat {
        userName.text = model.Title
        userImg.image = UIImage(named: model.Picture)
        userContent.text = model.Content
        topOneLabel.text = model.topOneTitle
        topTwoLabel.text = "| " + model.topTwoTitle
        topThreeLabel.text = "| " +  model.topThreeTitle
        
        let leftSpace:CGFloat = 16
        let imgLeftSpace:CGFloat = 15
        let userImgW:CGFloat = 45
        let userContentW:CGFloat = kScreenWidth - 2*leftSpace - userImgW - imgLeftSpace
    
        var topOneLabelSize = CGSize(width: 0, height: 0)
        topOneLabelSize = topOneLabel.sizeThatFits(CGSize(width: 999, height: 20))
        topOneLabel.width = topOneLabelSize.width
        
        var topTwoLabelSize = CGSize(width: 0, height: 0)
        topTwoLabelSize = topTwoLabel.sizeThatFits(CGSize(width: 999, height: 20))
        topTwoLabel.origin.x = topOneLabel.frame.maxX
        topTwoLabel.width = topTwoLabelSize.width
        
        var topThreeLabelSize = CGSize(width: 0, height: 0)
        topThreeLabelSize = topThreeLabel.sizeThatFits(CGSize(width: 999, height: 20))
        topThreeLabel.origin.x = topTwoLabel.frame.maxX
        topThreeLabel.width = topThreeLabelSize.width
        
        
        
        var userContentSize = CGSize(width: 0, height: 0)
        userContentSize = userContent.sizeThatFits(CGSize(width: userContentW, height: 999))
        userContent.origin.y = topOneLabel.bottomY + 5
        userContent.height = userContentSize.height
        userPingLunImg.origin.y = userContent.frame.maxY + 10
        timeLabel.origin.y = userContent.frame.maxY + 10
        return userContent.height + 100
    }
    
    func setupUI() {

        userImg.image = UIImage(named: "77")
        userImg.layer.cornerRadius = 4
        userImg.clipsToBounds = true
        self.contentView.addSubview(userImg)

        userName.text = "名字"
        userName.font = UIFont.boldSystemFont(ofSize: 17.0)
        userName.textColor = UIColor(red: 98/255.0, green: 115/255.0, blue: 140/255.0, alpha: 1)
        self.contentView.addSubview(userName)

        topOneLabel.text = "北京"
        topOneLabel.font = UIFont.systemFont(ofSize: 14.0)
        topOneLabel.textColor = kBlackAlphaColor
        self.contentView.addSubview(topOneLabel)

        topTwoLabel.text = "24岁"
        topTwoLabel.font = UIFont.systemFont(ofSize: 14.0)
        topTwoLabel.textColor = kBlackAlphaColor
        self.contentView.addSubview(topTwoLabel)

        topThreeLabel.text = "大学本科"
        topThreeLabel.font = UIFont.systemFont(ofSize: 14.0)
        topThreeLabel.textColor = kBlackAlphaColor
        self.contentView.addSubview(topThreeLabel)

        userContent = UILabel()
        userContent.numberOfLines = 0
        userContent.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight(rawValue: 0.14))
        self.contentView.addSubview(userContent)

        userPingLunImg.image = UIImage(named: "iconfontpinglun")
        self.contentView.addSubview(userPingLunImg)
        
        timeLabel = UILabel()
        timeLabel.textColor = kBlackAlphaColor
        timeLabel.font = UIFont.systemFont(ofSize: 14.0)
        timeLabel.text = "50分钟前"
        self.contentView.addSubview(timeLabel)
        
        let leftSpace:CGFloat = 16
        let imgLeftSpace:CGFloat = 15
        let topSpace:CGFloat = 15
        let userImgW:CGFloat = 45
        let userContentW:CGFloat = kScreenWidth - 2*leftSpace - userImgW - imgLeftSpace
        
        userImg.frame = CGRect(x: leftSpace, y: topSpace, width: userImgW, height: userImgW)
        userName.frame = CGRect(x: userImg.rightX + imgLeftSpace, y: topSpace, width: 100, height: 20)
 
        topOneLabel.frame = CGRect(x:userImg.rightX + imgLeftSpace , y: userName.bottomY, width: 0, height: 22)
        
        topTwoLabel.frame = CGRect(x:topOneLabel.rightX + 2, y: userName.bottomY, width: 0, height: 22)
        
        topThreeLabel.frame = CGRect(x:topTwoLabel.rightX + 2 , y: userName.bottomY, width: 0, height: 22)
        
        userContent.frame = CGRect(x: userImg.rightX + imgLeftSpace, y: topOneLabel.bottomY + 5, width: userContentW, height: 0)
        userPingLunImg.frame = CGRect(x: kScreenWidth - leftSpace - 15, y: userContent.bottomY + 10, width: 25, height: 20)
        timeLabel.frame = CGRect(x: userImg.rightX + imgLeftSpace, y: userContent.bottomY + 10, width: 100, height: 20)
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       

    }
}





















































































