//
//  ProfileHeadView.swift
//  DOOS
//
//  Created by jie.huang on 9/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import IBAnimatable
import Reusable
import SVGKit



class ProfileHeadView: UIView ,NibReusable{

    @IBOutlet weak var jiantouBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var HeadImageView: AnimatableImageView!
    @IBOutlet weak var HeadimageTop: NSLayoutConstraint!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        HeadimageTop.constant = kNavBarHeight
        
        
        contentView.layer.shadowColor =  UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 5.0
        contentView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        
        
        btn1.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        btn2.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        btn3.SVGlayoutButtonWithEdgeInsetsStyle(style: .top, space: 25)
        btn1.setImage(SVGKImage.init(named: "wodefabu").uiImage, for: .normal)
        btn2.setImage(SVGKImage.init(named: "mykeshi").uiImage, for: .normal)
        btn3.setImage(SVGKImage.init(named: "zhangdan").uiImage, for: .normal)
        jiantouBtn.setImage(SVGKImage.init(named: "myjiantou").uiImage, for: .normal)

        
    }
    
}
