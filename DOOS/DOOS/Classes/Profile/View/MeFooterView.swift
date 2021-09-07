//
//  MeFooterView.swift
//  DOOS
//
//  Created by jie.huang on 11/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable
import SVGKit

class MeFooterView: UIView ,NibReusable{
    
    @IBOutlet weak var teachingView: UIView!
    @IBOutlet weak var teachingBtn1: UIButton!
    @IBOutlet weak var teachingBtn2: UIButton!
    @IBOutlet weak var teachingBtn3: UIButton!
    
    
    @IBOutlet weak var serveView: UIView!
    @IBOutlet weak var serveBtn1: UIButton!
    @IBOutlet weak var serveBtn2: UIButton!
    @IBOutlet weak var serveBtn3: UIButton!
    @IBOutlet weak var serveBtn4: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        teachingView.layer.shadowColor =  UIColor.gray.cgColor
        teachingView.layer.shadowOpacity = 0.15
        teachingView.layer.shadowRadius = 5.0
        teachingView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        teachingView.layer.cornerRadius = 5
        teachingBtn1.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        teachingBtn2.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        teachingBtn3.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        teachingBtn1.setImage(SVGKImage.init(named: "laoshi.svg").uiImage, for: .normal)
        teachingBtn2.setImage(SVGKImage.init(named: "pingjia.svg").uiImage, for: .normal)
        teachingBtn3.setImage(SVGKImage.init(named: "baobiaomokuai.svg").uiImage, for: .normal)
        
        
        serveView.layer.shadowColor =  UIColor.gray.cgColor
        serveView.layer.shadowOpacity = 0.15
        serveView.layer.shadowRadius = 5.0
        serveView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        serveView.layer.cornerRadius = 5
        serveBtn1.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        serveBtn2.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        serveBtn3.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        serveBtn4.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        
        serveBtn1.setImage(SVGKImage.init(named: "tuifeibaozhang.svg").uiImage, for: .normal)
        serveBtn2.setImage(SVGKImage.init(named: "fankui.svg").uiImage, for: .normal)
        serveBtn3.setImage(SVGKImage.init(named: "lianxiwomen.svg").uiImage, for: .normal)
        serveBtn4.setImage(SVGKImage.init(named: "gunyu.svg").uiImage, for: .normal)
        
    }
    
    @IBAction func ServeBtn3Click(_ sender: UIButton) {
        
        topVC?.alterMessage(title: "提示", message: "联系客服", handler: {
            let phone = "telprompt://" + "0551-62865607"
            if UIApplication.shared.canOpenURL(URL(string: phone)!) {
                 UIApplication.shared.openURL(URL(string: phone)!)
             }
        })
        
    }
    
}
