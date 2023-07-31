//
//  String+Extension.swift
//  LaiZhuanPro
//
//  Created by HyBoard on 2018/10/31.
//  Copyright © 2018 Jason. All rights reserved.
//

import Foundation
import Kingfisher
import UIKit

extension String {

    // MARK: - 处理数据类型和字符串之间的关系

    /// 处理数据类型和字符串之间的关系
    static func abNormalString(_ id: Any) -> String {
        if let _ = id as? NSNull {
            return ""
        } else if let idd = id as? NSNumber {
            return idd.stringValue
        } else if let idd = id as? String {
            return idd
        } else {
            return ""
        }
    }


    /// 根据传入的字符串数组和对应的颜色数组 、align 返回NSAttributedString
    ///
    /// - Parameters:
    ///   - fullStr: <#fullStr description#>
    ///   - cArr: <#cArr description#>
    ///   - strArr: <#strArr description#>
    ///   - font: <#font description#>
    ///   - align: <#align description#>
    /// - Returns: <#return value description#>

    // FIXME: 这个在2.0 版本中废弃,

    static func attributeColorStr(_ fullStr: String, color cArr: [String], sub strArr: [String], with font: UIFont, with align: String) -> NSAttributedString {
        var atts: String = ""
        for i in 0..<strArr.count {
            let s = strArr[i]
            let colorStr = cArr[i]
            atts.append("<font color=" + colorStr + ">" + s + "</font>")
        }

        let htmlStr = String(format: "<html><body style=\"text-align:%@;font-size:%fpx;font-family:'-apple-system', '%@'\">%@</body></html>", align, font.pointSize, font.fontName, atts)
        var arr: NSAttributedString?
        let htmlData = htmlStr.data(using: String.Encoding.unicode)
        arr = try? NSAttributedString(data: htmlData!, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                 .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)

        return arr ?? NSAttributedString()
    }

    // #warning
    // FIXME: 这个在2.0 版本中废弃,

    static func attributeColorStrWithLineSpc(_ fullStr: String, color cArr: [String], sub strArr: [String], with font: UIFont, with align: String, withlineSpc lineSpc: String) -> NSAttributedString {
        var atts: String = ""
        for i in 0..<strArr.count {
            let s = strArr[i]
            let colorStr = cArr[i]
            atts.append("<font color=" + colorStr + ">" + s + "</font>")
        }

        let htmlStr = String(format: "<html><body style=\"text-align:%@;font-size:%fpx;font-family:'-apple-system', '%@';line-height:%@px\">%@</body></html>", align, font.pointSize, font.fontName, lineSpc, atts)

        let htmlData = htmlStr.data(using: String.Encoding.unicode)

        do {
            let arr = try NSAttributedString(data: htmlData!, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                        .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return arr
        } catch {
            return NSAttributedString(string: fullStr)
        }
    }
}

// MARK: - 和 属性文本相关的

extension String {

