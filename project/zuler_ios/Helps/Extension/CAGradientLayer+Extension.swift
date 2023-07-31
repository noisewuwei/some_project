//
//  CAGradientLayer+Extension.swift
//  MeiRiDuo
//
//  Created by 每日多 on 2019/7/23.
//  Copyright © 2019 HyBoard. All rights reserved.
//

import UIKit


extension CAGradientLayer {
    //    渐变色
    class func gradientRampR(_ startColor:UIColor,endColor:UIColor,isCrosswise:Bool = true) -> CAGradientLayer{
        
        //定义渐变的颜色（从黄色渐变到橙色）
        let topColor = startColor
        let buttomColor = endColor
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0, 1.0]
        //创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        //设置渲染的起始结束位置（横向渐变）
        if isCrosswise {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }else{
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//            //            方向为默认的自上而下
        }
        
        return gradientLayer
    }

}
