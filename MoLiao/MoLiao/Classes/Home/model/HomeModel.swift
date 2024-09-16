//
//  HomeModel.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/27.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

class HomeModel: NSObject {
    var message: String?
    var status: Bool?
    var aModel:  [HomeCellModel] = []
    
    init?(json: JSON?) {
        guard let json = json  else { return nil}
        self.message = json["message"].string ?? ""
        self.status = json["status"].bool ?? true
        
        if json["data"].array != nil {
            self.aModel = (json["data"].array?.compactMap({HomeCellModel.fromJSON(json: $0)}))!
        }
    }
}

struct HomeCellModel: JSONCoverible {
    var Title: String!
    var Content: String!
    
    var topOneTitle: String!
    var topTwoTitle: String!
    var topThreeTitle: String!
    
    var centerOneTitle: String!
    var centerTwoTitle: String!
    var centerThreeTitle: String!
    
    var isHuiYuan:Bool!
    var isDuBai:Bool!
    var Picture: String!
    
    static func fromJSON(json: JSON?) -> HomeCellModel?{
        guard let json = json  else { return nil}
        
        let Title = json["Title"].string ?? ""
        let Content = json["Content"].string ?? ""
        let topOneTitle = json["topOneTitle"].string ?? ""
        let topTwoTitle = json["topTwoTitle"].string ?? ""
        let topThreeTitle = json["topThreeTitle"].string ?? ""
        let centerOneTitle = json["centerOneTitle"].string ?? ""
        let centerTwoTitle = json["centerTwoTitle"].string ?? ""
        let centerThreeTitle = json["centerThreeTitle"].string ?? ""
        let isHuiYuan = json["isHuiYuan"].bool ?? false
        let isDuBai = json["isDuBai"].bool ?? false
        let Picture = json["Picture"].string ?? ""
        
        return self.init(Title: Title,
                         Content: Content,
                         topOneTitle: topOneTitle,
                         topTwoTitle: topTwoTitle,
                         topThreeTitle: topThreeTitle,
                         centerOneTitle: centerOneTitle,
                         centerTwoTitle: centerTwoTitle,
                         centerThreeTitle: centerThreeTitle,
                         isHuiYuan: isHuiYuan,
                         isDuBai: isDuBai,
                         Picture: Picture)
    }
}
