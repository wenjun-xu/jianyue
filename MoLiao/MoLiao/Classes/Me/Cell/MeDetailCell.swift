


//
//  MeDetailCell.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/10.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit
enum FoundStyle {
    case normal  // 默认
    case top     // 圆角在上面
    case bottom  // 圆角在下面
    case center  // 两个圆角
}
class MeDetailCell: UITableViewCell {
    var leftLabel:UILabel!
    var rightLabel:UILabel!
    var rightTextView:UITextView!
    var line:UIView!
    var cellStyle = FoundStyle.normal   // 圆角枚举
    var bgView:UIView!                  // 背景图片
    var rightImg:UIImageView!
    var iconImg:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI() {
        self.backgroundColor = kBgColor
        bgView = UIView()
        bgView.backgroundColor = .white
        self.contentView.addSubview(bgView)
        
        leftLabel = UILabel()
        leftLabel.text = "我的相册"
        leftLabel.font = UIFont.systemFont(ofSize: 14.0)
        bgView.addSubview(leftLabel)
        
        iconImg = UIImageView()
        iconImg.isHidden = true
        iconImg.layer.cornerRadius = 5
        iconImg.clipsToBounds = true
        iconImg.image = UIImage(named: "user_icon")
        bgView.addSubview(iconImg)
        
        rightLabel = UILabel()
        rightLabel.text = "男士"
        rightLabel.textAlignment = .right
        rightLabel.font = UIFont.systemFont(ofSize: 14.0)
        bgView.addSubview(rightLabel)
        
        rightTextView = UITextView()
        rightTextView.text = "楚秋燕"
        rightTextView.isScrollEnabled = false
        rightTextView.textContainerInset = UIEdgeInsets.init(top: 3, left: 0, bottom: 0, right: 0)
        rightTextView.isHidden = true
        rightTextView.textAlignment = .right
        rightTextView.font = UIFont.systemFont(ofSize: 14.0)
        bgView.addSubview(rightTextView)
        
        line = UIView()
        line.backgroundColor = UIColor.gray.alpha(0.3)
        bgView.addSubview(line)
        
        rightImg = UIImageView()
        rightImg.image = UIImage(named: "rightImg")
        bgView.addSubview(rightImg)
    }
    
    override func layoutSubviews() {
        let leftSpace:CGFloat = 12
        let labelH:CGFloat = 22
        let imgH:CGFloat = 15
        let iconImgSpace:CGFloat = 20
        bgView.frame = CGRect(x: 0, y:0, width: kScreenWidth, height: self.height)
        let iconImgH:CGFloat = (bgView.height - 2*iconImgSpace)
        leftLabel.frame = CGRect(x: leftSpace, y: (bgView.height - labelH) / 2.0, width: 100, height: labelH)
        iconImg.frame = CGRect(x: bgView.width - leftSpace - imgH - iconImgH - 5, y: iconImgSpace, width:iconImgH , height: iconImgH)
        rightLabel.frame = CGRect(x: (bgView.width - leftSpace - 200 - 15) , y: (bgView.height - labelH) / 2.0, width: 200, height: labelH)
        rightTextView.frame = CGRect(x: (bgView.width - leftSpace - 100 - 15) , y: (bgView.height - labelH) / 2.0, width: 100, height: labelH)
        rightImg.frame = CGRect(x: rightLabel.rightX, y: (bgView.height - imgH) / 2.0, width: imgH, height: imgH)
        line.frame = CGRect(x: leftSpace , y: bgView.height - 0.35, width: bgView.width - leftSpace, height: 0.35)
      
        let cornerRadius = 8
        let maskLayer = CAShapeLayer()
        switch cellStyle {
        case .normal:
            line.isHidden = false
        case .top:
            line.isHidden = false
            maskLayer.path = UIBezierPath.init(roundedRect: bgView.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width:cornerRadius,height:cornerRadius)).cgPath
//            bgView.layer.mask = maskLayer
            
        case .bottom:
            line.isHidden = true
            maskLayer.path = UIBezierPath.init(roundedRect: bgView.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width:cornerRadius,height:cornerRadius)).cgPath
//            bgView.layer.mask = maskLayer
        case .center:
            line.isHidden = true
//            bgView.layer.cornerRadius = 5
        }
        
    }

}
