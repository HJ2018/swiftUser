//
//  UIColorExtension.swift
//  JuShareClub
//
//  Created by gj on 2019/5/7.
//  Copyright © 2019 wangjiayu. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    
    convenience init?(hex: String) {
        //校验该 hex 字符串是否符合规则
        guard hex.count > 6 else { return nil }
        //hex字符串可能是以 `##` `#` `0x` `0X`开头
        var tempHex = hex.uppercased()
        
            if tempHex.hasPrefix("##") || tempHex.hasPrefix("0X") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        
        if tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        var r:UInt32 = 0
        var g:UInt32 = 0
        var b:UInt32 = 0
        
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        self.init(r: r, g: g, b: b)
    }
    
    class var random: UIColor {
        return UIColor(r: arc4random_uniform(256),
                       g: arc4random_uniform(256),
                       b: arc4random_uniform(256))
    }
    
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
//    class func hex(hexString: String) -> UIColor {
//        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
//        if cString.count < 6 { return UIColor.black }
//        
//        let index = cString.index(cString.endIndex, offsetBy: -6)
//        let subString = cString[index...]
//        if cString.hasPrefix("0X") { cString = String(subString) }
//        if cString.hasPrefix("#") { cString = String(subString) }
//        
//        if cString.count != 6 { return UIColor.black }
//        
//        var range: NSRange = NSMakeRange(0, 2)
//        let rString = (cString as NSString).substring(with: range)
//        range.location = 2
//        let gString = (cString as NSString).substring(with: range)
//        range.location = 4
//        let bString = (cString as NSString).substring(with: range)
//        
//        var r: UInt32 = 0x0
//        var g: UInt32 = 0x0
//        var b: UInt32 = 0x0
//        
//        Scanner(string: rString).scanHexInt32(&r)
//        Scanner(string: gString).scanHexInt32(&g)
//        Scanner(string: bString).scanHexInt32(&b)
//        
//        return UIColor(r: r, g: g, b: b)
//    }
}

extension UIImage {
    
    func getImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
