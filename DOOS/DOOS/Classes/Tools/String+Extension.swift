//
//  String+Extension.swift
//  JuShareClub
//
//  Created by 聚名网络-郭军 on 2019/5/9.
//  Copyright © 2019 wangjiayu. All rights reserved.
//

import Foundation
import UIKit
// 计算文字高度或者宽度与weight参数无关
extension String {
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
    
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat,lineSpacing:CGFloat) -> CGFloat {
        
        let paraStyle = NSMutableParagraphStyle()
        
        //            paraStyle.minimumLineHeight = 17.3
        
        paraStyle.lineSpacing = 0
        
        paraStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        paraStyle.paragraphSpacing = 0
        
        paraStyle.paragraphSpacingBefore = 0
        
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.paragraphStyle:paraStyle], context: nil)
        return ceil(rect.height)
    }
    

}
