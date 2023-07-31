//
//  View+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import UIKit

extension UIView {
    
    func safeArea() -> UIEdgeInsets {
        
        if #available(iOS 11.0, *) {
            
            let insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
            
            if insets.top == 0{
                //非类型的机器，为了计算方便已statusbar为safearea
                return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
            }
            
            //PrintLog(insets)
            //UIEdgeInsets(top: 44.0, left: 0.0, bottom: 34.0, right: 0.0) x normal情况下是这个
            return insets
        } else {
            // Fallback on earlier versions
            //非x类型的机器，为了计算方便已statusbar为safearea
            return UIEdgeInsets.init(top: StatusBarHeight, left: 0, bottom: 0, right: 0)
        }
    }
}

/// 阴影所在方向
enum YSShadowPathSide {
    case shadowPathTop //上
    case shadowPathBoom //下
    case shadowPathLeft //左
    case shadowpathRight //右
    case shadowpathAllSide //四周
}
extension UIView {
    /// 给view添加阴影
    ///
    /// - Parameters:
    ///   - shadowColor: 阴影色值
    ///   - shadowOpacity: 不透明度
    ///   - shadowRadius: 阴影半径
    ///   - shadowPathWidth:
    ///   - pathWidth: 阴影长度
    ///   - padthSide: 阴影方向
    func setShadowPath(shadowColor:UIColor,
                       shadowOpacity:Float,
                       shadowRadius:CGFloat,
                       shadowPathWidth:CGFloat,
                       pathWidth:CGFloat,
                       padthSide:YSShadowPathSide) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize.zero
        
        var shadowRect:CGRect!
        let originX:CGFloat = 0.0
        let originY:CGFloat = 0.0
        let originW:CGFloat = pathWidth
        let originH:CGFloat = self.bounds.size.height
        
        if padthSide == .shadowPathBoom {
            shadowRect = CGRect(x: originX, y: originH - shadowPathWidth/2, width: originW, height: shadowPathWidth)
        }else if padthSide == .shadowPathTop {
            shadowRect = CGRect(x: originX, y: originY - shadowPathWidth/2, width: originW, height: shadowPathWidth)
        }else if padthSide == .shadowPathLeft {
            shadowRect = CGRect(x: originX - shadowPathWidth/2, y: originY, width: shadowPathWidth, height: originH)
        }else if padthSide == .shadowpathRight {
            shadowRect = CGRect(x: originW, y: originY, width: shadowPathWidth, height: originH)
        }else if padthSide == .shadowpathAllSide {
            shadowRect = CGRect(x: originX - shadowPathWidth/2, y: originY - shadowPathWidth/2, width: originW +  shadowPathWidth, height: originH + shadowPathWidth)
        }
        
        let path = UIBezierPath.init(rect: shadowRect)
        self.layer.shadowPath = path.cgPath
    }
}

extension UIView {
    /// 设置部分圆角
    /// - Parameters:
    ///   - corner: 要设置的位置
    ///   - cornerRadii: 圆角size
    func configRectCorner(corner: UIRectCorner, cornerRadii: CGSize) {
        
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        
        self.layer.mask = maskLayer
    }
    
    //添加边框
    func addBorderForView() {
        let besiz = UIBezierPath()
        besiz.move(to: CGPoint.init(x: 0, y: self.bounds.size.height + 1))
        besiz.addLine(to: CGPoint.init(x: self.bounds.size.width + 1, y: self.bounds.size.height + 1))
        besiz.addLine(to: CGPoint.init(x: self.bounds.size.width + 1, y: 0))
        let shape = CAShapeLayer()
        shape.strokeColor = UIColor.hexColor("#d6d6d6").cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.path = besiz.cgPath
        shape.lineWidth = 1
        self.layer.addSublayer(shape)
        
    }
    func setShadow(view:UIView,sColor:UIColor,offset:CGSize,
                   opacity:Float,radius:CGFloat) {
        //设置阴影颜色
        view.layer.shadowColor = sColor.cgColor
        //设置透明度
        view.layer.shadowOpacity = opacity
        //设置阴影半径
        view.layer.shadowRadius = radius
        //设置阴影偏移量
        view.layer.shadowOffset = offset
    }
    
    func addBorderWith(borderWidth: CGFloat = 2.0, borderColor: UIColor = UIColor.clear) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
    }
    
    /// 添加虚线圆
    func addDashedRoundBorder(fillColor:UIColor = UIColor.clear,
                              strokeColor:UIColor = UIColor.hex_FC5732,
                              lineWidth:CGFloat = 2.0,
                              ellipse:CGRect,
                              lineDashPattern:[NSNumber]){
        let line:CAShapeLayer = CAShapeLayer.init()
        let path:CGMutablePath = CGMutablePath.init()
        line.fillColor = fillColor.cgColor
        line.strokeColor = strokeColor.cgColor
        line.lineWidth = lineWidth
        path.addEllipse(in: ellipse)
        line.path = path
        line.lineDashPhase = 1.0
        line.lineDashPattern = lineDashPattern
        self.layer.addSublayer(line)
    }
    
    
    /// 添加渐变色
    func addGradientColor(colors: [CGColor],startPoint: CGPoint, endPoint: CGPoint,locations: [NSNumber] = [0,1]) {
        
        let gradient = CAGradientLayer.init()
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colors
        gradient.locations = locations
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    ///创建渐变图层
    class func createGradientLayer(colors: [CGColor],startPoint: CGPoint, endPoint: CGPoint,bounds: CGRect) -> CAGradientLayer {
        
        let gradient = CAGradientLayer.init()
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.colors = colors
        gradient.frame = bounds
        return gradient
    }
}


extension UIView {
    
    // MARK: - 常用位置属性
    public var left:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    
    public var top:CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(newTop) {
            var frame = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }

        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }

    public var height:CGFloat {
        get {
            return self.frame.size.height
        }

        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    
    public var right:CGFloat {
        get {
            return self.left + self.width
        }
    }
    
    public var bottom:CGFloat {
        get {
            return self.top + self.height
        }
    }
    
    public var centerX:CGFloat {
        get {
            return self.center.x
        }

        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }

    public var centerY:CGFloat {
        get {
            return self.center.y
        }

        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
    
}


extension UIView {
    //添加4个不同大小的圆角  不规则圆角
    func addIrregularCorner(cornerRadii:ViewCornerRadii = ViewCornerRadii(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)){
       let path = createPathWithRoundedRect(bounds: self.bounds, cornerRadii:cornerRadii)
       let shapLayer = CAShapeLayer()
       shapLayer.frame = self.bounds
       shapLayer.path = path
       self.layer.mask = shapLayer
    }
    //各圆角大小
    struct ViewCornerRadii {
        var topLeft :CGFloat = 0
        var topRight :CGFloat = 0
        var bottomLeft :CGFloat = 0
        var bottomRight :CGFloat = 0
    }
    //切圆角函数绘制线条
    fileprivate func createPathWithRoundedRect( bounds:CGRect,cornerRadii:ViewCornerRadii) -> CGPath
    {
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
