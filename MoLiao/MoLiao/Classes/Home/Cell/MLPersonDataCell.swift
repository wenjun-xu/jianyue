//
//  MLPersonDataCell.swift
//  MoLiao
//
//  Created by study on 2019/4/28.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

/// 推荐详情 - 个人资料
class MLPersonDataCell: UITableViewCell {
    
    private var aLabel: [UILabel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    class func cell(tableView: UITableView) -> MLPersonDataCell{
        let indentifier:String = "MLPersonDataCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)
        
        if cell == nil {
            cell = MLPersonDataCell(style: .default, reuseIdentifier: indentifier)
            cell?.backgroundColor = UIColor.white
            cell?.selectionStyle = .none;
        }
        
        return cell  as! MLPersonDataCell
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
extension MLPersonDataCell {
    public func setupData(model: MLPersonDataModel) {
    
        aLabel?[0].text = model.title
    }
}

// MARK:- UI创建
extension MLPersonDataCell {
    private func setupCellUI() {
        //每个Item宽高
        let H: CGFloat = 24
        //每行列数
        let rank: Int = 3
        //每行间距
        let rowMargin: CGFloat = 20
        //每列间距
        let rankMargin: CGFloat = 20
        //Item索引 ->根据需求改变索引
        let index: Int = 9;
        
        /// 宽度 - 不固定
        var W: CGFloat = 60
        //Item top
        let top: CGFloat = 50;
        
        for i in 0..<index {
            //Item X轴
            let X = CGFloat(i % rank) * (W + rankMargin);
            //Item Y轴
            let Y = CGFloat(i / rank) * (H + rowMargin);

            print("X = \(X)")
            print("Y =\(Y)")
            
            let label = UILabel()
            customLabelLayer(label: label)
            contentView.addSubview(label)
            
            let labelW: CGFloat = label.text?.autoLabelHeight(with: H, font: UIFont.systemFont(ofSize: 12.0)) ?? 0
            label.frame = CGRect(x: X, y: Y + top, width: W, height: H)

            W = labelW + rankMargin
            
            aLabel?.append(label)
        }
    }
    
    
    private func customLabelLayer(label:UILabel) {
        label.layer.cornerRadius = 12
        label.textColor = kLabelGrayColor
        label.layer.borderColor = UIColor.gray.alpha(0.3).cgColor
        label.layer.borderWidth = 0.35
        //        label.layer.shadowColor = UIColor.gray.alpha(0.5).cgColor
        //        label.layer.shadowRadius = 5
        //        label.layer.shadowOpacity = 0.6
        //        label.layer.shadowOffset = CGSize(width: 1, height: 2)
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0)
    }
}

extension String {
    /// label宽度自适应
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - labelWidth: 最大宽度
    ///   - attributes: 字体，行距等
    /// - Returns: 高度
    func autoLabelHeight(with labelHeight: CGFloat ,font: UIFont) -> CGFloat {
        var size = CGRect()
        let size2 = CGSize(width: 0, height: labelHeight)//设置label的最大宽度
        size = self.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font] , context: nil);
        return size.size.width
    }
}
