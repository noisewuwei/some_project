//
//  PublicMethods.swift
//  zuler_ios
//
//  Created by Admin on 2021/8/17.
//

import Foundation

class PublicMethods: NSObject {
    
    static let methods = PublicMethods()
    
    //view 转图片
    func getImageFromView(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    //获取文字的宽度
    func getLabWidth(_ title: String, font: UIFont?) -> CGFloat {
        let priceStr = title
        let attributes = [NSAttributedString.Key.font: font]
        let size = priceStr.size(withAttributes: attributes as [NSAttributedString.Key: Any])
        return size.width
    }
    
    //获取文字的高度
    func getLabHeigh(labelStr: String, font: UIFont, width: CGFloat) -> CGFloat {
        let statusLabelText: String = labelStr
        let size = CGSize(width: width, height: 900)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key: Any], context: nil).size
        return strSize.height
    }
    
    //验证码倒计时
    func countDown(_ timeOut: Int, btn: UIButton) {
        // 倒计时时间
        var timeout = timeOut
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        let _timer = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
        _timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
        // 每秒执行
        _timer.setEventHandler(handler: { () -> Void in
            if timeout <= 0 { // 倒计时结束，关闭
                _timer.cancel()
                DispatchQueue.main.async { () -> Void in
                    btn.setTitle("获取验证码", for: .normal)
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                    btn.setTitleColor(UIColor.hexColor("#DE733A"), for: .normal)
                    btn.isEnabled = true
                }
            } else { // 正在倒计时
                let seconds = timeout
                DispatchQueue.main.async { () -> Void in
                    let str = String(describing: seconds)
                    btn.setTitle(str + "秒后重新发送", for: .normal)
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                    btn.setTitleColor(UIColor.hexColor("#666666"), for: .normal)
                    btn.isEnabled = false
                }
                timeout -= 1
            }
        })
        _timer.resume()
    }
    
    //手机号码正则
    func isPhoneNumber(phoneNumber: String) -> Bool {
        if phoneNumber.count == 0 {
            return false
        }
        let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@", mobile)
        if regexMobile.evaluate(with: phoneNumber) == true {
            return true
        } else {
            return false
        }
    }
    
    //编码
    func base64Encoding(plainString:String)->String{
        let plainData = plainString.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    
    //解码
    func base64Decoding(encodedString:String)->String{
        let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return decodedString
    }

}
