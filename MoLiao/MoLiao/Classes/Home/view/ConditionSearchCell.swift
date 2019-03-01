//
//  ConditionSearchCell.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/31.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

class ConditionSearchCell: UITableViewCell {
    var leftLabel:UILabel!
    var rightLabel:UILabel!
    var line:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    func setUpUI() {
        leftLabel = UILabel()
        rightLabel = UILabel()
        line = UIView()
        line.backgroundColor = kBgColor
        leftLabel.font = UIFont.systemFont(ofSize: 14.0)
        rightLabel.font = UIFont.systemFont(ofSize: 14.0)
        leftLabel.textAlignment = .left
        rightLabel.textAlignment = .right
        self.contentView.addSubview(leftLabel)
        self.contentView.addSubview(rightLabel)
        self.contentView.addSubview(line)
    }
    override func layoutSubviews() {
        let leftSpace:CGFloat = 20
        leftLabel.frame = CGRect(x: leftSpace, y: 0, width: 100, height:self.height - 2)
        rightLabel.frame = CGRect(x: self.width - 150, y: 0, width: 150 - leftSpace, height: self.height - 2)
        line.frame = CGRect(x: 10, y: self.height - 1, width: kScreenWidth - 10, height: 0.4)
    }
}
