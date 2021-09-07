//
//  HomeTableCell.swift
//  DOOS
//
//  Created by jie.huang on 14/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable
import IBAnimatable

class HomeTableCell: UITableViewCell ,NibReusable{
    
    @IBOutlet weak var hedaImageView: AnimatableImageView!
    @IBOutlet weak var TeacherNameLabel: UILabel!
    @IBOutlet weak var SchoolNameLabel: UILabel!
    @IBOutlet weak var subjectsLabel: UILabel!
    @IBOutlet weak var introduceLabelLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
     var teacherModel : tutorListModel?{didSet {
        
        hedaImageView.kf.setImage(urlString: teacherModel?.headUrl, placeholder:  UIImage(named: ""))
        TeacherNameLabel.text = teacherModel?.realName
        SchoolNameLabel.text = teacherModel?.school
        priceLabel.text = teacherModel?.price
        subjectsLabel.text = "辅导科目：\(teacherModel?.subjects ?? "")"
        introduceLabelLabel.text = teacherModel?.introduction
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
