//
//  MLDynamicCell.swift
//  MoLiao
//
//  Created by study on 2019/4/28.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

/// 推荐详情页 - 动态Section 的View， 只有3张图片
class MLDynamicCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cell(tableView: UITableView) -> MLDynamicCell{
        let indentifier:String = "MLDynamicCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        
        if cell == nil {
            cell = MLDynamicCell(style: .default, reuseIdentifier: indentifier)
            cell?.separatorInset = UIEdgeInsets(top: 0,left: kScreenWidth, bottom: 0, right: 0)
            cell?.backgroundColor = UIColor.white
            cell?.selectionStyle = .none;
        }
        
        return cell  as! MLDynamicCell
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

// MARK:- UI创建
extension MLDynamicCell {
    private func setupCellUI() {
        for i in 0...2 {
            let img = UIImageView.init(frame: CGRect(x: leftSpace_20 + CGFloat(i)*(150 + 10), y: 20, width: 150, height: 150))
            img.image = UIImage(named: "0000")
            contentView.addSubview(img)
        }
    }
}