    func attributeColorStrNoHtml(separatedBy: String, colors: [String], fontSize: [CGFloat]) -> NSAttributedString {
        let list = self.components(separatedBy: separatedBy)
        let result = NSMutableAttributedString(string: "")
        for (index, str) in list.enumerated() {
            let obj = NSMutableAttributedString(string: str)
            obj.addAttribute(.foregroundColor, value: UIColor.hexColor(colors[index]), range: NSRange(location: 0, length: str.count))
            obj.addAttribute(.font, value: UIFont.systemFont(ofSize: fontSize[index]), range: NSRange(location: 0, length: str.count))
            result.append(obj)
        }
        return result
    }

//    添加横线
    func transToAttributedString() -> NSAttributedString {
        let att = NSMutableAttributedString(string: self)
        att.addAttributes([NSAttributedString.Key.strikethroughStyle: 1], range: NSRange(location: 0, length: self.count))

        return att
    }
}


// MARK: - 打开 和 数字相关的

extension String {
    // 装换为 万 亿 为单位的
    func toTenThousand(_ isShot: Bool = false) -> String {
        guard let n = NumberFormatter().number(from: self) else {
            return ""
        }
        var str = ""
        var prefix = ""
        var tempN: Float = 0
        if "\(n)".hasPrefix("-") {
            prefix = "-"
            tempN = Float(n.floatValue*(-1))
            //                "\(n.floatValue*(-1))".toFloat()

        } else if "\(n)".hasPrefix("+") {
            prefix = "+"
            tempN = Float(n.floatValue*(+1))
        } else {
            tempN = Float(n)
        }

        if tempN >= 100000000 {
            if isShot {
                str = String(format: "%.0f", Float("\(tempN)".toFloat() / 100000000))
            } else {
                str = String(format: "%.2f", Float("\(tempN)".toFloat() / 100000000))
            }
            if str.hasSuffix(".00") {
                str = str.replacingOccurrences(of: ".00", with: "")
            }
            if str.hasSuffix("0"), str.contains(".") {
                str = String(format: "%.1f", str.toCGFloat())
            }
            str = str + "亿"
        } else if tempN >= 10000 {
            if isShot {
                str = String(format: "%.0f", Float("\(tempN)".toFloat() / 10000))
            } else {
                str = String(format: "%.2f", Float("\(tempN)".toFloat() / 10000))
            }

            if str.hasSuffix(".00") {
                str = str.replacingOccurrences(of: ".00", with: "")
            }
            if str.hasSuffix("0"), str.contains(".") {
                str = String(format: "%.1f", str.toCGFloat())
            }
            str = str + "万"
        } else {
            str = String(format: "%.0f", "\(tempN)".toFloat())
        }
        if str == "0" {
            prefix = ""
        }

        return prefix + str
    }

    // MARK: 添加千分位的函数实现

    func addMicrometerLevel() -> String {
        // 判断传入参数是否有值
        if self.count != 0 {
            /**
             创建两个变量
             integerPart : 传入参数的整数部分
             decimalPart : 传入参数的小数部分
             */
            var integerPart: String?
            var decimalPart = String()

            // 先将传入的参数整体赋值给整数部分
            integerPart = self
            // 然后再判断是否含有小数点(分割出整数和小数部分)
            if self.contains(".") {
                let segmentationArray = self.components(separatedBy: ".")
                integerPart = segmentationArray.first
                decimalPart = segmentationArray.last!
            }
            /**
             创建临时存放余数的可变数组
             */
            let remainderMutableArray = NSMutableArray(capacity: 0)
            // 创建一个临时存储商的变量
            var discussValue: Int32 = 0

            /**
             对传入参数的整数部分进行千分拆分
             */
            repeat {
                let tempValue = integerPart! as NSString
                // 获取商
                discussValue = tempValue.intValue / 1000
                // 获取余数
                let remainderValue = tempValue.intValue % 1000
                // 将余数一字符串的形式添加到可变数组里面
                let remainderStr = String(format: "%d", remainderValue)
                remainderMutableArray.insert(remainderStr, at: 0)
                // 将商重新复制
                integerPart = String(format: "%d", discussValue)
            } while discussValue > 0

            // 创建一个临时存储余数数组里的对象拼接起来的对象
            var tempString = String()

            // 根据传入参数的小数部分是否存在，是拼接“.” 还是不拼接""
            let lastKey = (decimalPart.count == 0 ? "" : ".")
            /**
             获取余数组里的余数
             */
            for i in 0..<remainderMutableArray.count {
                // 判断余数数组是否遍历到最后一位
                let param = (i != remainderMutableArray.count-1 ?"," : lastKey)
                tempString = tempString + String(format: "%@%@", remainderMutableArray[i] as! String, param)
            }
            //  清楚一些数据
            integerPart = nil
            remainderMutableArray.removeAllObjects()
            // 最后返回整数和小数的合并
            return tempString as String + decimalPart
        }
        return self
    }

    // MARK: 获取字符串的长度

    func length() -> Int {
        /**
         另一种方法：
         let tempStr = self as NSString
         return tempStr.length
         */
        return self.count
//        return self.characters.count
    }

    func toTenThousendString() -> String {
        var returnStr = ""
        let str = self.toInt()
        if str > 10000 {
            returnStr = "\(str / 10000)" + "万"
        } else {
            returnStr = self
        }
        return returnStr
    }

