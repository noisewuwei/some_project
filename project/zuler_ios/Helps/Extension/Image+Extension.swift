//
//  Image+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 返回UIImage
    class func imgWithName(_ name:String) -> UIImage? {
        
        let img = UIImage.init(named: name)
        guard let _ = img else {
            
            return UIImage.init(named: "default")
        }
        return img
    }
    /// 返回UIImage
//    class func imgWithUrl(_ url:String) -> UIImage? {
//        
//        let url = URL(string: url)
//        let data = try! Data(contentsOf: url!)
//        let newImage = UIImage(data: data)
//        return newImage
//    }
        // MARK: - 颜色返回图片
    /// 颜色返回图片
    class func imageWithColor(_ color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    //重设图片大小
    func reSizeImage(reSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        
        let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return reSizeImage
        
    }
    //等比例缩放
    func scaleImage(scaleSize: CGFloat) -> UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        
        return reSizeImage(reSize: reSize)
    }
    // 更给图片的颜色
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage {
        
        let drawRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        color.setFill()
        UIRectFill(drawRect)
        
        draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    /** 截取部分图片并生成新图片 */
    func getImageCorpped(_ reRect: CGRect) -> UIImage {
        if CGFloat(reRect.size.width) > 0.0 && CGFloat(reRect.size.height) > 0.0 {
            let cgImageCorpped = self.cgImage?.cropping(to: reRect)
            let imageCorpped = UIImage(cgImage: cgImageCorpped!)
            
            return imageCorpped
        }
        return self
    }
    
}


extension UIImage {
    
    func imageViewDrawRectWithRounderCorner(_ radius : CGFloat, _ sizeToFit: CGSize) -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: sizeToFit.width, height: sizeToFit.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let bezierPath = UIBezierPath.init(roundedRect: rect, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize.init(width: radius, height: radius))
        UIGraphicsGetCurrentContext()?.addPath(bezierPath.cgPath)
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        context.clip()
        self.draw(in: rect)
        context.drawPath(using: .fillStroke)
        context.fill(rect)
        let outPut = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return outPut ?? UIImage()
        
    }
    // 切图片  吧图片变为圆形的
    func cutCircleImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        // 获取上下文
        let ctr = UIGraphicsGetCurrentContext()
        // 设置圆形
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        ctr?.addEllipse(in: rect)
        // 裁剪
        ctr?.clip()
        // 将图片画上去
        draw(in: rect)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}




