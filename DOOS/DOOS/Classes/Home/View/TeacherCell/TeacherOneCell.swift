//
//  TeacherOneCell.swift
//  DOOS
//
//  Created by jie.huang on 5/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit
import Reusable

class TeacherOneCell: UITableViewCell,NibReusable {

    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var cellOneModel : TeacherDataModel? {didSet {
        
        schoolLabel.text = cellOneModel?.school
        experienceLabel.text = String(format: "%@家教经验", cellOneModel?.experience ?? "")
        introductionLabel.text = cellOneModel?.introduction
        priceLabel.text = cellOneModel?.price
        }
    }
    
    
    
     override func awakeFromNib() {
         super.awakeFromNib()
         // Initialization code
         
         self.layer.shadowColor =  UIColor.lightGray.cgColor
         self.layer.shadowOpacity = 0.1
         self.layer.shadowRadius = 5.0
         self.layer.shadowOffset = CGSize.init(width: 0, height: 0)
         self.layer.cornerRadius = 5
         
     }
    
    override var frame: CGRect{
          didSet{
              var newFrame = frame
              newFrame.origin.x = 8
              newFrame.size.width -= 2 * newFrame.origin.x
              newFrame.size.height -= 8
              newFrame.origin.y += 5
              super.frame = newFrame
              
          }
      }
    
}
