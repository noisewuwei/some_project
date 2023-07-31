//
//  NotificationName+Extensions.swift
//  MeiRiDuo
//
//  Created by HyBoard on 2018/12/29.
//  Copyright © 2018 HyBoard. All rights reserved.
//

import UIKit
// 通知的拓展
extension Notification.Name {
    // 切换BaseUrl
    public static var ChangeBaseUrlNoti = Notification.Name("Change_Base_Url")
    public static var UpdateUserInfo = Notification.Name("UpdateUserInfo")
    public static var NOLoadingUpdateUserInfo = Notification.Name("NOLoadingUpdateUserInfo")
    public static var PushDanmu = Notification.Name("PushDanmu")
    public static var HomeRefreshNoti = Notification.Name("HOMERefresh")
    public static var CampRefreshNoti = Notification.Name("CampRefresh")
    public static var GreenPageRefreshNoti = Notification.Name("GreenPageRefresh")
    public static var ErrorPageNoti = Notification.Name("ErrorPageNoti")
    public static var RequestHomeTabConfig = Notification.Name("RequestHomeTabConfig")
    public static var PayWebPageNoti = Notification.Name("PayWebPageNoti")
    public static var PublishSuccess = Notification.Name("PublishSuccess")
    public static var OpenNoti = Notification.Name("OpenNoti")
    public static var LiveBack = Notification.Name("LiveBack")
    public static var kChangeLocationRightsNoti = Notification.Name("kChangeLocationRightsNoti")

    
}
extension NotificationCenter {
    
    class func postNotification(_ obj:String = "",
                                notiName:NSNotification.Name)
    {
        
        NotificationCenter.default.post(name: notiName, object: (obj == "" ? nil : ["key":obj]))
        
    }
    class func addNotification(_ obserVer:Any,
                               notiSelect:Selector,
                               notiName:NSNotification.Name)
    {
        
        NotificationCenter.default.addObserver(obserVer, selector: notiSelect, name: notiName, object: nil)
    }
    
    class func removeNotification(_ obserVer:Any,
                                  notiName:NSNotification.Name)
    {
        NotificationCenter.default.removeObserver(obserVer, name: notiName, object: nil)
    }
    
   
}
