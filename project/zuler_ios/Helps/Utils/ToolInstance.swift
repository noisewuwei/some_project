//
//  ToolInstance.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import UIKit
import SAMKeychain



class ToolInstance: NSObject {
    
    static let instance = ToolInstance()
    
    fileprivate override init() {
        
    }
    
   
    func getStatusBarHight() -> CGFloat {
        var statusBarHeight:CGFloat = 0
        
        if #available(iOS 13.0, *) {
            let statusBarManager:UIStatusBarManager = (UIApplication.shared.windows.first?.windowScene?.statusBarManager)!
            statusBarHeight = statusBarManager.statusBarFrame.size.height
        }else{
            statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        }
        return statusBarHeight
    }
    
    
    // MARK: - device
    func getDevice() -> String{
        return "ios"
    }
    
    // MARK: - 客户端版本
    func  getVer() -> String {
        let vStr = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        return vStr
    }
    
    // MARK: - channel
    func getChannel() -> String{
        return "guanfang"
    }
    
    func getThressNormalParameters() -> Dictionary<String, String>{
        
        let d = ["device":ToolInstance.instance.getDevice(),"ver":ToolInstance.instance.getVer(),"channel":ToolInstance.instance.getChannel()]
         
        return d
    }
    
}






