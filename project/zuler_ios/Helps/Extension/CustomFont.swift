//
//  CustomFont.swift
//  MeiRiDuo
//
//  Created by 井玉中 on 2019/3/4.
//  Copyright © 2019年 HyBoard. All rights reserved.
//

import UIKit

/// 平方字体类型
///
/// - Regular: 常规
/// - Light: 细体
/// - Medium: 粗体
enum PFSCFontType: String {
    case Regular = "PingFangSC-Regular"
    case Light = "PingFangSC-Light"
    case Medium = "PingFangSC-Medium"
    case Thin = "PingFangSC-Thin"
}

class CustomFont {
    
    /// 项目通用字体定义
    ///
    /// - Parameters:
    ///   - type: 字体类型
    ///   - size: 字体大小
    /// - Returns: UIFont
    class func PF_SC_FONT(type: PFSCFontType ,size: CGFloat) -> UIFont {
        if #available(iOS 9.0, *) {
            return UIFont.init(name: type.rawValue, size: size)!
        } else {
            if type == .Medium {
                return UIFont.boldSystemFont(ofSize: size)
            }
            return UIFont.systemFont(ofSize: size)
        }
    }
}

