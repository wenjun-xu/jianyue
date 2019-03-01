//
//  ZUtilsDetail.swift
//  CAPP
//
//  Created by 哲 on 2017/1/3.
//  Copyright © 2017年 centaline. All rights reserved.
//

import UIKit
import SwiftyJSON


class ZUtilsDetail: NSObject {
    
    
    /**
     生成随机字符串,
     
     - parameter length: 生成的字符串的长度
     
     - returns: 随机生成的字符串
     */
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func getJsonByArray(arr: [Any]) ->String{
        let strJson: String!
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: arr, options: .init(rawValue: 0))
            strJson = String.init(data: jsonData, encoding: .utf8)
        }catch{
            strJson = ""
        }
        return strJson
    }
    
    
 
    
    //数组转Json
    func arr2Json(arr: NSMutableArray) -> String{
        let strJson: String!
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: arr, options: .init(rawValue: 0))
            strJson = String.init(data: jsonData, encoding: .utf8)
        }catch{
            strJson = ""
        }
        return strJson
    }
    
    //数组转Json
    func arr2JjsonArr(arr: NSMutableArray) -> [Any]{
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: arr, options: .init(rawValue: 0))
            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [Any]
            return json
            //strJson = String.init(data: jsonData, encoding: .utf8)
        }catch{
            
        }
        return [Any]()
    }
    
    
    //数组转Json
    func data2JSON(data: Data) -> JSON{
        var json = JSON.null
        do {
            json = try JSON(data: data)
        } catch {
            
        }
        return json
    }
    

    
}
