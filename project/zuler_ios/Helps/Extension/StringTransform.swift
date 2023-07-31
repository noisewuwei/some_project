//
//  StringTransform.swift
//  LappTest
//
//  Created by yancr on 2020/11/19.
//

import UIKit
import ObjectMapper

class StringTransform: TransformType {
    
    typealias Object = String
    typealias JSON = Int
    
    func transformFromJSON(_ value: Any?) -> String? {
        
        if let v = value
        {
            return String.abNormalString(v)
        }else{
            
            return ""
        }
    }
    
    func transformToJSON(_ value: String?) -> Int? {
        
        if let v = value{
            
            return Int(v)
            
        }else{
            
            return 0
        }
        
    }
}
