//
//  Global.swift
//  U17
//
//  Created by charles on 2017/10/24.
//  Copyright © 2017年 None. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import MJRefresh

import RxRelay
import RxSwift
import RxCocoa




let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
// iphone X
let isIphoneXMax = Bool(kScreenWidth >= 375.0 && kScreenHeight >= 812.0)

// 导航栏的高度
let kNavBarHeight : CGFloat = isIphoneXMax ? 88 : 64
// 底部 tabBar 的高度
let kTabBarHeight : CGFloat = isIphoneXMax ? 53 + 34 : 53
// 底部 tabBar 的高度
let OldTabBarHeight : CGFloat = isIphoneXMax ? 49 + 34 : 49

let kAreaHeight : CGFloat = isIphoneXMax ? 20 : 0

/** 状态栏的高度 */
let kStatusBarHeight = CGFloat(isIphoneXMax ? 44 : 20)
/** 底部的安全距离 */
let kBottomSafeHeight = CGFloat(isIphoneXMax ? 34 : 0)
/** 顶部的安全距离 */
let kTopSafeHeight = CGFloat(isIphoneXMax ? 44 : 0)

extension UIColor {
    class var background: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }
    
    class var theme: UIColor {
        return UIColor(r: 29, g: 221, b: 43)
    }
  
    class var MainColor: UIColor {
           return UIColor(r: 0, g: 192, b: 107)
       }
    class var MyRedColor: UIColor {
        return UIColor(r: 255, g: 40, b: 86)
    }
    
    class var EnabledColor : UIColor {
        
        return UIColor(r: 163, g: 231, b: 191)
    }
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height



var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

var isIphoneX: Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
        && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
        || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//MARK: print
func uLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}

func textHeight(text : String , fontSize : CGFloat , width : CGFloat) -> CGFloat{
    
    return text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height + 5.0
}

//MARK: Kingfisher
extension Kingfisher where Base: ImageView {
    @discardableResult
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        placeholder: placeholder,
                        options:[.transition(.fade(0.5))])
    }
}

extension Kingfisher where Base: UIButton {
    @discardableResult
    public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        for: state,
                        placeholder: placeholder,
                        options: [.transition(.fade(0.5))])
        
    }
}
//MARK: SnapKit
extension ConstraintView {
    
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

extension UICollectionView {
    
    func reloadData(animation: Bool = true) {
        if animation {
            reloadData()
        } else {
            UIView .performWithoutAnimation {
                reloadData()
            }
        }
    }
}

//MARK: swizzledMethod
extension NSObject {
    
    static func swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector){
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
