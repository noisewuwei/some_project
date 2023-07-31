//
//  NetConfig.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/17.
//


import UIKit


class BaseUrlManager {
    
    static let manager = BaseUrlManager()
    
    var wildcardHost = "*.izuler.io"
    
    
    var passportUrl = "https://passport.izuler.io:31020" //https://mh-uat.immotors.com/app
    var baseUrl = "https://lbs.izuler.io:30120" //https://mh-uat.immotors.com/app
//    var baseImageUrl = ""
//    var baseWebUrl = "https://m.immotors.com"
//
//    var baseEnvironment = EnvironmentType.prd
//

}

struct ApiManager {
    
    static let lbsServices = "/v1/lbs-service/services"
    
    static let userGuestuid = "/v1/passport-service/user/guestuid"
    static let userSignin = "/v1/passport-service/user/signin"
    
    static let rooms = "/v1/entry-service/rooms"
    static let roomsUid = "/v1/entry-service/rooms/uid"
    static let roomsJoin = "/v1/entry-service/rooms/joinRoom"
    static let roomsPassword = "/v1/entry-service/rooms/roomPassword"
   
}


/// web页面地址
//enum WebUrlManager {
//    case logout //注销
//    case invite //邀请有理
//    case campDetial(String)
//    case subject(subjectId: String)
//    case pageContent(resourceType: String , resourceId:String , comment:String, autoPlay:String) // 内容跳转
//    case pageVideoContent(resourceType: String , resourceId:String , comment:String, autoPlay:String ,videoUrl:String,currentTime:String) // 有视频内容跳转
//    case abount(link: String)
//    case vehicleOrder(orderNumber: String)
//    case vehicleReserve//立即预定
//    case checkin(status:String,angelFlag:String,point:String,count:String,lastSignDate:String)//签到
//    case userProtocol
//    case userPublicProtocol //用户协议页面
//    case privacyProtocol
//    case privacyPublicProtocol //隐私政策页面
//    case shareOrder(order: String) // 买车之后的分享
//    case rights//权益
//    case storyLine//A车介绍
//}

//extension WebUrlManager: WebUrlProtocol {
//
//    var baseWebUrl: String {
//        return BaseUrlManager.manager.baseWebUrl
//    }
//
//    var path: String {
//
//        switch self {
//        case .logout:
//            return getFullPath(path: "/app/h5/page/cancel")
//        case .invite:
//            return getFullPath(path: "/app/h5/page/invite")
//        case .campDetial(let circleId):
//            return getFullPath(path: "/app/h5/page/camp?circleId=\(circleId)")
//        case .subject(let subjectId):
//            return getFullPath(path: "/app/h5/page/subject?subjectId=\(subjectId)")
//        case .pageContent(let resourceType,let resourceId,let comment,let autoPlay):
//            return getFullPath(path: "/app/h5/page/content?type=\(resourceType)&id=\(resourceId)&comment=\(comment)&autoPlay=\(autoPlay)")
//        case .pageVideoContent(let resourceType,let resourceId,let comment,let autoPlay,let videoUrl,let currentTime):
//            return getFullPath(path: "/app/h5/page/content?type=\(resourceType)&id=\(resourceId)&comment=\(comment)&autoPlay=\(autoPlay)&videoUrl=\(videoUrl)&currentTime=\(currentTime)")
//        case .abount(link: let link):
//            return getFullPath(path: link)
//        case .vehicleOrder(orderNumber: let orderNumber):
//            return getFullPath(path: "/app/h5/page/vehicleOrder?orderNumber=\(orderNumber)")
//        case .vehicleReserve:
//            return getFullPath(path: "/app/h5/page/vehicleReserve")
//        case .checkin(let status,let angelFlag,let point,let count,let currentTime):
//            return getFullPath(path: "/app/h5/page/checkin?status=\(status)&angelFlag=\(angelFlag)&point=\(point)&count=\(count)&lastSignDate=\(currentTime)")
//        case .userProtocol:
//            return getFullPath(path: Defaults[.userProtocol])
//        case .privacyProtocol:
//            return getFullPath(path: Defaults[.privacyProtocol])
//        case .shareOrder(order: let order):
//            return getFullPath(path: "/app/h5/page/unboxing?order=\(order)")
//        case .rights:
//            return getFullPath(path: "/app/h5/page/rights")
//
//        case .storyLine:
//            return getFullPath(path: "/app/h5/page/storyline")
//        case .userPublicProtocol:
//            return getFullPath(path: "/app/h5/page/statement?key=userProtocol&showNavigator=true")
//        case .privacyPublicProtocol:
//            return getFullPath(path: "/app/h5/page/statement?key=privacyProtocol&showNavigator=true")
//        }
//
//
//    }
//
//    private func getFullPath(path: String) -> String {
//        return baseWebUrl+path
//    }
//}
