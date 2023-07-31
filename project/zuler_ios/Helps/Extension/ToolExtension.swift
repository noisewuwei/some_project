//
//  ToolExtension.swift
//  MeiRiDuo
//
//  Created by HyBoard on 2018/12/27.
//  Copyright © 2018 HyBoard. All rights reserved.
//

import UIKit
import UIKit
import Kingfisher

/// MARK: - 字符串转化成CGFloat Float double Int
protocol StringConverToNumber {
    
    /// MARK: - 转化CGFloat
    func toCGFloat() -> CGFloat
    /// MARK: - 转化Double
    func toDoule() -> Double
    /// MARK: - 转化Int
    func toInt() -> Int
    /// MARK: - 转化Float
    func toFloat() ->Float
}


/// MARK: - string extension

extension String:StringConverToNumber {
    
    func toCGFloat() -> CGFloat {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        
        return CGFloat.init(n.floatValue)
    }
    
    func toDoule() -> Double {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        
        return n.doubleValue
    }
    
    func toInt() -> Int {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        
        return n.intValue
    }
    
    func toFloat() -> Float {
        guard let n = NumberFormatter().number(from: self) else {
            return 0
        }
        return n.floatValue
    }
}


//=====以下为处理width heght 计算问题而写的protocal 和 extension===
public protocol NumberConvertible {}

extension NumberConvertible {
    
    public func toString() -> String {

        

        var interpolation = DefaultStringInterpolation(
            literalCapacity: 7,
            interpolationCount: 1)
        if self is NSNumber {
            interpolation.appendInterpolation(self)
        }
        if self is String || self is NSString {
            interpolation.appendLiteral(self as? String ?? "")
        }

        let string = String(stringInterpolation: interpolation)

        return string
//        return String(stringInterpolationSegment:self)
//        var interpolation = DefaultStringInterpolation(
//            literalCapacity: 7,
//            interpolationCount: 1)
//        // 2
//        let language = "Swift"
//        interpolation.appendLiteral(language)
//        let space = " "
//        interpolation.appendLiteral(space)
//        let version = 5
//        interpolation.appendInterpolation(version)
//        // 3
//        let string = String(stringInterpolation: interpolation)
//        return String(stringInterpolation: self as! DefaultStringInterpolation)

    }
    
}
//10 184 9 42
extension Double:NumberConvertible {}
extension CGFloat:NumberConvertible {}
extension Int:NumberConvertible {}

// MARK: - UI extension


public protocol ViewConvertible {}

extension ViewConvertible {
    
//    public func addCorner(_ cornerRadius: CGFloat = 0.0) -> self {
//        guard let v = self as? UIView  else {
//            return self
//        }
//
//        v.layer.cornerRadius = cornerRadius.WIDTH()
//        v.layer.masksToBounds = true
//
//        
//        return v as! self
//    }
    
    
    
}

extension UIView:ViewConvertible {}
extension UIImageView: ViewConvertible {}


extension UILabel:ViewConvertible {}
extension UIButton:ViewConvertible {}



