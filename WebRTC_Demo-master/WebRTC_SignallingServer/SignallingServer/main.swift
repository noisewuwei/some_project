//
//  main.swift
//  SignallingServer
//
//  Created by Admin on 2021/8/23.
//

import Foundation

let server = try WebSocketServer()
server.start()
RunLoop.main.run()
