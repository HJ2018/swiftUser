//
//  HeadView.swift
//  DOOS
//
//  Created by jie.huang on 6/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit
import Reusable
import IBAnimatable
class HeadView: UIView ,NibReusable{

    var HeadModel : TeacherDataModel? {didSet {
        
         NamelLabel.text = HeadModel?.realName
         HeadImageView.kf.setImage(urlString: HeadModel?.headUrl, placeholder:  UIImage(named: ""))
         BgImageView.kf.setImage(urlString: HeadModel?.coverUrl, placeholder:  UIImage(named: ""))
        }
    }
    @IBOutlet weak var HeadImageView: AnimatableImageView!
    @IBOutlet weak var NamelLabel: UILabel!
    @IBOutlet weak var TopImage: NSLayoutConstraint!
    @IBOutlet weak var BgImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TopImage.constant = -kStatusBarHeight
        
    }
    
    @IBAction func backclick(_ sender: Any) {
        
        topVC?.navigationController?.popViewController(animated: true)
    }
}
