//
//  BaseResponseModel.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/18.
//
//

import UIKit
import HandyJSON

class BaseResponseModel: HandyJSON {

    var resultCode: String?
    var transactionId: String?
    var serverTime: Int = 0
    var message: String?
    var data: [String: Any]?

    required init() {
        
    }
}

class BaseResponseListModel: HandyJSON {
    var resultCode: String?
    var transactionId: String?
    var serverTime: Int = 0
    var message: String?
    var data: [Any]?

    required init() {
        
    }
}


class BaseResponseListDataModel: HandyJSON {
    
    var blocks = [Any]()
    var hasMore : Bool?
    var next: String?
    required init() {}
}
