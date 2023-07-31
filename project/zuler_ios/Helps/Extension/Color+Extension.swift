//
//  Color+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit


extension UIColor {
    
    /// 根据HEX返回UIColor,alpha = 1.0
    
    class  func hexColor(_ hexStr:String) -> UIColor {
        if hexStr.count < 6 {
            return UIColor.hex_FFFFFF
        }
        return self.hexColor(hexStr, withAlpha: CGFloat.init(1.0))
    }
    
    
    /// 根据HEX,alpha 返回UIColor
    class func hexColor(_ hexStr:String,withAlpha alpha:CGFloat) -> UIColor {
        //trim 空格
        let cStr = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        guard cStr.hasPrefix("#") || cStr.count == 7 else{
            
            return UIColor.clear
        }
        
        let rstartIdx = cStr.index(cStr.startIndex, offsetBy: 1)
        let rendIdx = cStr.index(rstartIdx, offsetBy: 2)
        let rr:Range = rstartIdx..<rendIdx
        let rs = String(cStr[rr])
        
//        let gstartIdx = cStr.index(rendIdx, offsetBy: 1)
        let gendIdx = cStr.index(rendIdx, offsetBy: 2)
        let gr:Range = rendIdx..<gendIdx
        let gs = String(cStr[gr])
        
//        let bstartIdx = cStr.index(gendIdx, offsetBy: 1)
        let bendIdx  = cStr.index(gendIdx, offsetBy: 2)
        let br:Range = gendIdx..<bendIdx
        let bs = String(cStr[br])
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rs).scanHexInt32(&r)
        Scanner(string: gs).scanHexInt32(&g)
        Scanner(string: bs).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha )
        
    }
    
    // 生成随机颜色
    class func randomColor() -> UIColor {
        
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor(red: r/255.0, green: g/255/0, blue: b/255/0, alpha: 1.0)
    }
    // 根据 rgb值返回对应的 UIColor
    class func RGBColor(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat = 1.0) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
}


extension UIColor {
    
    //  MARK: - UIButton

    open class var hex_noColor: UIColor { return UIColor.init(red: 10/255.0, green: 10/255.0, blue: 10/255.0, alpha: 0.0) }
    
    open class var hex_000000: UIColor { return UIColor.hexColor("#000000") }
    
    open class var hex_131415: UIColor { return UIColor.hexColor("#131415") }
    
    open class var hex_181818: UIColor { return UIColor.hexColor("#181818") }
    
    open class var hex_292929: UIColor { return UIColor.hexColor("#292929") }

    open class var hex_737373: UIColor { return UIColor.hexColor("#737373") }
    
    open class var hex_D2915A: UIColor { return UIColor.hexColor("#D2915A") }
    open class var hex_DE733A: UIColor { return UIColor.hexColor("#DE733A") }

    open class var hex_FFBF6E: UIColor { return UIColor.hexColor("#FFBF6E") }

    open class var hex_FFEFE6: UIColor { return UIColor.hexColor("#FFEFE6") }
    open class var hex_FFFFFF: UIColor { return UIColor.hexColor("#FFFFFF") }

    open class var hex_F4F4F4: UIColor { return UIColor.hexColor("#F4F4F4") }
    open class var hex_F4F5F7: UIColor { return UIColor.hexColor("#F4F5F7") }

    open class var hex_F6F7F8: UIColor { return UIColor.hexColor("#F6F7F8") }
    
    open class var hex_F7F7F7: UIColor { return UIColor.hexColor("#F7F7F7") }

    open class var hex_F76B1C: UIColor { return UIColor.hexColor("#F76B1C") }
    open class var hex_F89541: UIColor { return UIColor.hexColor("#F89541") }

    open class var hex_D2A04B: UIColor { return UIColor.hexColor("#D2A04B") }
    
    
    
    
    
    
    
    open class var hex_333333: UIColor { return UIColor.hexColor("#333333") }
    
    open class var hex_3D4041: UIColor { return UIColor.hexColor("#3D4041") }

    open class var hex_B3B9C6: UIColor { return UIColor.hexColor("#B3B9C6") }
    
    open class var hex_C8C8C8: UIColor { return UIColor.hexColor("#C8C8C8") }
    open class var hex_CCCCCC: UIColor { return UIColor.hexColor("#CCCCCC") }

    
    open class var hex_D34138: UIColor { return UIColor.hexColor("#D34138") }

    open class var hex_FC5732: UIColor { return UIColor.hexColor("#FC5732") }
    
    open class var hex_B3B3B3: UIColor { return UIColor.hexColor("#B3B3B3") }
    
    open class var hex_222222: UIColor { return UIColor.hexColor("#222222") }
    
    open class var hex_F2F1F0: UIColor { return UIColor.hexColor("#F2F1F0") }
    
    open class var hex_F0AA79: UIColor { return UIColor.hexColor("#F0AA79") }

    open class var hex_F5F5F5: UIColor { return UIColor.hexColor("#F5F5F5") }
    
    
    open class var hex_F7F7F8: UIColor { return UIColor.hexColor("#F7F7F8") }

    open class var hex_666666: UIColor { return UIColor.hexColor("#666666") }
    
    open class var hex_ADB4BE: UIColor { return UIColor.hexColor("#ADB4BE") }
    
    open class var hex_FA3939: UIColor { return UIColor.hexColor("#FA3939") }
    open class var hex_FAEBE3: UIColor { return UIColor.hexColor("#FAEBE3") }

    open class var hex_AAAAAA: UIColor { return UIColor.hexColor("#AAAAAA") }
    
    open class var hex_E1B692: UIColor { return UIColor.hexColor("#E1B692") }
    open class var hex_E39C5F: UIColor { return UIColor.hexColor("#E39C5F") }
    open class var hex_E4E4E4: UIColor { return UIColor.hexColor("#E4E4E4") }

    open class var hex_E9BF9C: UIColor { return UIColor.hexColor("#E9BF9C") }
    open class var hex_E9E9E9: UIColor { return UIColor.hexColor("#E9E9E9") }

    open class var hex_ECEEF1: UIColor { return UIColor.hexColor("#ECEEF1") }
    
    open class var hex_EDEDED: UIColor { return UIColor.hexColor("#EDEDED") }

    open class var hex_EE593D: UIColor { return UIColor.hexColor("#EE593D") }
    
    open class var hex_EEB99C: UIColor { return UIColor.hexColor("#EEB99C") }
    
    open class var hex_EEEEEE: UIColor { return UIColor.hexColor("#EEEEEE") }

    open class var hex_939393: UIColor { return UIColor.hexColor("#939393") }
    
    open class var hex_999999: UIColor { return UIColor.hexColor("#999999") }

    open class var hex_FF5753: UIColor { return UIColor.hexColor("#FF5753") }
    
    open class var hex_262633: UIColor { return UIColor.hexColor("#262633") }
    
    open class var hex_FF3939: UIColor { return UIColor.hexColor("#FF3939") }
    
    open class var hex_B07979: UIColor { return UIColor.hexColor("#B07979") }
    
    open class var hex_B1B7C5: UIColor { return UIColor.hexColor("#B1B7C5") }


}
extension UIColor {
    // convenience 扩展遍历构造函数
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    // 随机色
//    class func randomColor() -> UIColor {
//        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
//    }
}
