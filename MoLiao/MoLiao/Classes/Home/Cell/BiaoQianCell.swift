//
//  BiaoQianCell.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/28.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

class BiaoQianCell: UITableViewCell {
    var bgView:UIView!
    var img:UIImageView!
    var centerLabel:UILabel!
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
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    func setUpUI() {
        bgView = UIView()
        bgView.backgroundColor = kBgColor
        self.addSubview(bgView)
        img = UIImageView()
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        bgView.addSubview(img)
        
        centerLabel = UILabel()
        centerLabel.textAlignment = .center
        centerLabel.textColor = UIColor.white
        centerLabel.font = UIFont.boldSystemFont(ofSize: 23.0)
        bgView.addSubview(centerLabel)
    }
    override func layoutSubviews() {
        let leftSpace:CGFloat = 20
        let topSpace:CGFloat = 10
        bgView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        img.frame = CGRect(x: leftSpace, y: topSpace, width: kScreenWidth - 2*leftSpace, height: self.height - 2*topSpace)
        centerLabel.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
    }
    
}
