//
//  Dictionary+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit


extension NSDictionary {
    
    func transformToData() -> Data {
        
        return try!JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
    }
    
    /**
     * 字典转换为JSONString
     *
     */
    func toJSONStringFromDictionary() -> String {
        if (!JSONSerialization.isValidJSONObject(self)) {
            return ""
        }
        let data = try? JSONSerialization.data(withJSONObject: self, options: []) as NSData
        let JSONString = NSString(data:data! as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
        
    }
}


extension Dictionary{
    
    
    /// 排序后链接参数，如：b=z ,a=c,处理后acbz

    func LinkParameters(_ kvs:Dictionary<String,String>) -> String {
        
        let keyArr:[String] = Array(kvs.keys)
        var kvStr:String = ""
        var sortArr:Array = [String]()
        sortArr = keyArr.sorted(by: { (n1, n2) -> Bool in
            return n2 > n1
        })
        for k in sortArr {
            if let _ = kvs[k] {
                let kv = k + "=" + kvs[k]! + "&"
                kvStr.append(kv)
            }else{
                let kv = k
                kvStr.append(kv)
            }
        }
        if kvStr.count > 0 {
        
            kvStr.removeLast()
        }
        

        return kvStr        
    }
    
    
    /**
     * 字典转换为JSONString
     *
     */
    func toJSONStringFromDictionary() -> String {
        
        var jsonStr = ""
        if (!JSONSerialization.isValidJSONObject(self)) {
            return ""
        }
        let data = try? JSONSerialization.data(withJSONObject: self, options: [])
        guard let d = data else {
            return jsonStr
        }
        
        jsonStr = String(data:d,encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
        
        return jsonStr
        
    }
    
    
}
