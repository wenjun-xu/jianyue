//
//  LookMeCell.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/18.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class LookMeCell: UITableViewCell {
    var bgview = UIView()
    var dataModel:WJDynamicModel!
    var userImg = UIImageView()
    var userName = UILabel()

    var topOneLabel = UILabel()
    var topTwoLabel = UILabel()
    var topThreeLabel = UILabel()
    
    var bottomLabel = UILabel()

    var rightBtn = UIButton()
    var linView = UIView()
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
    
    func setupUI() {
        self.backgroundColor = kBgColor
        bgview.backgroundColor = UIColor.white
//        bgview.layer.cornerRadius = 5
//        bgview.clipsToBounds = true
  
        self.contentView.addSubview(bgview)
        userImg.image = UIImage(named: "77")
//        userImg.layer.cornerRadius = 5
//        userImg.clipsToBounds = true
        bgview.addSubview(userImg)
        
        userName.text = "名字"
        userName.font = UIFont.boldSystemFont(ofSize: 17.0)
        userName.textColor = UIColor(red: 98/255.0, green: 115/255.0, blue: 140/255.0, alpha: 1)
        bgview.addSubview(userName)
        
        topOneLabel.text = "北京"
        topOneLabel.font = UIFont.systemFont(ofSize: 12.0)
        topOneLabel.textColor = kBlackAlphaColor
        bgview.addSubview(topOneLabel)
        
        topTwoLabel.text = "24岁"
        topTwoLabel.font = UIFont.systemFont(ofSize: 12.0)
        topTwoLabel.textColor = kBlackAlphaColor
        bgview.addSubview(topTwoLabel)
        
        topThreeLabel.text = "大学本科"
        topThreeLabel.font = UIFont.systemFont(ofSize: 12.0)
        topThreeLabel.textColor = kBlackAlphaColor
        bgview.addSubview(topThreeLabel)
        
        bottomLabel.text = "第2次查看你的资料"
        bottomLabel.font = UIFont.systemFont(ofSize: 12.0)
        bottomLabel.textColor = kBlackAlphaColor
        bgview.addSubview(bottomLabel)
        
        rightBtn.setTitle("聊天", for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        rightBtn.layer.cornerRadius = 8
        rightBtn.setTitleColor(UIColor.gray, for: .normal)
        rightBtn.backgroundColor = UIColor.orange.alpha(0.3)
        rightBtn.setImage(UIImage(named: "guanzhu"), for: .normal)
//        rightBtn.addTarget(self, action: #selector(btnclick), for: .touchUpInside)
//        bgview.addSubview(rightBtn)
        
        linView.backgroundColor = UIColor.gray.alpha(0.3)
        bgview.addSubview(linView)

      
    }
    
    
    override func layoutSubviews() {
        let leftSpace:CGFloat = 15
        let imgLeftSpace:CGFloat = 15
        let _:CGFloat = 20
        let userImgW:CGFloat = 60
        bgview.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        userImg.frame = CGRect(x: leftSpace, y: leftSpace, width: userImgW, height: userImgW)
        userName.frame = CGRect(x: userImg.rightX + imgLeftSpace, y: leftSpace, width: 100, height: 20)
        var topOneLabelSize = CGSize(width: 0, height: 0)
        topOneLabelSize = topOneLabel.sizeThatFits(CGSize(width: 999, height: 22))
        
        var topTwoLabelSize = CGSize(width: 0, height: 0)
        topTwoLabelSize = topTwoLabel.sizeThatFits(CGSize(width: 999, height: 22))
        
        var topThreeLabelSize = CGSize(width: 0, height: 0)
        topThreeLabelSize = topThreeLabel.sizeThatFits(CGSize(width: 999, height: 22))
        
        topOneLabel.frame = CGRect(x:userName.x , y: userName.bottomY, width: topOneLabelSize.width, height: 22)
        
        topTwoLabel.frame = CGRect(x:topOneLabel.rightX + 2, y: userName.bottomY, width: topTwoLabelSize.width, height: 22)
        
        topThreeLabel.frame = CGRect(x:topTwoLabel.rightX + 2 , y: userName.bottomY, width: topThreeLabelSize.width, height: 22)
        
        bottomLabel.frame = CGRect(x:userName.x , y: topOneLabel.bottomY + 5, width: 150, height: 22)

        rightBtn.frame = CGRect(x: bgview.width - 80, y: (bgview.height - 30) / 2.0, width: 70, height: 30)
        rightBtn.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        rightBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -5, bottom: 0, right: 0)
        linView.frame = CGRect(x:leftSpace , y: bgview.height - 1, width: bgview.width - leftSpace, height: 0.35)

    }
}
