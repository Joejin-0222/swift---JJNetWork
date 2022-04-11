//
//  NSString-Extension.swift
//  Fattykitchen
//
//  Created by 张海峰 on 2017/8/30.
//  Copyright © 2017年 张海峰. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit
extension NSString{
    //1.判断是否是手机号
    class func initValiMobile(mobile: String) -> Bool {
        let count = mobile.count
        if count != 11
        {
            return false
        }else{
            return true
        }
    }
    //把当前时间时间转换成时间戳
    class func initNowDate() -> String{
        let timeInterval = NSDate().timeIntervalSince1970 * 1000
        return (String(timeInterval) as NSString).substring(to: 10)
    }
    //时间戳转时间
    class func initTime(timeStamp:NSInteger) -> String{
    let timeInterval:TimeInterval = TimeInterval(timeStamp)
    let date = Date.init(timeIntervalSince1970: timeInterval)
    //输出格式
    let dformatter = DateFormatter.init()
        dformatter.dateFormat = "yyyy\\MM\\dd"
    let time  = dformatter.string(from: date)
    return time
    }
    //判断是否是邮箱
    class func initmailBox(email: String) -> Bool  {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}
extension NSString{
     //2.Md5 字典加密
    class func initMd5(Arr: [String]) -> [String : AnyObject] {
        var string :String = "Surprisebox123"
        for  str1 in Arr {
            let strArr = str1.components(separatedBy: "=")
            string.append("\(strArr[0])\(strArr[1])")
        }
        let str = string.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(string.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        result.deinitialize(count: digestLen)
        let strMd5 = String(format: hash as String).uppercased()
        let parameters :NSMutableDictionary = ["sign":strMd5]
        for i in 0 ..< Arr.count {
            let str = Arr[i]
            let strArray = str.components(separatedBy: "=")
            parameters.setObject( strArray[1], forKey: strArray[0] as NSCopying)
        }
        return parameters as! [String : AnyObject]
    }
    //2.Md5 字符串加密
    class func initMd5Str(string: String) -> String {
        let string1 :String = "Surprisebox123\(string)"
        let str = string1.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(string1.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        result.deinitialize(count: digestLen)
        let strMd5 = String(format: hash as String).uppercased()
        return strMd5
    }
}
extension NSString{
    //字典转字符串
    class func initGetJsonString(dic: NSDictionary) -> String{
        if (!JSONSerialization.isValidJSONObject(dic)) {
            // "无法解析"
            return ""
        }
        let data :NSData! = try? JSONSerialization.data(withJSONObject: dic, options: []) as NSData?
        let jsonString = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        return jsonString! as String
    }
    //字符串转字典
    class func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
}
extension NSString{
    var removeAllSapce: String {
        if self.length != 11{
            //过滤手机号中的 " " 和 "-" 和不是数字的东西
            return self.replacingOccurrences(of: "[^0-9]", with: "", options: NSString.CompareOptions.regularExpression, range: NSRange.init(location: 0, length: self.length))
        }
        else{
            return self as String
        }
    }
}