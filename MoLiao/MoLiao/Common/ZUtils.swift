//
//  ZUtils.swift
//  CAPP
//
//  Created by 哲 on 2016/11/14.
//  Copyright © 2016年 centaline. All rights reserved.
//

import UIKit
import AwesomeCache
import SwiftyJSON
import Alamofire

public let CheckTime = "checktime"
public let CacheCheckTime = "CacheCheckTime"

let userdefault = UserDefaults.standard


class ZUtils: NSObject {
    
    
    // 保存角标
    static func saveString(_ value:NSString ,key: String) {
        do {
            let cache = try Cache<NSString>(name: "zAwesomeCacheString_" + getEmptCode())
            cache[key] = value
        } catch _ {
            print("Something went wrong :\(self)")
        }
        
    }
    
    // 获取角标
    static func getString(_ key: String) -> String{
        var str = ""
        do {
            let cache = try Cache<NSString>(name: "zAwesomeCacheString_" + getEmptCode())
            if cache[key] != nil  {
                str = cache[key]! as String
            }
            
        } catch _ {
            print("Something went wrong :\(self)")
        }
        return str
        
    }
    
    static func saveData(_ value:NSData ,key: String) {
        do {
            let cache = try Cache<NSData>(name: "zAwesomeCacheData_"+getEmptCode())
            cache[key] = value
        } catch _ {
            print("Something went wrong :\(self)")
        }
        
    }
    
    static func getData(_ key: String) -> NSData{
        var re = NSData()
        do {
            let cache = try Cache<NSData>(name: "zAwesomeCacheData_"+getEmptCode())
            if cache[key] != nil  {
                re = cache[key]!
            }
            
        } catch _ {
            print("Something went wrong :\(self)")
        }
        return re
        
    }
    
    static func deleteData(_ key:String) {
        do {
            let cache = try Cache<NSData>(name: "zAwesomeCacheData_"+getEmptCode())
            cache[key] = nil
        } catch _ {
            print("Something went wrong :\(self)")
        }
    }
    
    static func getEmptCode() -> String{
//        let loginInfo = self.getCacheLoginInfo()
//        let str = loginInfo.emptcode
        let str = "emptcode"
        return str
    }
    
    
    
    static func saveCityData(_ value:NSData ,key: String) {
        do {
            let cache = try Cache<NSData>(name: "zAwesomeCacheData_" + "city")
            cache[key] = value
        } catch _ {
            print("Something went wrong :\(self)")
        }
        
    }
    
    static func getCityData(_ key: String) -> NSData{
        var re = NSData()
        do {
            let cache = try Cache<NSData>(name: "zAwesomeCacheData_" + "city")
            if cache[key] != nil  {
                re = cache[key]!
            }
            
        } catch _ {
            print("Something went wrong :\(self)")
        }
        return re
        
    }
    
    

    
    
 
}
































