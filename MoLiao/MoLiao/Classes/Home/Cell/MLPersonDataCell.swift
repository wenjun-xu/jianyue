//
//  MLPersonDataCell.swift
//  MoLiao
//
//  Created by study on 2019/4/28.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

typealias LabelProtocol = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

/// 推荐详情 - 个人资料
class MLPersonDataCell: UITableViewCell {
    
    private var aString: [MLPersonDataModel] = []
    
    private var colltionView : UICollectionView!
    //collectionView的高度约束
//    private var collectionViewHeight: NSLayoutConstraint!
    
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
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(#function)
    }
}

// MARK:- UI创建
extension MLPersonDataCell {
    public func setupData(model: [MLPersonDataModel]) {
    
        aString = model
        
        print("aString = \(aString)")
        //collectionView重新加载数据
        self.colltionView!.reloadData()
        
        //更新collectionView的高度约束
        let contentSize = self.colltionView.collectionViewLayout.collectionViewContentSize
        self.colltionView.frame.size = contentSize
        self.colltionView.collectionViewLayout.invalidateLayout()
        
    }
}

// MARK:- UI创建
extension MLPersonDataCell {
    /// 初始化 UICollectionView 并注册 UICollectionViewCell
    private func setupView() {
        let layout = UICollectionViewFlowLayout()
        // 必须写，用来自动计算行高
        layout.estimatedItemSize = CGSize(width: 100, height: self.frame.size.height)
        
        colltionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), collectionViewLayout: layout)
        
        print("colltionView.frame = \(colltionView!.frame)")
        
        //注册一个cell
        colltionView! .register(WYLabelCell.self, forCellWithReuseIdentifier:"cell")
        colltionView?.delegate = self;
        colltionView?.dataSource = self;
        colltionView?.backgroundColor = UIColor.purple
        
        contentView.addSubview(colltionView!)
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

extension MLPersonDataCell: LabelProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WYLabelCell
        
        let aModel = aString[indexPath.row]
        cell.label.text = aModel.title
        
        return cell
    }
}