    /**
     *  转化为人民币的单位, 拼多多的拿过来的是以分为单位的..
     */
    func toRMB() -> String {
        var resultStr = ""
        let tempStr = String(format: "%.2f", self.toDoule())
        resultStr = tempStr

        if tempStr.hasSuffix(".00") {
            resultStr = tempStr.replacingOccurrences(of: ".00", with: "")
        }
        if resultStr.hasSuffix("0"), resultStr.contains(".") {
            resultStr = String(format: "%.1f", self.toDoule())
        }
        return resultStr
    }
}

extension String {
    /// 计算倒计时 返回 12 12 12 - 时分秒
    ///
    /// - Parameter complate: <#complate description#>
    func calculateCountDown(complate: (String, String, String) -> Void) {
        let formatter = NumberFormatter()
        let format = NSMutableString(string: "00")
        formatter.positiveFormat = format as String

        let countDownSecond = self.toInt()
        var hour = "", minutes = "", second = ""

        let hour1 = (countDownSecond / (60*60)).toString()
        hour = formatter.string(from: NSNumber(value: hour1.toDoule())) ?? ""
        let tempHour = Int(countDownSecond % (60*60))

        let minutes1 = (tempHour / 60).toString()
        minutes = formatter.string(from: NSNumber(value: minutes1.toDoule())) ?? ""
        let tempMinutes = Int(tempHour % 60)

        let second1 = (tempMinutes % 60).toString()
        second = formatter.string(from: NSNumber(value: second1.toDoule())) ?? ""

        complate(hour, minutes, second)
    }

    /**
     *  base64的转码转换为 img
     */
    func transtoImageWithBase64() -> UIImage {
        var base64Str = ""
        if self.contains(",") {
            base64Str = String(self.split(separator: ",").last ?? "")
        } else {
            base64Str = self
        }

        let imgDate = Data(base64Encoded: base64Str, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        let img = UIImage(data: imgDate ?? Data())

        return img ?? UIImage()
    }

    // MARK: 判断输入的字符串是否为数字，不含其它字符

    func isPurnInt(string: String) -> Bool {
        let scan = Scanner(string: string)
        var val: Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }

    // MARK: 字符串是否为空

    /**
     字符串是否为空
     @param str NSString 类型 和 子类
     @return  BOOL类型 true or false
     */
    func kStringIsEmpty(_ str: String) -> Bool {
        if str.isEmpty {
            return true
        }
        if str == nil {
            return true
        }
        if str.count < 1 {
            return true
        }
        if str == "(null)" {
            return true
        }
        if str == "null" {
            return true
        }
        return false
    }
    
    
    func isValidNickname() -> Bool {
        let pattern = "^[\\u4e00-\\u9fa5a-zA-Z0-9]{1,10}$"

        if NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self) {
            return true
        }
        return false
    }
}

// MARK: - 打开 和 网络相关的

extension String {
    func openWithHiddenUIWebView() {
        let wv = UIWebView()
        if self.isUrl() {
            let req = URLRequest(url: self.transToUrl())
            wv.loadRequest(req)
        } else {
//            PrintLog("不是链接")
        }
    }

    // 将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return encodeUrlString ?? ""
    }

    // 将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }

    func toMinutesString() -> String {
        var str = self
        if str.toInt() > 60 {
            let m = str.toInt() / 60
            let s = str.toInt() % 60
            str = "\(m):\(s)"
        }
        return str
    }

    /** 转换为 URL  */
    func transToUrl() -> URL {
        var url = URL(string: "https://www.mriduo.com/")
//        if self.isUrl() {
        if self != "", self.count > 0 {
            if self.isIncludeChineseIn() {
                url = URL(string: self.urlEncoded())!
            } else {
                guard let url2 = URL(string: self) else {
                    return url!
                }
                url = url2
            }
        }
//            }
        return url!
    }

    /** 是不是 Url */
    func isUrl() -> Bool {
        let url = self.replacingOccurrences(of: " ", with: "")
        if url.hasPrefix("http://") || url.hasPrefix("https://") {
            return true
        }
        return false
    }

    func isIncludeChineseIn() -> Bool {
        for (_, value) in self.enumerated() {
            if value >= "\u{4E00}", value <= "\u{9FA5}" {
                return true
            }
        }
        return false
    }

