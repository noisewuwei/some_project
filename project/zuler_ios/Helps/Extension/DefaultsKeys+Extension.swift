//
//  DefaultsKeys+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    static func set(value: Any, forKey key: String) {
    
        Defaults[key] = value
        
    }
    
    static func string(forKey key: String) -> Bool {
        
        return Defaults[key].bool ?? false
        
    }
}

extension DefaultsKeys {
    
//    "geo" : {
//      "City" : "上海",
//      "CountryCode" : "CN",
//      "Province" : "上海",
//      "ProvinceEn" : "上海",
//      "Latitude" : 31.224349,
//      "CountryEn" : "中国",
//      "Longitude" : 121.476753,
//      "CityEn" : "上海",
//      "Isp" : "chinatelecom.com.cn",
//      "Country" : "中国",
//      "Ip" : "58.34.244.123"
//    }
    
    static let location = DefaultsKey<String>("location")
    static let geo = DefaultsKey<[String:Any]>("geo")
    static let service = DefaultsKey<String>("service")
    
    static let token = DefaultsKey<String>("token")
    static let roomID = DefaultsKey<String>("roomID")
    static let roomPassword = DefaultsKey<String>("roomPassword")
    
    static let uid = DefaultsKey<Int>("uid")
    
    static let validateSSL = DefaultsKey<Bool?>("validateSSL")
    
}
