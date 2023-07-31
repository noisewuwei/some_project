//
//  ImageView+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /// BezierPath 圆角设置
    func roundCorners(_ corners: UIRectCorner = .allCorners, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UIImageView {
    //添加4个不同大小的圆角
    func addCorner(cornerRadii: CornerRadii){
       let path = createPathWithRoundedRect(bounds: self.bounds, cornerRadii:cornerRadii)
       let shapLayer = CAShapeLayer()
       shapLayer.frame = self.bounds
       shapLayer.path = path
       self.layer.mask = shapLayer
    }
    //各圆角大小
    struct CornerRadii {
        var topLeft :CGFloat = 0
        var topRight :CGFloat = 0
        var bottomLeft :CGFloat = 0
        var bottomRight :CGFloat = 0
    }
    
    //切圆角函数绘制线条
    func createPathWithRoundedRect ( bounds:CGRect,cornerRadii:CornerRadii) -> CGPath {
        let minX = bounds.minX
        let minY = bounds.minY
        let maxX = bounds.maxX
        let maxY = bounds.maxY
        
        //获取四个圆心
        let topLeftCenterX = minX +  cornerRadii.topLeft
        let topLeftCenterY = minY + cornerRadii.topLeft
         
        let topRightCenterX = maxX - cornerRadii.topRight
        let topRightCenterY = minY + cornerRadii.topRight
        
        let bottomLeftCenterX = minX +  cornerRadii.bottomLeft
        let bottomLeftCenterY = maxY - cornerRadii.bottomLeft
         
        let bottomRightCenterX = maxX -  cornerRadii.bottomRight
        let bottomRightCenterY = maxY - cornerRadii.bottomRight
        
        //虽然顺时针参数是YES，在iOS中的UIView中，这里实际是逆时针
        let path :CGMutablePath = CGMutablePath();
         //顶 左
        path.addArc(center: CGPoint(x: topLeftCenterX, y: topLeftCenterY), radius: cornerRadii.topLeft, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 3 / 2, clockwise: false)
        //顶右
        path.addArc(center: CGPoint(x: topRightCenterX, y: topRightCenterY), radius: cornerRadii.topRight, startAngle: CGFloat.pi * 3 / 2, endAngle: 0, clockwise: false)
        //底右
        path.addArc(center: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY), radius: cornerRadii.bottomRight, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: false)
        //底左
        path.addArc(center: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY), radius: cornerRadii.bottomLeft, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: false)
        path.closeSubpath();
         return path;
    }
    
}

extension UIImageView {
//    合成两张图片
//    func composeImageWith(images:[UIImage],
//                          imageRect: [CGRect]) -> UIImage {
//        //以bgImage的图大小为底图
//        let imageRef = self.image?.cgImage
//        let w: CGFloat = CGFloat((imageRef?.width)!)
//        let h: CGFloat = CGFloat((imageRef?.height)!)
//        //以1.png的图大小为画布创建上下文
//        UIGraphicsBeginImageContext(CGSize(width: w, height: h))
//        self.image?.draw(in: CGRect(x: 0, y: 0, width: w, height: h))
//        //先把1.png 画到上下文中
//        for i in 0..<images.count {
//            let dr = CGRect(x: imageRect[i].origin.x,
//                            y: imageRect[i].origin.y,
//                            width: imageRect[i].size.width,
//                            height:imageRect[i].size.height)
//            images[i].draw(in: dr)
//        }
//        //再把小图放在上下文中
//        let resultImg: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
//        //从当前上下文中获得最终图片
//        UIGraphicsEndImageContext()
//        return resultImg!
//    }
//     func kfishdownload(imageview:UIImageView,urlstr:String,placeholdimagename:String){
//            imageview.kf.setImage(with:ImageResource(downloadURL:URL.init(string:urlstr)!))
//            //或者
//        let url=URL.init(string:urlstr)
//        imageview.kf.setImage(with: url, placeholder: UIImage.init(named: placeholdimagename))
//        }
     
    
    
}

