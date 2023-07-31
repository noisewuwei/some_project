//
//  File.swift
//  zuler_ios
//
//  Created by Admin on 2021/9/1.
//

import Foundation
import SocketIO

class SocketIO: WebSocketProvider {    
    var delegate: WebSocketProviderDelegate?
    
    private let config = RTCConfig.default
    
    var socketManager : SocketManager?
    var socket : SocketIOClient?
    
    init(url: URL, config: [String:Any]) {//wss://ec.izuler.io:30620
        
        socketManager = SocketManager(socketURL: url, config: config)
        
        socket = socketManager?.defaultSocket
        
        socket?.on(clientEvent: .connect, callback: { [weak self] data, ack in
            print("socket connected")
            guard let strongSelf = self else { return }
            strongSelf.delegate?.webSocketDidConnect(strongSelf)
        })
        
        socket?.on(clientEvent: .disconnect, callback: { [weak self] data, ack in
            print("socket disconnected")
            guard let strongSelf = self else { return }
            strongSelf.delegate?.webSocketDidDisconnect(strongSelf)
        })
        
        socket?.on(clientEvent: .error, callback: { data, ack in
            print(data)
        })
        
        socket?.on(SocketIOMessageName.connected.rawValue, callback: { [weak self] data, ack in
            print("receive msg")
            guard let strongSelf = self else { return }
            strongSelf.delegate?.webSocket(strongSelf, didReceiveConnectedData: data, withMessageName: .connected)
        })
        
        socket?.on(SocketIOMessageName.stream_message_p2p.rawValue, callback: { [weak self] data, ack in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.webSocket(strongSelf, didReceiveConnectedData: data, withMessageName: .stream_message_p2p)
        })
        
    }
    
    func connect() {
        socket?.connect()
    }
    
    func send(data: Data) {
        socket?.emit("send Message", with: [data])
    }
    
    func send(message: [String:Any], messageName: SocketIOMessageName) {
        socket?.emit(messageName.rawValue, message, completion: nil)
    }

}
