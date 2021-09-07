//
//  PublishHeadView.swift
//  DOOS
//
//  Created by jie.huang on 17/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable

class PublishHeadView: UIView ,NibReusable {

    
    @IBOutlet weak var PMapBtn: UIButton!
    @IBOutlet weak var addressLabel: UILabel!
    
    
//    lazy var placeholderTextView = PlaceholderTextView(placeholder: "请输入要求...", placeholderColor: UIColor.lightGray, frame: CGRect(x: 15, y: 5, width: kScreenWidth - 30, height: 120))
    
//    @IBAction func locationClick(_ sender: Any) {
        
//       let vc = topVC!.creatStoryboardVc(StoryboardName: "Main", StoryboardID: "AMap")
//        topVC!.present(vc, animated: true, completion: nil)
//    }
    
    
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
        
//        placeholderTextView.isShowCountLabel = true
//        placeholderTextView.limitWords = 200
//        placeholderTextView.isReturnHidden = true
//        self.addSubview(placeholderTextView)
        
        
//        self.layer.shadowColor =  UIColor.lightGray.cgColor
//        self.layer.shadowOpacity = 0.1
//        self.layer.shadowRadius = 5.0
//        self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
//        self.layer.cornerRadius = 5

        
    }
    

    
}
