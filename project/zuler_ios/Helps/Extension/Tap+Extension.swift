//
//  Tap+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/9/25.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit

class TapGestureManager: UITapGestureRecognizer,UIGestureRecognizerDelegate {
    //想间隔的时长
    var intervalTime: TimeInterval = 1
    //用于完成间隔的计时器
    private var eventTimer: Timer?
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        delegate = self
    }
    // 是否响应触摸手势的代理方法
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (eventTimer != nil) {
            return false
        }
        
        eventTimer = Timer(timeInterval: intervalTime, target: self, selector: #selector(deinitTimer), userInfo: nil, repeats: false)
        RunLoop.current.add(eventTimer!, forMode: RunLoop.Mode.common)
        
        return true
    }
    
    @objc func deinitTimer() {
        eventTimer?.invalidate()
        eventTimer = nil
    }
}
class LongTapGestureManager: UILongPressGestureRecognizer, UIGestureRecognizerDelegate  {
    //想间隔的时长
    var intervalTime: TimeInterval = 1
    //用于完成间隔的计时器
    private var eventTimer: Timer?
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        self.minimumPressDuration = 1.5
        delegate = self
    }
    
    // 是否响应触摸手势的代理方法
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (eventTimer != nil) {
            return false
        }
        
        eventTimer = Timer(timeInterval: intervalTime, target: self, selector: #selector(deinitTimer), userInfo: nil, repeats: false)
        RunLoop.current.add(eventTimer!, forMode: RunLoop.Mode.common)
        
        return true
    }
    
    @objc func deinitTimer() {
        eventTimer?.invalidate()
        eventTimer = nil
    }
}

