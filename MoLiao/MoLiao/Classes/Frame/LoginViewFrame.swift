//
//  LoginViewFrame.swift
//  MoLiao
//
//  Created by 华通众和 on 2019/2/28.
//  Copyright © 2019年 徐庆标. All rights reserved.
//

import Foundation

///
public let FRegist_imageWidth: CGFloat = 100
///
public let FRegist_leftSpace: CGFloat = (kScreenWidth - 2 * FRegist_imageWidth) / 3.0
/// 子类中z第一个View 的 y值
public let FRegist_titleY: CGFloat = 150

/// 20的距离
public let leftSpace_20: CGFloat = 20

/*------------------------------- 导航栏的数据 -------------------------------------*/

let navTitleFont: UIFont = UIFont.systemFont(ofSize: 15)
let navTitleColor: UIColor = UIColor.black

// MARK:- 界面用到的Frame值
enum frameLoginView {
    /// 头像
    case FPhoto
    /// 账号登录高度
    case FNameTitleView
    /// 用户号和密码的高度
    case FNameAndPwd
    /// 用户号和密码下方线的高度
    case Fline
    /// 登录按钮高度
    case FLoginBtn
    ///  靠近边界的x值
    case Fx
    /// 手机号验证码登录高度
    case FPhoneL
    /// 快速登录高度
    case FFastLoginView
    
    
    var frame: CGFloat {
        switch self {
        case .FPhoto:
            return 80
        case .FNameTitleView:
            return 26
        case .FNameAndPwd:
            return 38
        case .Fline:
            return 0.5
        case .FLoginBtn:
            return 60
        case .Fx:
            return 30
        case .FPhoneL:
            return 14
        case .FFastLoginView:
            return 126
        }
    }
}
