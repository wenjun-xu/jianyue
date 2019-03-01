//
//  DataJson.swift
//  MoLiao
//
//  Created by 徐庆标 on 2018/12/27.
//  Copyright © 2018 徐庆标. All rights reserved.
//

import UIKit
import SwiftyJSON
class DataJson: NSObject {
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










































