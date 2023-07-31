//
//  Date+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit


extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    var currentTimeStamp : Int {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var currentMilliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    
}

extension Date {
    //GreenWitch Mean Time (GMT)
    static let timeZoneZulu: TimeZone = {
        // +0:00
        if let timeZone = TimeZone(secondsFromGMT:0) {
            return timeZone
        } else {
            //assertionFailure()
            return TimeZone.autoupdatingCurrent
        }
    }()
    
    //TimeZoneLocal （Shanghai）
    static let timeZoneLocal: TimeZone = {
        // +8:00
        if let timeZone = TimeZone(abbreviation:"UTC+8") {
            return timeZone
        } else {
            //assertionFailure()
            return TimeZone.autoupdatingCurrent
        }
    }()
    //Calender
    static let calendar: Calendar = {
        //Gregorian
        var result = Calendar(identifier: Calendar.Identifier.gregorian)
        result.timeZone = Date.timeZoneLocal
        return result
    }()
    
    //DateFormatter
    //2017-07-25 14:19:54:056 +08:00
    static let dateFormatter1: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:SSS ZZZZZ"
        dateFormatter.timeZone = Date.timeZoneLocal
        dateFormatter.locale = Date.localeDetermin
        return dateFormatter
    }()
    //2017-07-25 06:20:51 Z
    static let dateFormatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZZZ"
        dateFormatter.timeZone = Date.timeZoneZulu
        return dateFormatter
    }()
    //2016-01-01
    static let dateFormatter3: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = Date.timeZoneLocal
        return dateFormatter
    }()
    //Tuesday, Jul 25, 2017
    static let dateFormatter4: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        dateFormatter.timeZone = Date.timeZoneLocal
        dateFormatter.locale = Date.localeDetermin
        return dateFormatter
    }()
    //2:34 PM
    static let dateFormatter5: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = Date.timeZoneLocal
        dateFormatter.locale = Date.localeDetermin
        return dateFormatter
    }()
    //change locale
    static let localeDetermin: Locale = {
        let locale = Locale.init(identifier: "zh-Hans")
        return locale
    }()
    
    //change time from timeStamp to foramt string
    static func transferTimeStampToformatString(timeStamp: String) -> String {
        let timeStamp = CFStringGetDoubleValue(timeStamp as CFString)
        let date = Date(timeIntervalSince1970:timeStamp)
        let dateString = Date.dateFormatter4.string(from: date)
        return dateString
    }
    
    
    static func getDate(dateStr: String, format: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: dateStr)
        return date
    }
    
    func getComponent(component: Calendar.Component) -> Int {
        let calendar = Calendar.current
        return calendar.component(component, from: self)
    }
    
    func getString(format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    
}
