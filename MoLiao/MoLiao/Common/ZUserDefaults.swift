//
//  ZUserDefaults.swift
//  CAPP
//
//  Created by Zee on 2018/1/12.
//  Copyright © 2018年 centaline. All rights reserved.
//

import UIKit

//class ZUserDefaults: NSObject {
//
//}


protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue==String {
    static func set(value: String?, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
        UserDefaults.standard.synchronize()
    }
    static func loginsynchronize() {
        UserDefaults.standard.synchronize()
    }

    static func string(forKey key: defaultKeys) -> String? {
        let aKey = key.rawValue
        if UserDefaults.standard.string(forKey: aKey) == nil {
            return ""
        }
        return UserDefaults.standard.string(forKey: aKey)
    }
}


extension UserDefaults {
    //城市选择
    struct ApiUrl: UserDefaultsSettable {
        enum defaultKeys: String {
            case urlChrisBase
            case urlChrisBasePre
            case city
            case cityVer2
            case rowId
        }
    }
  
    // 登录信息
    struct LoginInfo: UserDefaultsSettable {
        enum defaultKeys: String {
            case emptname
            case loginPwd
            case empPhone
            case sessionid
            case usertype
            case rolecity
            case Token
            case emptcode
            case empno
            case mobile
            case emptcity
        }
    }
    
    struct UserInfo:UserDefaultsSettable {
        enum defaultKeys:String {
            case empno
            case emptname
            case deptname
            case deptfullname
            case email
            case mobile
            case positionname
            case postalcode
            case sex
            case deptcode
            case isfavorite
            case headImage
        }
    }
    
    //浮框
    struct FeedbackSuspension:UserDefaultsSettable {
        enum defaultKeys: String {
            case keyFeedbackSuspension
        }
    }
    
    //手势解锁
    struct Gestures:UserDefaultsSettable {
        enum defaultKeys: String {
            case keyGesturesPwd
            case keyGestureUnlock
        }
    }
    struct Advertisements:UserDefaultsSettable {
        enum defaultKeys: String {
            case advertisements
            case appVersionNumber
            case firstInstall
        }
    }
}















































