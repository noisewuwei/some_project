////
////  NativeSocketProvider.swift
////  zuler_ios
////
////  Created by Admin on 2021/8/16.
////
//
//import Foundation
//
//@available(iOS 13.0, *)
//class NativeWebSocket: NSObject, WebSocketProvider {
//    
//    var delegate: WebSocketProviderDelegate?
//    private let url: URL
//    private var socket: URLSessionWebSocketTask?
//    private lazy var urlSession: URLSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
////    private lazy var urlS: URLSession = URLSession(configuration: "", delegate: self, delegateQueue: nil)
//
//    init(url: URL) {
//        self.url = url
//        super.init()
//    }
//
//    func connect() {
//        
//        let request = URLRequest(url: url)
//        let socket = urlSession.webSocketTask(with: request)
//        socket.resume()
//        self.socket = socket
//        self.readMessage()
//    }
//
//    func send(data: Data) {
//        self.socket?.send(.data(data)) { _ in }
//    }
//    
//    private func readMessage() {
//        self.socket?.receive { [weak self] message in
//            guard let self = self else { return }
//            
//            switch message {
//            case .success(.data(let data)):
//                self.delegate?.webSocket(self, didReceiveData: data)
//                self.readMessage()
//                
//            case .success:
//                debugPrint("Warning: Expected to receive data format but received a string. Check the websocket server config.")
//                self.readMessage()
//
//            case .failure:
//                self.disconnect()
//            }
//        }
//    }
//    
//    private func disconnect() {
//        self.socket?.cancel()
//        self.socket = nil
//        self.delegate?.webSocketDidDisconnect(self)
//    }
//}
//
//@available(iOS 13.0, *)
//extension NativeWebSocket: URLSessionWebSocketDelegate, URLSessionDelegate  {
//    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
//        self.delegate?.webSocketDidConnect(self)
//    }
//    
//    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
//        self.disconnect()
//    }
//}
