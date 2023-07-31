//
//  AttributedString+Extension.swift
//  MeiRiDuo
//
//  Created by HyBoard on 2019/1/28.
//  Copyright © 2019 HyBoard. All rights reserved.
//

import UIKit
extension UILabel {
    enum GetSizeType_ENUM: Int {
        case text = 0
        case attributeString
    }
    
    ///  自动计算了label 的宽度，在此之前，需要有label的宽度约束
    ///
    /// - Returns:
    
    
    /// 获取label的高度,
    ///
    /// - Parameters:
    ///   - type: 计算text 还是attributeText，如果不传则（如果有text的话，优先计算attributeText的height，没有attributeText则计算text的height，如果两个都没有值则返回0）
    ///   - width: width的最大值。如果不传则（自动计算了label 的width，在此之前，需要有label的width约束）
    /// - Returns: 文本实际高度的最大值
    func getLabelHeight(type: GetSizeType_ENUM? = nil, width: CGFloat? = nil) -> CGFloat {
        var w: CGFloat = width ?? -1
        var h: CGFloat = CGFloat.greatestFiniteMagnitude
        if w <= 0 {
            if frame.width == 0 {
                layoutIfNeeded()
            }
            guard frame.width != 0 else {
                PrintLog("🌶🌶🌶： 计算label的height失败，因为其width为0")
                return 0
            }
            w = frame.width
        }
        
        if let attributedText = attributedText, let type = type, type == .attributeString{
            
            h = attributedText.getSize(width: w, height: h).height
        }else if let text = text {
            
            h = text.getLableHeigh(font: font, width: w)
        }else {
            PrintLog("label没有text，或者attribute")
        }
        return h
    }
    
    
    /// 获取label的widht,
    ///
    /// - Parameters:
    ///   - type: 计算text 还是attributeText，如果不传则（如果有text的话，优先计算attributeText的width，没有attributeText则计算text的width，如果两个都没有值则返回0）
    ///   - height: 高度的最大值。如果不传则（自动计算了label 的height，在此之前，需要有label的height约束）
    /// - Returns: 文本的宽度最大值
    func getLabelWidth(type: GetSizeType_ENUM? = nil, height: CGFloat? = nil) -> CGFloat {
        
        var w: CGFloat = CGFloat.greatestFiniteMagnitude
        var h: CGFloat = height ?? -1
        if h <= 0 {
            if frame.width == 0 {
                layoutIfNeeded()
            }
            guard frame.height != 0 else {
                PrintLog("🌶🌶🌶： 计算label的width失败，因为其height为0")
                return 0
            }
            h = frame.height
        }
        
        if let attributedText = attributedText, let type = type, type == .attributeString{
            
            w = attributedText.getSize(width: w, height: h).width
        }else if let text = text {
            
            w = text.getLableWidth(font: font, height: h)
        }else {
            PrintLog("label没有text，或者attribute")
        }
        return w + 1
    }
    
    
    /// 限制最大汉字数
    ///
    /// - Parameters:
    ///   - maxCount: 最多显示多少个字
    /// - Returns: label的宽度
    func getLabelWidth(type: GetSizeType_ENUM? = nil, height: CGFloat? = nil, maxCount: Int64) -> CGFloat {
        
        var str = "哈"
        for _ in 0 ..< maxCount {
            str += "哈"
        }
        
        let text = self.text
        let attributedText = self.attributedText
        let textW = getLabelWidth(type: type, height: height)
        
        self.text = str
        let strW = getLabelWidth(height: height)
        
        self.text = text
        self.attributedText = attributedText
        return strW < textW ? strW : textW
    }
    
}

extension NSAttributedString {
    
    
    class func initAttributedString(str1: String, str1Color: UIColor,str1Font: UIFont, str2: String, str2Color: UIColor,str2Font: UIFont) -> NSMutableAttributedString {
        
        let aStr = NSMutableAttributedString.init(string: str1+str2)
        aStr.addAttributes([NSAttributedString.Key.font: str1Font,NSAttributedString.Key.foregroundColor: str1Color], range: NSRange(location: 0, length: str1.count))
        aStr.addAttributes([NSAttributedString.Key.font: str2Font,NSAttributedString.Key.foregroundColor: str2Color], range: NSRange(location: str1.count, length: str2.count))
        
        return aStr
    }
    
    /// 根据给定的范围计算宽高，如果计算宽度，则请把宽度设置为最大，计算高度则设置高度为最大
    ///
    /// - Parameters:
    ///   - width: 宽度的最大值
    ///   - height: 高度的最大值
    /// - Returns: 文本的实际size
    func getSize(width: CGFloat,height: CGFloat) -> CGSize {
        let attributed = self
        let ctFramesetter = CTFramesetterCreateWithAttributedString(attributed)
        let rect = CGRect.init(x: 0, y: 0, width: width, height: height)
        let framesetter = CTFramesetterCreateWithAttributedString(attributed)
        let size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange.init(location: 0, length: attributed.length), nil, rect.size, nil)
        return CGSize.init(width: size.width + 1, height: size.height + 1)
    }
    
    func getImageRunFrame(run: CTRun, lineOringinPoint: CGPoint, offsetX: CGFloat) -> CGRect {
        /// 计算位置 大小
        var runBounds = CGRect.zero
        var h: CGFloat = 0
        var w: CGFloat = 0
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        var asecnt: CGFloat = 0
        var descent: CGFloat = 0
        var leading: CGFloat = 0
        
        
        let cfRange = CFRange.init(location: 0, length: 0)
        
        w = CGFloat(CTRunGetTypographicBounds(run, cfRange, &asecnt, &descent, &leading))
        h = asecnt + descent + leading
        /// 获取具体的文字距离这行原点的距离 || 算尺寸用的
        x = offsetX + lineOringinPoint.x
        /// y
        y = lineOringinPoint.y - descent
        runBounds = CGRect.init(x: x, y: y, width: w, height: h)
        return runBounds
    }
    
}

// MARK: - get String height
extension String {
    func getLableHeigh(font:UIFont,width:CGFloat) -> CGFloat {
        
        let size = CGSize.init(width: width, height:  CGFloat(MAXFLOAT))
        
        let dic = [NSAttributedString.Key.font:font] // swift 3.0
        
        let strSize = self.boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: dic, context:nil).size
        
        return ceil(strSize.height) + 1
    }
    ///获取字符串的宽度
    func getLableWidth(font:UIFont,height:CGFloat) -> CGFloat {
        
        let size = CGSize.init(width: CGFloat(MAXFLOAT), height: height)
        
        
        let dic = [NSAttributedString.Key.font:font] // swift 4.0
        
        let cString = self.cString(using: String.Encoding.utf8)
        let str = String.init(cString: cString!, encoding: String.Encoding.utf8)
        let strSize = str?.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic, context:nil).size
        return strSize?.width ?? 0
    }
}