    func mySubString(to index: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }

    func mySubString(from index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }

    func mySubString(start index: Int, end index1: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: index)
        let end = self.index(self.startIndex, offsetBy: index1)
        let range = Range<String.Index>(uncheckedBounds: (lower: start, upper: end))
        return String(self[range])
    }

//    文字竖排
    func VerticalString() -> String {
        var str: String = self
        let count: Int = str.length()
        for idx in 1...count-1 {
            let start = str.index(str.startIndex, offsetBy: idx*2-1)
            str.insert(contentsOf: "\n", at: start)
        }
        return str
    }
}

// MARK: - 打开 和 图片相关的

extension String {
    func isPicResource() -> Bool {
        if self == "png" || self == "jpg" || self == "jpeg" || self == "gif" {
            return true
        }
        return false
    }

    /**
     *  装换为图片
     */
    func transToImage(_ complate: ((_ img: UIImage) -> Void)? = nil) -> UIImage {
        var img = UIImage()

        if self.isUrl() {
            DispatchQueue.main.async {
                let imgData = try? Data(contentsOf: URL(string: self.urlEncoded())!)
                img = UIImage(data: imgData!)!
                if img.size.width > UIScreen.width {
                    let reSizeHeight = SRNW*img.size.height / img.size.width
                    let toImg = img.reSizeImage(reSize: CGSize(width: SRNW, height: reSizeHeight))
                    complate?(toImg)
                } else {
                    complate?(img)
                }
            }
        }
        return img
    }
}

// MARK: - 时间相关的

extension String {
    /**
     *  将某个时间戳 转化成 时间
     */
    func transformTimestamptoDate(_ format: String = "YYYY-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.dateFormat = format

        let timeZone = NSTimeZone(name: "Asia/Beijing")
        if let aZone = timeZone {
            formatter.timeZone = aZone as TimeZone
        }
        let confromTimesp = Date(timeIntervalSince1970: TimeInterval(self.toDoule()))

        let confromTimespStr = formatter.string(from: confromTimesp)

        return confromTimespStr
    }

    // MARK: 时间转换为 时间戳

    /**
     *  时间转换为 时间戳
     */
    func transStringToTimeStamp(_ datefmatter: String = "YYYY-MM-dd HH:mm:ss") -> String {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = datefmatter
        let date = dfmatter.date(from: self)
        guard let _ = date else {
            return Date().currentTimeStamp.toString()
        }

        let dateStamp: TimeInterval = date!.timeIntervalSince1970

        let dateSt = Int(dateStamp)
        PrintLog(dateSt)
        return String(dateSt)
    }

    /// 格式化数字
    /// - Returns: 以万计数，小于1万时直接显示；大于1万千位为0时只取万位，否则保留一位小数，百位以后全部舍去
    func formatNumer() -> String {
        let result = toDoule()
        var num = "\(result)"
        let tenThousand = 10000.0
        let hundredMillion = 100000000.0
        if result < tenThousand {
            num = String(format: "%.f", result)
        } else if result >= tenThousand, result < hundredMillion {
            let tempNum = result / tenThousand
            let roundup = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 1, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
            let decimalNum = NSDecimalNumber(value: tempNum)
            let yy = decimalNum.rounding(accordingToBehavior: roundup)
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 1
            num = "\(formatter.string(from: yy) ?? "0")万"

        } else {
            let tempNum = result / hundredMillion
            let roundup = NSDecimalNumberHandler(roundingMode: NSDecimalNumber.RoundingMode.down, scale: 1, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: true)
            let decimalNum = NSDecimalNumber(value: tempNum)
            let yy = decimalNum.rounding(accordingToBehavior: roundup)

            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 1
            formatter.maximumFractionDigits = 1
            num = "\(formatter.string(from: yy) ?? "0")亿"
        }
        return num
    }

