//
//  MLBastMatchJsonTool.swift
//  MoLiao
//
//  Created by study on 2019/4/28.
//  Copyright © 2019年 WY. All rights reserved.
//

import UIKit

class MLBastMatchJsonTool: NSObject {

    /// 最佳匹配 Json 数据
    class func  getBastMatchJsonData() -> MLBastMatchModel {
        let strDataPath = Bundle.main.path(forResource: "BastMatch", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        let json = DataJson().data2JSON(data: data! as Data)
        
        let aBastModel = MLBastMatchModel(json: json)
        return aBastModel!
    }
    
    /// 真心推荐 Json 数据
    class func getTrueHeartJsonData() -> HomeModel {
        let strDataPath = Bundle.main.path(forResource: "home", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        let json = DataJson().data2JSON(data: data! as Data)
        
        let aModel = HomeModel(json: json)
        return aModel!
    }

    /// 个人资料 Json 数据
    class func getPersonDataJsonData() -> MLPersonModel {
        let strDataPath = Bundle.main.path(forResource: "PersonData", ofType: "json")
        let data = NSData(contentsOfFile: strDataPath!)
        let json = DataJson().data2JSON(data: data! as Data)
        
        let aModel = MLPersonModel(json: json)
        return aModel!
    }
}
