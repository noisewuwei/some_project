//
//  NetManager.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/17.
//

import Alamofire
import SwiftyJSON
import UIKit
import AdSupport

class NetManager {
    static let manager = NetManager()
    
    var session: Session!
    init() {
//        if Defaults[.validateSSL]! {
//            let manager = WildcardServerTrustPolicyManager(evaluators: [BaseUrlManager().wildcardHost: PinnedCertificatesTrustEvaluator()])
//            session = Session(serverTrustManager: manager)
//        }else {
//            session = Session()
//        }
        
        let manager = WildcardServerTrustPolicyManager(evaluators: [BaseUrlManager().wildcardHost: DisabledTrustEvaluator()])
        session = Session(serverTrustManager: manager)
        
    }
    
    
    func getRequest(at url: String, isFullUrl: Bool = false, params: [String: Any] = [:], success: @escaping (Any?) -> Void, failure: @escaping ((Any?) -> Void))
    {
        return request(method: .get, url: url, isFullUrl: isFullUrl, params: params, success: success, failure: failure)
    }
    
    func getRequestList(at url: String, params: [String: Any] = [:], success: @escaping (Any?) -> Void, failure: @escaping ((Any?) -> Void))
    {
        return request(method: .get, url: url, params: params, successListCallback: success, failure: failure)
    }
    
    func postRequest(at url: String, isFullUrl: Bool = false ,params: [String: Any] = [:], success: @escaping (Any?) -> Void, failure: @escaping ((Any) -> Void))
    {
        return request(method: .post, url: url, isFullUrl: isFullUrl ,params: params, success: success, failure: failure)
    }
    
    func patchRequest(at url: String, params: [String: Any] = [:], success: @escaping (Any?) -> Void, failure: @escaping ((Any) -> Void))
    {
        return request(method: .patch, url: url, params: params, success: success, failure: failure)
    }
    
    func postRequestList(at url: String, params: [String: Any] = [:], success: @escaping (Any?) -> Void, failure: @escaping ((Any) -> Void))
    {
        return request(method: .post, url: url, params: params, successListCallback: success, failure: failure)
    }
    
    func uploadRequest(at url: String, params: [String: String]?, images: [UIImage], success: @escaping (Any?) -> Void, failure: @escaping ((Any) -> Void))
    {
        return upload(url: url, params: params, images: images, success: success, failure: failure)
    }
}

extension NetManager {
    func request(method: HTTPMethod, url: String, isFullUrl: Bool = false ,params: [String: Any], success: ((Any?) -> Void)? = nil, successListCallback: ((Any?) -> Void)? = nil, failure: @escaping ((Any?) -> Void))
    {
        
        
        let parameters = params
        
        var full_url = ""
        
        if isFullUrl {
            full_url = url
        }else{
            full_url = BaseUrlManager.manager.baseUrl+url
        }
    
        let timeStamp = Date().currentMilliStamp
        let x_transaction_id = timeStamp+"@"+randomString(length: 7)
        
        var headers: HTTPHeaders = ["Accept": "application/json, text/plain, */*",
                                    "Content-Type": "application/json;charset=UTF-8",
                                    "x-transaction-id": x_transaction_id]


        if method == .post {
            
            let data = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            var request = URLRequest.init(url: URL(string: full_url)!)
            request.httpMethod = HTTPMethod.post.rawValue
            request.httpBody = data
            request.timeoutInterval = 10.0
            
            request.headers = headers
//            if ToolInstance.instance.isLogin() {
//                headers["Authorization"] = "Bearer \(Defaults[.userToken])"
//            }
            
            session.request(request).validate().responseString { (response) in
                PrintLog(JSON(parameters))
                
                self.handleResponseData(url: url, response: response, success: success, successListCallback: successListCallback, failure: failure)
            }
            
        }else if method == .patch {
            
            let data = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            var request = URLRequest.init(url: URL(string: full_url)!)
            request.httpMethod = HTTPMethod.patch.rawValue
            request.httpBody = data
            request.timeoutInterval = 10.0
            
            request.headers = headers
//            if ToolInstance.instance.isLogin() {
//                headers["Authorization"] = "Bearer \(Defaults[.userToken])"
//            }
            
    
            session.request(request).validate().responseString { (response) in
                PrintLog(JSON(parameters))
                
                self.handleResponseData(url: url, response: response, success: success, successListCallback: successListCallback, failure: failure)
            }
            
        }else if method == .get {
            
            session.request(full_url, method: method, parameters: parameters, headers: headers, requestModifier: {
                $0.timeoutInterval = 10
                
            }).validate().responseString { response in
                
                PrintLog(JSON(parameters))
                self.handleResponseData(url: url, response: response, success: success, successListCallback: successListCallback, failure: failure)
            }
        }
        
    }
        
    private func upload(url: String, params: [String: String]?, images: [UIImage], success: @escaping (Any?) -> Void, failure: @escaping ((Any?) -> Void)) {
        session.upload(multipartFormData: { multipartFormData in
            
            if params != nil {
                for (key, value) in params! {
                    // 参数的上传
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
                
                for (index, value) in images.enumerated() {
                    let imageData = value.jpegData(compressionQuality: 0.5)
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyyMMddHHmmss"
                    let str = formatter.string(from: Date())
                    let fileName = str+"\(index)"+".jpg"
                    
                    // 以文件流格式上传
                    multipartFormData.append(imageData!, withName: "imageFiles", fileName: fileName, mimeType: "image/jpeg")
                }
            }
            
        }, to: url, usingThreshold: MultipartFormData.encodingMemoryThreshold, method: .post, headers: nil, interceptor: nil, fileManager: FileManager.default) { _ in
            
        }.responseString { (response) in
            
            self.handleResponseData(url: url, response: response, success: success, failure: failure)
        }
    }
    
    
    // 处理返回 data 是字典的数据
    private func handleResponseData(url: String,response: AFDataResponse<String>,success: ((Any?) -> Void)? = nil, successListCallback: ((Any?) -> Void)? = nil, failure: @escaping ((Any?) -> Void)) {
        
        do {
            if let data = response.data {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                let format_json = JSON(json)
                PrintLog(format_json)
                
    
                if let callbaack = success {
                    callbaack(format_json)
                }
                
//                if format_json["resultCode"].string == "success" {
//
//                }else {
//
//                    failure("invalid token")
//
//                }
                
            } else {
                if response.response == nil {
//                    appw?.l_showToastMessage(with: "请求数据失败")
                }
                PrintLog("请求数据为空\nStatus Code: \(response.response?.statusCode ?? 0)")
                failure("请求数据为空")
            }
        } catch let e as NSError {
            failure("请求数据失败")
            PrintLog("请求出现错误：\nStatus Code: \(response.response?.statusCode ?? 0)\n URL: \(response.response?.url?.absoluteString ?? "")\n Error Message:\(e)")
        }
    }
    
    
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
}

class WildcardServerTrustPolicyManager: ServerTrustManager {
    override func serverTrustEvaluator(forHost host: String) throws -> ServerTrustEvaluating? {
        if let policy = evaluators[host] {
            return policy
        }
        var domainComponents = host.split(separator: ".")
        if domainComponents.count > 2 {
            domainComponents[0] = "*"
            let wildcardHost = domainComponents.joined(separator: ".")
            return evaluators[wildcardHost]
        }
        return nil
    }
}