    /// 格式化时间
    /// - Returns: <#description#>
    func formatTime() -> String {
        var timeStamp = toDoule()
        // 获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        // 时间戳为毫秒级要 ／ 1000， 秒就不用除1000，参数带没带000
        if self.count > 10 {
            timeStamp = (timeStamp / 1000)
        }
        let timeSta = TimeInterval(timeStamp)
        // 时间差
        let reduceTime: TimeInterval = currentTime-timeSta
        // 时间差小于60秒
        if reduceTime < 60 {
            return "刚刚路过"
        }
        // 时间差大于一分钟小于60分钟内
        let mins = Int(reduceTime / 60)
        if mins < 60 {
            return "\(mins)分钟前路过"
        }
        let hours = Int(reduceTime / 3600)
        if hours < 24 {
            return "\(hours)小时前"
        }
        if hours > 24, hours < 48 {
            return "昨天"
        }

        let date = NSDate(timeIntervalSince1970: timeSta)
        let currentDate = NSDate(timeIntervalSince1970: currentTime)
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy"
        let dateYear = dfmatter.string(from: date as Date)
        let currentYear = dfmatter.string(from: currentDate as Date)
        if dateYear == currentYear {
            dfmatter.dateFormat = "MM-dd"
            return dfmatter.string(from: date as Date) + ""
        } else {
            dfmatter.dateFormat = "yyyy-MM-dd"
            return dfmatter.string(from: date as Date) + ""
        }
    }
}

// MARK: - 数字相关的

extension String {
    /// 给部分字符串添加颜色
    ///
    /// - Parameters:
    ///   - targetString: 待添加颜色的字符串
    ///   - targetColor: 待添加的颜色
    ///   - totalString: 总字符串
    /// - Returns: NSMutableAttributedString
    func addOtherTextColorToString(_ targetString: String?, _ targetColor: UIColor?) -> NSMutableAttributedString? {
        let attributeString = NSMutableAttributedString(string: self)
        guard let ts = targetString, let tc = targetColor else { return attributeString }
        let range = attributeString.mutableString.range(of: ts)
        attributeString.addAttributes([NSAttributedString.Key.foregroundColor: tc], range: range)
        return attributeString
    }
}

extension String {
    /// 根据字符串的 font size 求字符串的高度
    ///
    /// - Parameters:
    ///   - font: <#font description#>
    ///   - size: <#size description#>
    /// - Returns: <#return value description#>
    func getStringHeightWithFont(_ font: UIFont, size: CGSize) -> CGFloat {
        if self.isEmpty {
            return 0.0
        }

        let sttributes = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        if size.equalTo(CGSize.zero) {
            let stringRect = self.size(withAttributes: sttributes as? [NSAttributedString.Key: AnyObject])
            return ceil(stringRect.height)
        } else {
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let stringRect = self.boundingRect(with: size, options: option, attributes: sttributes as? [NSAttributedString.Key: AnyObject], context: nil)
            return ceil(stringRect.height)
        }
    }
}

extension String {
    var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x2600...0x26FF,   // Misc symbols
                 0x2700...0x27BF,   // Dingbats
                 0xFE00...0xFE0F,   // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 0x1F1E6...0x1F1FF: // Flags
                return true
            default:
                continue
            }
        }
        return false
    }
}

extension String {
    func replacePhone() -> String {
        let start = self.index(self.startIndex, offsetBy: 3)
        let end = self.index(self.startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return self.replacingCharacters(in: range, with: "****")
    }
}


// MARK: - 阿里云图片压缩

enum AliCloudImageResizeType: Int {
    // 小 中 大 尺寸
    case small = 120,
         middle = 200,
         large = 375
    var pixel2x: Int {
        return self.rawValue*2
    }

    var pixel3x: Int {
        return self.rawValue*3
    }
}

extension String {
    func resize(_ type: AliCloudImageResizeType) -> String {
        // 等比缩放   自动按照比例缩放 改变宽度
        return "\(self)?x-oss-process=image/resize,w_\(type.pixel2x),m_lfit"
    }
}

extension String {
    func toDictionary() -> [String : Any] {
        var result = [String : Any]()
        guard !self.isEmpty else { return result }
        guard let dataSelf = self.data(using: .utf8) else {
            return result
        }
        if let dic = try? JSONSerialization.jsonObject(with: dataSelf,
                                                       options: .mutableContainers) as? [String : Any] {
            result = dic
        }
        return result
    }
    
}
