//
//  CourseDetailsHeadView.swift
//  DOOS
//
//  Created by jie.huang on 10/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable
import IBAnimatable
import UICircularProgressRing

class CourseDetailsHeadView: UIView,NibReusable {
    @IBOutlet weak var TopHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var progressRing: UICircularProgressRing!
    @IBOutlet weak var Studenticon: AnimatableImageView!
    override func awakeFromNib() {
           super.awakeFromNib()
        
//        TopHeight.constant += kNavBarHeight
        bottomView.layer.shadowColor =  UIColor.lightGray.cgColor
        bottomView.layer.shadowOpacity = 0.2
        bottomView.layer.shadowRadius = 5.0
        bottomView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        bottomView.layer.cornerRadius = 5
        Studenticon.layer.cornerRadius = 4
        Studenticon.layer.masksToBounds = true
       
        
        progressRing.maxValue = 100
        progressRing.style = .ontop
        progressRing.startAngle = -90
        progressRing.innerRingColor = UIColor(r: 235, g: 72, b: 73)
        progressRing.outerRingColor = UIColor(r: 236, g: 236, b: 236)
    }
    
}
