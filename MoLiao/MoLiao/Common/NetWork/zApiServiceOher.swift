//
//  zApiServiceOher.swift
//  CAPP
//
//  Created by 哲 on 2016/11/10.
//  Copyright © 2016年 centaline. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


typealias JSON = SwiftyJSON.JSON
protocol JSONCoverible {
    static func fromJSON(json: JSON?) -> Self?
}

class zApiServiceOher: NSObject {

    /*
     * 服务器地址
     */
//    public let base_Url = "https://tjcentame.centaline.com.cn"                 // 生产服务器地址
//    public let base_PicUrl = "https://tjcentamepic.centaline.com.cn"           // 生产服务器图片地址
    
    public let base_Url = "https://tjcentametest.centaline.com.cn"              // 测试服务器地址
    public let base_PicUrl = "https://tjcentamepictest.centaline.com.cn"        // 测试服务器图片地址
    
    
    //base地址
    func getBaseUrl() -> String{
        let strUrl = "\(base_Url)/api/CentaMe"
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return strUrl.trimmingCharacters(in: whitespace)
    }
    //base地址
    func getBaseUrlNew() -> String{
        let strUrl = "\(base_Url)/api/CentaMeV2"
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return strUrl.trimmingCharacters(in: whitespace)
    }
    
    // 注册单个用户推送网络请求
    func getJpush() -> String{
        let strUrl = "\(base_Url)/api/ShortMessage"
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return strUrl.trimmingCharacters(in: whitespace)
    }
    
    //CCAI
    func getCCAIURL() -> String{
        let strUrl = "\(base_Url)/api/CCAIWorkflow"
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return strUrl.trimmingCharacters(in: whitespace)
    }
    //考勤审批
    func getKQURL() -> String{
        let strUrl = "\(base_Url)/api/Workflow"
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return strUrl.trimmingCharacters(in: whitespace)
    }
    
    //短信验证码和二维码
    func getRcode() -> String{
        let strUrl = "\(base_Url)/api"
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return strUrl.trimmingCharacters(in: whitespace)
    }
    
    private static let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30
        return SessionManager(configuration: configuration)
    }()
    
    
    func queryUrlJson(_ url: String,method: String, parameters: Parameters, zRreturn: @escaping (_ result: JSON) -> Void)  {
        var strUrl = ""
        var httpMethod = HTTPMethod.post
        
        if method == "UserLogin" || method == "SaveCAPPIndexMenuAssist" || method == "SendUserFeedBack" || method == "CentaServiceInfo" || method == "KQCentaService" || method == "UserLogin" || method == "JPushManager" || method == "DeleteSystemMessage" || method == "SetMessageRead" || method == "VerificationMobile" || method == "ChangeMoble" || method == "PersonalCenter" || method == "exception-Log" || method == "latitude-longitudes" || method == "send-message" || method == "UploadFile" || method == "give-the-thumbs-up" || method == "add-comments" || method == "delete-comments" || method == "eliminate-dynamic" || method == "delete-dynamic" {

        }else {
            httpMethod = HTTPMethod.get
        }
        strUrl = url + "/" + method
        
        print("\(method):接口========",strUrl)
        print("          参数===============",parameters)
        print("          请求方式==========",httpMethod)
        
        zApiServiceOher.sessionManager.request(strUrl, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseData() { response in
                switch (response.result) {
                case .success:
                    let json = ZUtilsDetail().data2JSON(data: response.data!)
                    print("\(method):接口json========",json)
                    if let status = json[RESULT_CODE].bool {
                        if status  { }else{
//                            let msg = json[RESULT_MSG].stringValue
//                            if msg.contains("重新登录") {
//                                dataExit()
//                            }
                        }
                    }
                    zRreturn(json)
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        zRreturn("网络请求超时")
                    }else if error._code == NSURLErrorNotConnectedToInternet {
                        zRreturn("网络不给力")
                    }else {
                        zRreturn("服务器连接失败")
                    }
                    break
                }
        }
    }
    
    
}



