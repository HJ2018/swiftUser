//
//  CourseDetailsTbCell.swift
//  DOOS
//
//  Created by jie.huang on 10/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable

class CourseDetailsTbCell: UITableViewCell,NibReusable {
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var StatusView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.shadowColor =  UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        self.layer.cornerRadius = 5
        
        statusLabel.layer.cornerRadius = 4

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var frame: CGRect{
          
          didSet{
              var newFrame = frame
              newFrame.origin.x = 15
              newFrame.size.width -= 2 * newFrame.origin.x
              newFrame.size.height -= 15
              newFrame.origin.y += 20
              super.frame = newFrame
              
          }
      }
    
}
