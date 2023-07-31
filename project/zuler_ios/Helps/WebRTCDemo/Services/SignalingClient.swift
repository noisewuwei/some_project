//
//  SignalClient.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/16.
//

import Foundation
import WebRTC
import SwiftyJSON

protocol SignalClientDelegate: AnyObject {
    func signalClientDidConnect(_ signalClient: SignalingClient)
    func signalClientDidDisconnect(_ signalClient: SignalingClient)
    func signalClient(_ signalClient: SignalingClient, didReceiveRemoteSdp sdp: RTCSessionDescription)
    func signalClient(_ signalClient: SignalingClient, didReceiveCandidate candidate: RTCIceCandidate)
}

final class SignalingClient {
    
    var connectMessageCallback: ((Any) -> Void)?
    var stream_message_p2pMessageCallback: ((Any) -> Void)?
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let webSocket: WebSocketProvider
    weak var delegate: SignalClientDelegate?
    
    init(webSocket: WebSocketProvider) {
        self.webSocket = webSocket
    }
    
    func connect() {
        self.webSocket.delegate = self
        self.webSocket.connect()
    }
    
    func sendTypeMessage(message: [String:Any], type: SocketIOMessageName){
        self.webSocket.send(message: message, messageName: type)
    }
    
    func sendStr(str: String){
        
        let strData = str.data(using: .utf8)!
        self.webSocket.send(data: strData)
        
    }
    
    func send(sdp rtcSdp: RTCSessionDescription) {
        let message = Message.sdp(SessionDescription(from: rtcSdp))
        do {
            let dataMessage = try self.encoder.encode(message)
            self.webSocket.send(data: dataMessage)
        }
        catch {
            debugPrint("Warning: Could not encode sdp: \(error)")
        }
    }
    
    func send(candidate rtcIceCandidate: RTCIceCandidate) {
        let message = Message.candidate(IceCandidate(from: rtcIceCandidate))
        do {
            let dataMessage = try self.encoder.encode(message)
            self.webSocket.send(data: dataMessage)
        }
        catch {
            debugPrint("Warning: Could not encode candidate: \(error)")
        }
    }
}


extension SignalingClient: WebSocketProviderDelegate {
    
    
    func webSocket(_ webSocket: WebSocketProvider, didReceiveConnectedData data: Any, withMessageName name: SocketIOMessageName) {
        if name == .connected{
            if let callback = self.connectMessageCallback{
                callback(data)
            }
        }else if name == .stream_message_p2p{
            let array = data as! Array<Any>
            let dic = JSON(array.first as Any)
            let msgDic = dic["msg"].dictionaryValue
            let dataDic = msgDic["msg"]?.dictionaryValue
            
            let type = dataDic?["type"]?.stringValue
            
            if type == "offer" {
                let sdp = dataDic?["sdp"]?.stringValue
                let webrtcSdp = RTCSessionDescription(type: .offer, sdp: sdp ?? "")
                self.delegate?.signalClient(self, didReceiveRemoteSdp: webrtcSdp)
                
                if let callback = self.stream_message_p2pMessageCallback{
                    callback(data)
                }
                
            }else if type == "candidate"{
                let canDic = dataDic?["candidate"]?.dictionaryValue
                let iceCan = RTCIceCandidate(sdp: canDic?["candidate"]?.stringValue ?? "", sdpMLineIndex: 0, sdpMid: "0")
                self.delegate?.signalClient(self, didReceiveCandidate: iceCan)
            }
        }
    }
    
    func webSocketDidConnect(_ webSocket: WebSocketProvider) {
        self.delegate?.signalClientDidConnect(self)
    }
    
    func webSocketDidDisconnect(_ webSocket: WebSocketProvider) {
        self.delegate?.signalClientDidDisconnect(self)
        
        // try to reconnect every two seconds
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            debugPrint("Trying to reconnect to signaling server...")
            self.webSocket.connect()
        }
    }
    
    func webSocket(_ webSocket: WebSocketProvider, didReceiveData data: Data) {
        let message: Message
        do {
            message = try self.decoder.decode(Message.self, from: data)
        }
        catch {
            debugPrint("Warning: Could not decode incoming message: \(error)")
            return
        }
        
        switch message {
        case .candidate(let iceCandidate):
            self.delegate?.signalClient(self, didReceiveCandidate: iceCandidate.rtcIceCandidate)
        case .sdp(let sessionDescription):
            self.delegate?.signalClient(self, didReceiveRemoteSdp: sessionDescription.rtcSessionDescription)
        }

    }
}
