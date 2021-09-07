//
//  UIButton+Extension.swift
//  JuShareClub
//
//  Created by wangjiayu on 2019/5/10.
//  Copyright © 2019 wangjiayu. All rights reserved.
//

import UIKit
enum ButtonEdgeInsetsStyle:Int {
    case top = 0
    case left = 1
    case bottom = 2
    case right = 3
}


extension UIButton {
    
   static public func creatButton(imageName:String?, title:String) -> UIButton {
        let button = UIButton()
        if ((imageName?.count) != nil) {
            button.setImage(UIImage(named: imageName!), for: UIControl.State.normal)
        }
        button.setTitle(title, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }
    
    
    func layoutButtonWithEdgeInsetsStyle(style:ButtonEdgeInsetsStyle,space:CGFloat) {
        let imageWidth = imageView?.size.width ?? 0
        let imageHeight = imageView?.size.height ?? 0
        
        let labelWidth = titleLabel?.size.width ?? 0
        let labelHeight = titleLabel?.size.height ?? 0
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .top: do {
                imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2, left: 0, bottom: 0, right: -labelWidth)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-space/2, right: 0)
            }
        case .left: do {
                imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2, bottom: 0, right: space/2)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2)
            }
        case .bottom: do {
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space/2, right: -labelWidth)
                labelEdgeInsets = UIEdgeInsets(top: -imageHeight - space, left: -imageWidth, bottom: 0, right: 0)
            }
        case .right: do {
                imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space/2, bottom: 0, right:-labelWidth - space/2)
                labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth-space/2.0, bottom: 0, right:imageWidth + space/2)
            }
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    func SVGlayoutButtonWithEdgeInsetsStyle(style:ButtonEdgeInsetsStyle,space:CGFloat) {
           let imageWidth = imageView?.size.width ?? 0
           let imageHeight = imageView?.size.height ?? 0
           
           let labelWidth = titleLabel?.size.width ?? 0
           let labelHeight = titleLabel?.size.height ?? 0
           
           var imageEdgeInsets = UIEdgeInsets.zero
           var labelEdgeInsets = UIEdgeInsets.zero
           
           switch style {
           case .top: do {
                   imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2, left: 10, bottom: 0, right: -labelWidth)
                   labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight-space/2, right: 0)
               }
           case .left: do {
                   imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2, bottom: 0, right: space/2)
                   labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2)
               }
           case .bottom: do {
                   imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space/2, right: -labelWidth)
                   labelEdgeInsets = UIEdgeInsets(top: -imageHeight - space, left: -imageWidth, bottom: 0, right: 0)
               }
           case .right: do {
                   imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space/2, bottom: 0, right:-labelWidth - space/2)
                   labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth-space/2.0, bottom: 0, right:imageWidth + space/2)
               }
           }
           
           self.titleEdgeInsets = labelEdgeInsets
           self.imageEdgeInsets = imageEdgeInsets
       }
}
