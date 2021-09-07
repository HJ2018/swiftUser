//
//  NavBarView.swift
//  DOOS
//
//  Created by jie.huang on 7/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit
import Reusable
class NavBarView: UIView,NibReusable {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var backBtnTop: NSLayoutConstraint!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var iamgeH: NSLayoutConstraint!
    @IBOutlet weak var imageW: NSLayoutConstraint!
    @IBOutlet weak var HeadImaegView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
                
    }
    
    
    @IBAction func BackClick(_ sender: UIButton) {
        topVC?.navigationController?.popViewController(animated: true)
    }
    
    
}
