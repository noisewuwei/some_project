//
//  Device+Extension.swift
//  MeiRiDuo
//
//  Created by HyBoard on 2019/1/29.
//  Copyright © 2019 HyBoard. All rights reserved.
//

import UIKit

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}
