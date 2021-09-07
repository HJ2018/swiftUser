//
//  PublishTableCell.swift
//  DOOS
//
//  Created by jie.huang on 17/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable

class PublishTableCell: UITableViewCell ,NibReusable{

    @IBOutlet weak var Titlelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        self.layer.shadowColor =  UIColor.lightGray.cgColor
//        self.layer.shadowOpacity = 0.1
//        self.layer.shadowRadius = 5.0
//        self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
//        self.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override var frame: CGRect{
//                
//                didSet{
//                    var newFrame = frame
//                    newFrame.origin.x = 8
//                    newFrame.size.width -= 2 * newFrame.origin.x
//                    newFrame.size.height -= 8
//                    newFrame.origin.y += 5
//                    super.frame = newFrame
//                    
//                }
//            }
    
}
