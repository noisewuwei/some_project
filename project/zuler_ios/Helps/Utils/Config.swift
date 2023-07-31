//
//  Config.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import Foundation
import UIKit
import SnapKit
import ObjectMapper
import Kingfisher

// MARK: - double类型width
/// - double类型width
let ScreenWidth:Double=Double(UIScreen.main.bounds.size.width)
// MARK: - double类型height
/// - double类型height
let ScreenHeight:Double=Double(UIScreen.main.bounds.size.height)
// MARK: - cgfloat类型width
/// - cgfloat类型width
let SRNW:CGFloat = UIScreen.main.bounds.size.width
// MARK: - cgfloat类型height
/// - cgfloat类型height
let SRNH:CGFloat = UIScreen.main.bounds.size.height
// MARK: - 简单的判断
/// - 简单的判断
let isiPhoneX: Bool = (StatusBarHeight != 20)
//    SRNW == 375 && SRNH == 812
// MARK: - statusBar高度
/// statusBar高度
let StatusBarHeight:CGFloat = ToolInstance.instance.getStatusBarHight()


// 导航栏下面x到顶部的距离
let SafeWithNavToTop : CGFloat = StatusBarHeight + 44.0
// MARK: - navBar高度
/// navBar高度
let NavBarHeight:CGFloat = 44.0
// MARK: - 判断状态栏高度
/// 判断状态栏高度
let SStatusBarHeight:CGFloat = isiPhoneX ? NavBarHeight : StatusBarHeight
// MARK: - 关注赚钱详情页状态栏多加了0 还是 24
/// 关注赚钱详情页状态栏多加了0 还是 24
let FDStatusBarHeight:CGFloat = isiPhoneX ? 24 : 0
// MARK: - tabBar高度
/// tabBar高度
let TabBarHeight:CGFloat = 49.0
let NewTabBarHeight:CGFloat = isiPhoneX ? 83.0 : 49.0
// 底部黑线高度
let TabBarBottomHeight = isiPhoneX ? 34.0 : 0


// MARK: - 安全区（包含statusbar）高度
/// - 安全区（包含statusbar）高度
let SafeAndStatusBarHeight = 44.0
// MARK: - 安全区（包含tabbar）高度
/// - - 安全区（包含tabbar）高度
let SafeAndTabBarHeight = 83.0
// - - 安全区（不包含tabbar）高度
let SafeExceptionTabBarHeight:CGFloat = 34.0
// MARK: - 安全区加navbar高度
/// - - 安全区加navbar高度
let SafeAndStatusBarAndNavHeight = 88.0
// MARK: - 获取根导航控制器

/** 判断是否存在热点 */
let Is_HotSPot: Bool = (StatusBarHeight == 40) ? true : false

// 本地存储
let userDefault = UserDefaults.standard

/// default图片
let DefaultPic = "defaulePic"

/// MARK: - 是否打开过此app - 每次新版本都需要重新布置这个的啊,所以根据版本号设置最为妥当了,我是这么想的
let WhetherOpen = "WhetherOpen" + ToolInstance.instance.getVer()
//是不是已经保存了该设备
let CapsuleClientOK = "capsuleClientOK"
// user 的黄钻数量
let UserDiamond = "UserDiamond"

let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "zuan"

/// MARK: - Key window
let appw = UIApplication.shared.keyWindow
/// MARK: - userdefault
let DEFAULT = UserDefaults.standard

let app:AppDelegate = UIApplication.shared.delegate as! AppDelegate
/** 当前 app 当前版本 */
let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
/** 获取 build 版本 , 这个用不到了*/
let verCodes: String =  Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
/** 读取之后 每次升级之后修改 */
let verCode: String =  Bundle.main.infoDictionary?["vercode"] as? String ?? "1"

let kSuccessCode: String = "200"
let updateViewTag:Int = 10000000
let searchAlterViewTag:Int = 10000001
let zeroViewTag:Int = 100000000
let tbAlertViewTag:Int = 10001

/** 信息打印 */
func PrintLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {

    #if DEBUG
    
    print("""
        
        =======================================================
        file    >>>    \((file as NSString).lastPathComponent)    <<<
        METHOD: >>>    \(method)    <<<
        LINE:   >>>    \(line)    <<<
        打印信息--> Message:
        \(message)
        <--打印信息
        Time:   >>> 时间:时间戳(13位):\(Date().currentMilliStamp) <<<
        Time:   >>> 时间:\("\(Date().currentTimeStamp)".transformTimestamptoDate("yyyy-MM-dd HH:mm:ss EEE")) <<<
        =======================================================
        
        """)
    
    #endif
    
}

/// MARK: - 一般改变文字颜色
func titleAttribute(_ subStr:String, fullStr:String, color:UIColor) -> NSAttributedString {
    
    let a =  NSMutableAttributedString.init(string: fullStr)
    let r = (fullStr as NSString).range(of: subStr)
    a.addAttributes([NSAttributedString.Key.foregroundColor:color], range: r)
    return a
}

/// MARK: - 图片地址
func imgUrl(_ urlStr:String) ->URL{
    
    let u = "\(urlStr)"
    return URL.init(string: u)!
    
}

//获取沙盒Document路径
let kDocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
//获取沙盒Cache路径
let kCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
//获取沙盒temp路径
let kTempPath = NSTemporaryDirectory()


//let device = Device()
let iosVersion = UIDevice.current.systemVersion //iOS版本
let identifierNumber = UIDevice.current.identifierForVendor //设备udid
let systemName = UIDevice.current.systemName //设备名称
let model = UIDevice.current.model  //设备型号
let modelName = UIDevice.current.model
    //.modelName //设备具体型号
let localizedModel = UIDevice.current.localizedModel //设备区域化型号如A1533


// 字体
let PingFangSC_Regular = "PingFangSC-Regular"
//
let PingFangSC_Medium = "PingFangSC-Medium"
// 细体
let PingFangSC_Light = "PingFangSC-Light"
// 中粗体
let PingFangSC_Semibold = "PingFangSC-Semibold"



/// 占位图片
struct DefaultImageConfig {
    /// 默认头像  正方形
    static let defaultAvatarImage_square = "defaultAvatar"
    ///
    static let default_logo = "default_logo"
//    长方形站位
    static let default_logo_width = "vedioPlaImg"
}


func safeAreaEdgeInsets() -> UIEdgeInsets {
    return isiPhoneX ? UIEdgeInsets(top: StatusBarHeight, left: 0.0, bottom: 34.0, right: 0.0) : UIEdgeInsets.zero
}


