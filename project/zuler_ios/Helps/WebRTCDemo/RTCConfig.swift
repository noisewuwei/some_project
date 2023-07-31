//
//  Config.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import Foundation

//这里设置你的服务器端电脑连接的wifi的ip地址
fileprivate let server_wifi_ip:String = "192.168.109.47"

//连接服务端的URL
fileprivate let defaultSignalingServerUrl = URL(string: "http://\(server_wifi_ip):8080")!

//谷歌的公共stun服务器
fileprivate let defaultIceServers = ["stun:stun.l.google.com:19302",
                                     "stun:stun1.l.google.com:19302",
                                     "stun:stun2.l.google.com:19302",
                                     "stun:stun3.l.google.com:19302",
                                     "stun:stun4.l.google.com:19302"]

struct RTCConfig {
    let signalingServerUrl: URL
    let webRTCIceServers: [String]
    
    static let `default` = RTCConfig(signalingServerUrl: defaultSignalingServerUrl, webRTCIceServers: defaultIceServers)
}
