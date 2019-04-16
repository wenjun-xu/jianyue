
//
//  MessageCell.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/5.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    var userImg = UIImageView()
    var userNameLabel = UILabel()
    var contentLabel = UILabel()
    var timeLabel = UILabel()
    var xiaoxiLabel = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUI() {
        userImg.image = UIImage(named: "img_six")
        userImg.layer.cornerRadius = 30
        userImg.clipsToBounds = true
        self.contentView.addSubview(userImg)
        
        xiaoxiLabel.text = "1"
        xiaoxiLabel.font = UIFont.systemFont(ofSize: 12.0)
        xiaoxiLabel.textAlignment = .center
        xiaoxiLabel.backgroundColor = UIColor.red
        xiaoxiLabel.textColor = UIColor.white
        xiaoxiLabel.layer.cornerRadius = 7.5
        xiaoxiLabel.clipsToBounds = true
        self.contentView.addSubview(xiaoxiLabel)
        
        userNameLabel.text = "张涵画君"
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        self.contentView.addSubview(userNameLabel)
        
        contentLabel.text = "合适的话，可以见面了解"
        contentLabel.font = UIFont.systemFont(ofSize: 13.0)
        contentLabel.textColor = kBlackAlphaColor
        self.contentView.addSubview(contentLabel)
        
        timeLabel.text = "2019-01-06"
        timeLabel.font = UIFont.systemFont(ofSize: 13.0)
        timeLabel.textAlignment = .right
        timeLabel.textColor = kBlackAlphaColor
        self.contentView.addSubview(timeLabel)
    }

    override func layoutSubviews() {
        let leftSpace:CGFloat = 20
        let imgW:CGFloat = 60
        let imgLeftSpace:CGFloat = 15
        userImg.frame = CGRect(x: leftSpace, y: (self.height - imgW) / 2.0, width: imgW, height: imgW)
        xiaoxiLabel.frame = CGRect(x: leftSpace + imgW - 15, y: (self.height - imgW) / 2.0, width: 15, height: 15)
        userNameLabel.frame = CGRect(x: userImg.rightX + imgLeftSpace , y: (self.height - 40) / 2.0 , width: 100, height: 20)
        contentLabel.frame = CGRect(x: userImg.rightX + imgLeftSpace , y: userNameLabel.bottomY + 4 , width: kScreenWidth - imgW - 2*leftSpace - imgLeftSpace, height: 20)
        timeLabel.frame = CGRect(x: kScreenWidth - 150, y: userNameLabel.y, width: 130, height: 20)
    }
}
