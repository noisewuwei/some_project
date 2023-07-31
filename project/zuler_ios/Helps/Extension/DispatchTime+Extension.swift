//
//  DispatchTime+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/11/2.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit

//===============

//就行延时操作的扩展
extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}
extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}



