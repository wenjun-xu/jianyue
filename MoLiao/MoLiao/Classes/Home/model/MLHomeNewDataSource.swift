//
//  MLHomeNewDataSource.swift
//  MoLiao
//
//  Created by study on 2019/4/29.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit


/// 这个类就是我们将UITableViewDataSource分离出来所封装的类
class MLHomeNewDataSource: NSObject  {

    var cellData: Array<AnyObject>?;
    var cellIdentifier: String?;
    var configureCell: ((AnyObject,AnyObject) -> ())?;
    
    init(cellData: Array<AnyObject>, cellIdentifier: String, configureCell: @escaping (AnyObject,AnyObject) -> ()) {
        
        super.init();
        self.cellData = cellData;
        self.cellIdentifier = cellIdentifier;
        self.configureCell = configureCell;
    }
}

extension MLHomeNewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellData!.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = cellIdentifier ?? "cellID"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        configureCell!(cell ,cellData![indexPath.row ]);
        
        return cell;
    }
    
}
