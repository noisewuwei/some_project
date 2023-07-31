//
//  UIButton+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/9/18.
//  Copyright © 2018年 Jason. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    class func createCustomButton (style : UIButton.ButtonType = UIButton.ButtonType.custom,
                                   title : String ,
                                   bgColor : UIColor = UIColor.clear,
                                   titleColor : UIColor ,
                                   titleSize : CGFloat ,
                                   corner : Int = 0,
                                   isWeight : Bool = true,
                                   borderWidth : CGFloat = 0.0,
                                   borderColor : UIColor = .clear
        
        ) -> UIButton {
        let btn = UIButton.init(type: style)
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = bgColor
        if isWeight {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: titleSize)
        }else {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: titleSize)
        }
        btn.setTitleColor(titleColor, for: .normal)
        
        btn.layer.cornerRadius = CGFloat(corner)
        btn.layer.masksToBounds = true
        btn.layer.borderWidth = borderWidth
        btn.layer.borderColor = borderColor.cgColor
        
        
        return btn
    }
    class func createCustomButton(normarlImg: String, selectedImg : String) -> UIButton {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        
        btn.setImage(UIImage.imgWithName(normarlImg), for: UIControl.State.normal)
        btn.setImage(UIImage.imgWithName(selectedImg), for: UIControl.State.selected)
        
        return btn
    }
    
//    class func btnType(model:Base_eventModel,top : CGFloat ,left : CGFloat) -> UIButton{
//        let title:String = model.action_data?.title ?? ""
//        let icon:String = model.action_data?.icon ?? ""
//        let size:String = model.action_data?.size ?? ""
//        let className:String = model.action_data?.class_name ?? ""
//        let btn = UIButton.init(type: UIButton.ButtonType.custom)
////        let iconView = UIImageView.creatWith("")
////        let titleLabel = UILabel.createLabel(text: , fontSize: <#T##CGFloat#>, color: <#T##UIColor#>)
//
//        
//        btn.backgroundColor = UIColor.hex_FFFFFF
//        if size == "min" {
//            btn.titleLabel?.font = UIFont.NFont(size: 44.WIDTH())
//            btn.frame = CGRect(x:left, y:top, width:147.WIDTH(), height:48.HEIGHT())
//            btn.layer.cornerRadius = 24.WIDTH()
//        }else{
//            btn.titleLabel?.font = UIFont.NFont(size: 52.WIDTH())
//            btn.frame = CGRect(x:left, y:top, width:168.WIDTH(), height:56.HEIGHT())
//            btn.layer.cornerRadius = 28.WIDTH()
//        }
////        btn.snp.makeConstraints { (make) in
////            make.right.equalToSuperview().offset(-26.WIDTH())
////            make.top.equalToSuperview().offset(42.WIDTH())
////        }
//        if icon != "" {
////            带图片的按钮
////            iconView.setimage(urlStr: icon)
//            btn.setImage(UIImage.imgWithUrl(icon), for: .normal)
//            btn.setTitle(title, for: .normal)
//            
//        }else{
//            btn.setTitle(title, for: .normal)
//            
//            switch className {
//            case "button-orange":
//                print("常规按钮")
//                btn.backgroundColor = UIColor.hex_FC5732
//                btn.setTitleColor(UIColor.hex_FFFFFF, for: .normal)
//            case "button-yellow":
//                print("黄色按钮")
//                btn.backgroundColor = UIColor.hex_FFC100
//                btn.setTitleColor(UIColor.hex_FFFFFF, for: .normal)
//            case "button-green":
//                print("绿色按钮")
//                btn.backgroundColor = UIColor.hex_5FB878
//                btn.setTitleColor(UIColor.hex_FFFFFF, for: .normal)
//            case "button-gray":
//                print("灰色按钮")
//                btn.backgroundColor = UIColor.hex_D3D3D3
//                btn.setTitleColor(UIColor.hex_FFFFFF, for: .normal)
//            case "button-orange-border":
//                print("常规边框")
//                btn.layer.borderWidth = 2.WIDTH()
//                btn.setTitleColor(UIColor.hex_FC5732, for: .normal)
//                btn.layer.borderColor = UIColor.hex_FC5732.cgColor
//            case "button-yellow-border":
//                print("黄色边框")
//                btn.layer.borderWidth = 2.WIDTH()
//                btn.setTitleColor(UIColor.hex_FFC100, for: .normal)
//                btn.layer.borderColor = UIColor.hex_FFC100.cgColor
//            case "button-green-border":
//                print("绿色边框")
//                btn.layer.borderWidth = 2.WIDTH()
//                btn.setTitleColor(UIColor.hex_5FB878, for: .normal)
//                btn.layer.borderColor = UIColor.hex_5FB878.cgColor
//            case "button-gray-border":
//                print("灰色边框")
//                btn.layer.borderWidth = 2.WIDTH()
//                btn.setTitleColor(UIColor.hex_939393, for: .normal)
//                btn.layer.borderColor = UIColor.hex_939393.cgColor
//            default:
//                print("")
//            }
//        }
//        return btn
//    }
    func addTargetTo(target : Any?, action: Selector) {        
        self.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
    }
    
}

