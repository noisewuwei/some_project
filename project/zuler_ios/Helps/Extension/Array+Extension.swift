//
//  Array+Extension.swift
//  MeiRiDuo
//
//  Created by HyBoard on 2019/1/19.
//  Copyright © 2019 HyBoard. All rights reserved.
//

import UIKit

extension Array {
    subscript (safe index: Int) -> Element? {
        return (0..<count).contains(index) ? self[index] : nil
    }
}

extension NSArray {
    
    func saveToLocal() {
        let filePath:String = NSHomeDirectory() + "/Documents/searchLocal.plist"
        self.write(toFile: filePath, atomically: true)
    }
    class func getLocalArray() -> NSMutableArray {
        let arr = NSMutableArray.init(contentsOfFile: NSHomeDirectory() + "/Documents/searchLocal.plist")
        return arr ?? NSMutableArray()
    }
    
    func saveHotToLocal() {
        let filePath:String = NSHomeDirectory() + "/Documents/saveHotToLocal.plist"
        self.write(toFile: filePath, atomically: true)
    }
    class func getLocalHotArray() -> NSMutableArray {
        let arr = NSMutableArray.init(contentsOfFile: NSHomeDirectory() + "/Documents/saveHotToLocal.plist")
        return arr ?? NSMutableArray()
    }
    

}
