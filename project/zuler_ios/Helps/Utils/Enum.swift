//
//  Enum.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import UIKit

/**
 *  开发模式
 */
enum DeveloperMode {
    /** 调试 */
    case debug    
    /** 线上 注册设备可用 */
    case adHoc
    /** 线上 */
    case release
    
}

/**
 *  图片类型
 */
enum ImageTypeMode {
//    base64 类型的图
    case base64
//    网图
    case url
    
    
}

// MARK: - scorollview 刷新类型
enum TVloadType {
    /** 没有加载效果 */
    case none
    /** 只有refresh效果 */
    case refresh
    /** 只有加载更多 */
    case more
    /** 刷新和加载更多都有 */
    case all
}

/// 网络请求没数据的类型
enum ResponseNoDataType {
    case normal        //正常情况的没数据
    case serverError   //请求失败导致的没数据
    case networkDisable//没网导致的没数据
    case none
}

//底部sheet弹框的按钮点击事件类型
enum SheetEventType {
    case openPhotoLibrary//打开相册
    case openCamera      //打开相机
    case reply           //回复
    case complaint       //投诉
    case delete          //删除
    case commentDetail   //评论详情
    case switchEnvironment //切换开发环境（切换请求baseUrl）
    case openPhone       //打电话
    case none            //
    case TypeRelease            //正式版
    case TypePreview            //体验版
    case followRelation  //关注、取消关注
    case joinBlackList          //举报、拉黑
}

//底部sheet弹框类型
enum BottomSheetType {
    case replyComment  //回复评论
    case deleteComment //删除评论
    case openMedia     //打开相机或相册
    case onlyPhotoLibrary //只打开相册
    case switchEnvironment  //切换开发环境（切换请求baseUrl）
    case openPhone     //打开电话
    case changeWechatType     //切换小程序环境
    case followRelation     //关注
}

/// 选择媒体的类型
enum SelectMediaType {
    case muitiPhoto          //多选  只有照片
    case muitiPhotoAndVideo  //多选  照片和视频
    case singlePhoto         //单选  只有照片
}


/// 通用配置类型
enum CommonSettingsKeyType: String {
    case aboutUs = "aboutUsIOS"               //关于我们
    case tabSettings = "tabSetting"           //首页tab
    case userProtocol = "userProtocol"        //用户协议
    case privacyProtocol = "privacyProtocol"  //隐私政策
}


/// 提醒弹框类型
enum WarnAlertType {
    case cancelPublish  //取消发布
    case logout         //退出登录
    case deleteVideo    //删除视频
    case loginError    //第三方登录绑定手机号失败
    case checkPayment // 检查是否支付弹窗
    case editInfo      //编辑个人信息
    case joinBlacklist //加入黑名单
}


//  MARK: - environment

/// 环境配置
enum EnvironmentType: String {
    case sit = "sit"
    case dev = "dev"
    case uat = "uat"
    case prd = "prd"
}


//socketio 消息名称
enum SocketIOMessageName: String {
    case connected = "connected"
    case onAddStream = "onAddStream"
    case stream_message_erizo = "stream_message_erizo"
    case stream_message_p2p = "stream_message_p2p"
    case connection_message_erizo = "connection_message_erizo"
    case publish_me = "publish_me"
    case unpublish_me = "unpublish_me"
    case joinNotification = "joinNotification"
    case leaveNotification = "leaveNotification"
    case updateStreams = "updateStreams"
    case onBandwidthAlert = "onBandwidthAlert"
    case onDataStream = "onDataStream"
    case onUpdateAttributeStream = "onUpdateAttributeStream"
    case onRemoveStream = "onRemoveStream"
    case onAutomaticStreamsSubscription = "onAutomaticStreamsSubscription"
    case connection_failed = "connection_failed"
    case subscribe = "subscribe"
    case streamMessageP2P = "streamMessageP2P"
}
