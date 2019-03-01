//
//  WJConfigure.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/26.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit
import Hue


let RESULT_CODE = "status"
let RESULT_MSG = "message"
let RESULT_DATA = "data"
let EMPT_DETAILS = "empt_details"
let CCAI_STATE = "Status"
let CCAI_MSG = "Message"
let WJStatus = "Status"
let WJ_StrMessage = "StrMessage"

public let kNavColor:UIColor = UIColor.white.alpha(0.3)
public let kZhifuTitleColor:UIColor = UIColor(red: 131/255.0, green: 121/255.0, blue: 82/255.0, alpha: 1)
public let kZhifuBgColor:UIColor =  UIColor(red: 228/255.0, green: 206/255.0, blue: 153/255.0, alpha: 1)
//public let kNavColor:UIColor = UIColor(red: 255/255.0, green: 126/255.0, blue: 15/255.0, alpha: 1)
public let kWangjiColor:UIColor = UIColor(red: 197/255.0, green: 197/255.0, blue: 197/255.0, alpha: 1)

public let kTabBarColor:UIColor = UIColor(hex: "#EBEDF8")

public let kBgColor:UIColor = UIColor(hex: "#F0EFF4")
public let kCellColor:UIColor = UIColor(hex: "#FCFCFC")
public let kLabelBlackColor:UIColor = UIColor(hex: "#333333")
public let kLabelGrayColor:UIColor = UIColor(hex: "#666666")
public let kWhiteColor:UIColor = UIColor(hex: "#FFFFFF")
public let kLightGrayColor:UIColor = UIColor(hex: "#DFDFEA")

public let kBlackAlphaColor:UIColor = UIColor(red: 135/255.0, green: 135/255.0, blue: 135/255.0, alpha: 1)


public let kLabelColor:UIColor = UIColor(red: 93/255.0, green: 97/255.0, blue: 101/255.0, alpha: 1)

public let kScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let kScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let isThaniphoneX = UIApplication.shared.statusBarFrame.height >= 44

public let kPlaceHolderH: CGFloat = 16
public let kBgViewSpace: CGFloat = 15


public let kStatusBarH: CGFloat = UIApplication.shared.statusBarFrame.size.height
public let kNavH: CGFloat = 44
public let kTabbarHeight:CGFloat = (isThaniphoneX ? 83 : 49)

public let widthRatio = kScreenWidth / 375          //设备宽度比例（以 6的尺寸为准）
public let heightRatio = kScreenHeight / 667        //设备高度比例（以 6的尺寸为准）
public let kMeTabHeadImgH:CGFloat = 300
public let kMeTabHeadViewH:CGFloat = 135
public let kHomeSDrecycleViewH:CGFloat = 200
public let kInfoSDrecycleViewH:CGFloat = kScreenWidth

public let picViewColor:UIColor = UIColor(red: 216/255.0, green: 170/255.0, blue: 100/255.0, alpha: 1)
public let heightNavigation = CGFloat(64)


//MARK:获取字符串的宽度的封装
func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
    
    let statusLabelText: NSString = labelStr as NSString
    
    let size = CGSize(width: 900, height: height)
    
    let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
    
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
    
    return strSize.width
}

func getLabHeight(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat {
    
    let statusLabelText: NSString = labelStr as NSString
    
    let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
    
    let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
    
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context:nil).size
    
    return strSize.height
    
}


func arrWithPlist(string:String) ->Array<String>{
    let diaryList:String = Bundle.main.path(forResource: "MyPlist", ofType:"plist")!
    let aaa = NSDictionary(contentsOfFile: diaryList)
    let arr = aaa?[string]
    return arr as! Array<String>
}

// MARK:- 颜色转图片
func getImageWithColor(color:UIColor)->UIImage{
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(color.cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}
