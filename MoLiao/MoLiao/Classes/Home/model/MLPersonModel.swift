//
//  MLPersonModel.swift
//  MoLiao
//
//  Created by study on 2019/4/28.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit


class MLPersonModel: NSObject {
    var code: Int?
    var errorMsg: String?
    var status: Bool?
    var aModel:  [MLPersonDataModel] = []
    
    /// 数据总数
    var total_number: Int = 0
    
    init?(json: JSON?) {
        guard let json = json  else { return nil}
        self.code = json["code"].int ?? 0
        self.errorMsg = json["errorMsg"].string ?? ""
        self.total_number = json["total_number"].int ?? 0
        
        self.status = json["status"].bool ?? true
        
        if json["data"].array != nil {
            self.aModel = (json["data"].array?.compactMap({MLPersonDataModel.fromJSON(json: $0)}))!
        }
    }
}

struct MLPersonDataModel: JSONCoverible {
    var title: String!
    
    static func fromJSON(json: JSON?) -> MLPersonDataModel?{
        guard let json = json  else { return nil}
        
        let title = json["title"].string ?? ""
        
        return self.init(title: title)
    }
}
