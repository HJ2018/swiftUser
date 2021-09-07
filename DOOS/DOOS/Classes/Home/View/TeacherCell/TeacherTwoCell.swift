//
//  TeacherTwoCell.swift
//  DOOS
//
//  Created by jie.huang on 6/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit
import Reusable

class TeacherTwoCell: UITableViewCell,NibReusable {

    @IBOutlet weak var HighSchoolLabel: UILabel!
    @IBOutlet weak var JuniorschoolLabel: UILabel!
    @IBOutlet weak var primaryschoolLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    
    @IBOutlet weak var Name1: UILabel!
    @IBOutlet weak var Name2: UILabel!
    @IBOutlet weak var Name3: UILabel!
    
    var cellTwoModel : TeacherDataModel? {didSet {
        areaLabel.text =  cellTwoModel?.teachingArea ?? "".replacingOccurrences(of: ",", with: " | ")
        let arr : [PeriodList]? = cellTwoModel?.periodList ?? []
        
        for (index,value) in arr!.enumerated() {
                
                if index == 0 {
                    Name1.text = value.name
                    HighSchoolLabel.text = value.subjectList!.joined(separator: " | ")
                }else if index == 1{
                    Name2.text = value.name
                    JuniorschoolLabel.text = value.subjectList!.joined(separator: " | ")
                }else if index == 2{
                    Name3.text = value.name
                    primaryschoolLabel.text = value.subjectList!.joined(separator: " | ")
                }
            }
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
