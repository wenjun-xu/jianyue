//
//  StringExtension.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/26.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit

extension String {
    
    /**
     去除左右的空格和换行符
     */
    public func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    
    
    /**
     将字符串通过特定的字符串拆分为字符串数组
     - parameter str   : 拆分数组使用的字符串
     - returns : 字符串数组
     */
    func split(string:String) -> [String] {
        return NSString(string: self).components(separatedBy: string)
    }
    
    
    
    /**
     字符串替换
     - parameter of     : 被替换的字符串
     - parameter with   : 替换使用的字符串
     - returns : 替换后的字符串
     */
    func replace(of: String, with: String) -> String {
        return self.replacingOccurrences(of: of, with: with)
    }
    
    
    
    
    /// 字符串的长度
    var length:Int {
        get {
            return self.characters.count
        }
    }
    
    public var urlEncoded: String {
        
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)//urlQueryAllowed
        return encodeUrlString ?? ""
    }
    
    func hasEmoji()->Bool {
        
        let pattern = "[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"
        let pred = NSPredicate(format: "SELF MATCHES %@",pattern)
        return pred.evaluate(with: self)
    }
    
    
}

// MARK:-  label宽度自适应
extension String {
    /// label宽度自适应
    ///
    /// - Parameters:
    ///   - labelHeight: 最大高度
    ///   - font: 字体，行距等
    /// - Returns: 宽度
    func autoLabelHeight(with labelHeight: CGFloat ,font: UIFont) -> CGFloat {
        var size = CGRect()
        let size2 = CGSize(width: 0, height: labelHeight)//设置label的最大宽度
        size = self.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font] , context: nil);
        return size.size.width
    }
}
