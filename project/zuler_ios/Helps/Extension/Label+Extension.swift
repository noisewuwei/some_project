//
//  Label+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import Foundation
import UIKit
//import Kingfisher

extension UILabel {
    
    class func createColorLabel(startStr : String,midStr : String,endStr : String,startColor : UIColor,midColor : UIColor,endColor : UIColor,fontSize: CGFloat,isWeight: Bool = false,numberOfLines: Int = 1,alignment: NSTextAlignment = NSTextAlignment.left) -> UILabel {
        let label = UILabel()
        let completeStr = NSMutableAttributedString()
        let startLabelStr = NSAttributedString(string: startStr, attributes: [NSAttributedString.Key.foregroundColor : startColor])
        let midLabelStr = NSAttributedString(string: midStr, attributes: [NSAttributedString.Key.foregroundColor :midColor])
        let endLabelStr = NSAttributedString(string: endStr, attributes: [NSAttributedString.Key.foregroundColor : endColor])
        completeStr.append(startLabelStr)
        completeStr.append(midLabelStr)
        completeStr.append(endLabelStr)
        label.attributedText = completeStr
        if isWeight {
            label.font = UIFont.systemFont(ofSize: fontSize)
        } else {
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
        return label
    }
    class func createLabel(text : NSAttributedString) -> UILabel {
        let label = UILabel()
        label.attributedText = text
        return label
    }
    
    class func createLabel(text: String,
                           fontSize: CGFloat,
                           color: UIColor,
                           bgColor: UIColor = UIColor.clear,
                           alignment: NSTextAlignment = NSTextAlignment.left,
                           isWeight: Bool = false,
                           cornerRadius: CGFloat = 0.0,
                           borderColor: UIColor = UIColor.clear,
                           borderWidth: CGFloat = 1,
                           numberOfLines: Int = 1
        
        ) -> UILabel {
        let label = UILabel()
        if isWeight {
            label.font = UIFont.systemFont(ofSize: fontSize)
        } else {
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
        label.textColor = color
        label.text = text
        label.backgroundColor = bgColor
        label.layer.cornerRadius = cornerRadius
        label.layer.masksToBounds = true
        label.layer.borderColor = borderColor.cgColor
        label.layer.borderWidth = borderWidth
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        
        return label
    }
    class func createLabelWithName(text: String,
                           name: String,
                           fontSize: CGFloat,
                           color: UIColor,
                           bgColor: UIColor = UIColor.clear,
                           alignment: NSTextAlignment = NSTextAlignment.left,
                           isWeight: Bool = false,
                           cornerRadius: CGFloat = 0.0,
                           borderColor: UIColor = UIColor.clear,
                           borderWidth: CGFloat = 1,
                           numberOfLines: Int = 1
        
        ) -> UILabel {
        let label = UILabel()
        let fontSizeWidth = fontSize*2
        
        if isWeight {
            label.font = UIFont.init(name: name, size: fontSizeWidth)
//            label.font = UIFont.NBFont(size: fontSize)
        } else {
            label.font = UIFont.init(name: name, size: fontSizeWidth)
//            label.font = UIFont.NFont(size: fontSize)
        }
        label.textColor = color
        label.text = text
        label.backgroundColor = bgColor
        label.layer.cornerRadius = cornerRadius
        label.layer.masksToBounds = true
        label.layer.borderColor = borderColor.cgColor
        label.layer.borderWidth = borderWidth
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        
        return label
    }
    //MARK: 设置某个圆角
    func configSideRadius(rectCorners : UIRectCorner, size: CGSize, rect: CGRect) {
        
        let maskPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: rectCorners, cornerRadii: size)
        let maskLayer = CAShapeLayer.init()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
}


extension UILabel {
    
    //太耗时
    func attributeColorStr(_ fullStr:String,
                           color cArr:Array<String>,
                           sub strArr:Array<String>,
                           with font:UIFont,
                           with align:String
        ){
        
        var atts:String = ""
        for i in 0..<strArr.count {
            let s = strArr[i]
            let colorStr = cArr[i]
            atts.append("<font color=" + colorStr + ">" + s + "</font>")
        }
        
        let htmlStr = String.init(format: "<html><body style=\"text-align:%@;font-size:%fpx;font-family:'-apple-system', '%@'\">%@</body></html>", align,font.pointSize,font.fontName,atts)
        DispatchQueue.global().async {
            let htmlData = htmlStr.data(using: String.Encoding.unicode)
            DispatchQueue.main.async {
                var arr : NSAttributedString?
                arr = try? NSAttributedString.init(data: htmlData!, options:[.documentType: NSAttributedString.DocumentType.html,
                                                                             .characterEncoding:  String.Encoding.utf8.rawValue], documentAttributes: nil)
                self.attributedText = arr
            }
        }
    }

    
}


//==========================UILabel 协议===============
protocol UILabelTextColor {
    
    /// MARK: - for  +/-
    func textColorForNum() -> Void
}

extension UILabel:UILabelTextColor {
    
    class  func initLab(_ font: CGFloat,
                        txtalign align: NSTextAlignment?,
                        txtColor tcolor: String?,
                        bgColor bColor: String?,
                        txtStr txt:String?
        
        ) -> UILabel {
        
        let l = UILabel()
        
        l.font = UIFont.systemFont(ofSize: font)
        if let _ = align {
            
            l.textAlignment = align!
        }else{
            l.textAlignment = .left
        }
        
        if let _ = tcolor {
            
            l.textColor = UIColor.hexColor(tcolor!)
        }else{
            l.textColor = UIColor.hex_333333
        }
        
        if let _ = bColor {
            
            l.backgroundColor = UIColor.hexColor(bColor!)
        }else{
            l.backgroundColor = UIColor.hex_FFFFFF
        }
        
        if let _ = txt {
            
            l.text = txt
        }
        
        return l
    }
    
    
    class  func initBLab(_ font: CGFloat,
                          txtalign align: NSTextAlignment?,
                          txtColor tcolor: String?,
                          bgColor bColor: String?,
                          txtStr txt:String?
        
        ) -> UILabel {
        
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: font)
        if let _ = align {
            
            l.textAlignment = align!
        }else{
            l.textAlignment = .left
        }
        
        if let _ = tcolor {
            
            l.textColor = UIColor.hexColor(tcolor!)
        }else{
            l.textColor = UIColor.hex_333333
        }
        
        if let _ = bColor {
            
            l.backgroundColor = UIColor.hexColor(bColor!)
        }else{
            l.backgroundColor = UIColor.hex_FFFFFF
        }
        
        if let _ = txt {
            
            l.text = txt
        }
        
        return l
    }
    
    /// MARK: - for  +/-
    func textColorForNum() {
        
        guard let _ = self.text else { return  }
        
        if (self.text!.hasPrefix("-")) {
            self.textColor = UIColor.hexColor("#16c114")
        }else {
            if self.text == "0" || self.text == "-" {
                
                self.textColor = UIColor.black
            }else {
                
                self.textColor = UIColor.hexColor("#f89013")
                self.text = "+\(self.text!)"
            }
            
        }
    }
}



