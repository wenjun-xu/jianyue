//
//  MLBastMatchModel.swift
//  MoLiao
//
//  Created by study on 2019/4/26.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class MLBastMatchModel: NSObject {
    var code: Int?
    var errorMsg: String?
    var status: Bool?
    var aModel:  [usersBastMatchModel] = []
    
    /// 数据总数
    var total_number: Int = 0
    
    init?(json: JSON?) {
        guard let json = json  else { return nil}
        self.code = json["code"].int ?? 0
        self.errorMsg = json["errorMsg"].string ?? ""
        self.total_number = json["total_number"].int ?? 0
        
        self.status = json["status"].bool ?? true
        
        if json["users"].array != nil {
            self.aModel = (json["users"].array?.compactMap({usersBastMatchModel.fromJSON(json: $0)}))!
        }
    }
}

struct usersBastMatchModel: JSONCoverible {
    var id: String!
    /// 用户名
    var username: String!
    /// 详情
    var detail: String!
    /// 头像
    var icon: String!
    
    static func fromJSON(json: JSON?) -> usersBastMatchModel?{
        guard let json = json  else { return nil}
        
        let id = json["id"].string ?? ""
        let username = json["username"].string ?? ""
        let detail = json["detail"].string ?? ""
        let icon = json["icon"].string ?? ""
        
        return self.init(id: id,
                         username: username,
                         detail: detail,
                         icon: icon)
    }
}
