
//
//  BottomSelectCell.swift
//  MoLiao
//
//  Created by 徐庆标 on 2019/1/15.
//  Copyright © 2019 徐庆标. All rights reserved.
//

import UIKit

class BottomSelectCell: UITableViewCell {
    var titleLabel:UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupSubViews()
//
//    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        titleLabel = UILabel.init()
        titleLabel.textAlignment = .center
        self.contentView.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
    }
    
    
}
