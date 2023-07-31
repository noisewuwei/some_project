//
//  File.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import Foundation

protocol WebSocketProvider: AnyObject {
    var delegate: WebSocketProviderDelegate? { get set }
    func connect()
    func send(data: Data)
    func send(message: [String:Any], messageName: SocketIOMessageName)
}

protocol WebSocketProviderDelegate: AnyObject {
    func webSocketDidConnect(_ webSocket: WebSocketProvider)
    func webSocketDidDisconnect(_ webSocket: WebSocketProvider)
    func webSocket(_ webSocket: WebSocketProvider, didReceiveData data: Data)
    func webSocket(_ webSocket: WebSocketProvider, didReceiveConnectedData data: Any, withMessageName name: SocketIOMessageName)
}
