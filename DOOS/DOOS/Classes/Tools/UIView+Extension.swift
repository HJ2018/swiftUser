//
//  UIView+Extension.swift
//  News
//
//  Created by 杨蒙 on 2017/9/16.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

extension UIView {
    /** 获取当前 view 所在的 controller  */
    func getViewOnController() -> UIViewController {
        var nextResponder:UIResponder?
        nextResponder = self.next
        repeat {
            if nextResponder as? UIViewController != nil {
                return (nextResponder as! UIViewController)
            }else {
                nextResponder = nextResponder?.next
            }
        }while nextResponder != nil
        
        return UIViewController()
    }
}

extension UIView {
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    //middleX
    var middleX : CGFloat {
        
        get {
            
            return width / 2
        }
    }
    
    //middleY
    var middleY : CGFloat {
        
        get {
            
            return height / 2
        }
    }
    
    //middlePoint
    var middlePoint : CGPoint {
        
        get {
            
            return CGPoint(x: middleX, y: middleY)
        }
    }
    
}