extension UIButton {
    
    @objc func set(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State){
        self.imageView?.contentMode = .center
        self.setImage(anImage, for: state)
        
        self.titleLabel?.contentMode = .center
        
        
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        
        
        self.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode,
                                             spacing: CGFloat) {
        let imageSize = self.currentImage?.size ?? CGSize.zero
        //            self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        let imageWidth = Double((self.currentImage?.size.width)! + spacing)
        
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (position){
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing),
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height)*0.5 + spacing,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height)*0.5 ,
                                       left: 0, bottom: 0, right: -(titleSize.width + imageSize.width)*0.5)
            
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: CGFloat(-imageWidth), bottom: 0, right: CGFloat(imageWidth))
            imageInsets = UIEdgeInsets(top: 0, left: titleSize.width+spacing, bottom: 0,
                                       right: -titleSize.width-spacing)
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}

// MARK: - 下面是 button 的 重复点击的 code
//struct RuntimeKey {
//    static let zm_eventUnavailable = UnsafeRawPointer.init(bitPattern: "zm_eventUnavailable".hashValue)!
//    static let eventInterval = 0.7 // 按钮重复点击间隔
//}
//
//
//protocol SelfAware: class {
//    static func awake()
//}
//
//class NothingToSeeHere {
//
//    static func harmlessFunction() {
//        let typeCount = Int(objc_getClassList(nil, 0))
//        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
//        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
//        objc_getClassList(autoreleasingTypes, Int32(typeCount))
//        for index in 0 ..< typeCount {
//            (types[index] as? SelfAware.Type)?.awake()
//        }
//        types.deallocate(capacity: typeCount)
//    }
//}
//extension UIApplication {
//    private static let runOnce: Void = {
//        NothingToSeeHere.harmlessFunction()
//    }()
//    override open var next: UIResponder? {
//        // Called before applicationDidFinishLaunching
//        UIApplication.runOnce
//        return super.next
//    }
//}
//
//extension UIButton: SelfAware {
//    static func awake() {
//        UIButton.classInit()
//    }
//
//    static func classInit() {
//        swizzleMethod
//    }
//
//    private static let swizzleMethod: Void = {
//        let normalSelector = #selector(UIButton.sendAction(_:to:for:))
//        let swizzledSelector = #selector(swizzled_senderAction(_:to:event:))
//        let originalMethod = class_getInstanceMethod(UIButton.self, normalSelector)
//        let swizzledMethod = class_getInstanceMethod(UIButton.self, swizzledSelector)
//
//        guard (originalMethod != nil && swizzledMethod != nil) else {
//            return
//        }
//
//        let isAdd = class_addMethod(UIButton.self, normalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
//
//        if isAdd {
//            class_replaceMethod(UIButton.self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
//        } else {
//            method_exchangeImplementations(originalMethod!, swizzledMethod!)
//
//        }
//
//    }()
//
//    @objc private func swizzled_senderAction(_ action: Selector, to: Any?, event: UIEvent?) {
////        print("警告      我是按钮被点击了")
//        if eventUnavailable == nil {
//            eventUnavailable = false
//        }
//        if !eventUnavailable! {
//            self.eventUnavailable = true
//            swizzled_senderAction(action, to: to, event: event)
//
//            let eventInterval = Defaults[.isUserProfile] ? 0 : RuntimeKey.eventInterval
//            DispatchQueue.main.asyncAfter(deadline: .now() + eventInterval, execute: {
//                self.eventUnavailable = false
//            })
//        }
//    }
//
//    private var eventUnavailable: Bool? {
//        set{
//            objc_setAssociatedObject(self, RuntimeKey.zm_eventUnavailable, newValue, .OBJC_ASSOCIATION_ASSIGN)
//        }
//        get{
//            return objc_getAssociatedObject(self, RuntimeKey.zm_eventUnavailable) as? Bool
//        }
//    }
//
//
//}

