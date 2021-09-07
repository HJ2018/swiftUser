//
//  commentsTableViewCell.swift
//  DOOS
//
//  Created by jie.huang on 10/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit
import IBAnimatable
import Reusable
class commentsTableViewCell: UITableViewCell,NibReusable {
    
    @IBOutlet weak var HeadImaegView: AnimatableImageView!
    @IBOutlet weak var FKLabel: UILabel!
    @IBOutlet weak var linView: UIView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var subjectsLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var TagLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var StartView: SlidingRatingView!
    
    
    var CellcommentList : CommentDetilsList? { didSet {
        
        NameLabel.text = CellcommentList?.parentName
        gradeLabel.text = CellcommentList?.gradeName
        subjectsLabel.text = CellcommentList?.subjectName
        TimeLabel.text = CellcommentList?.createTime
        TagLabel.text = CellcommentList?.tagsList
        commentsLabel.text = CellcommentList?.content
        feedbackLabel.text = CellcommentList?.replyContent
        StartView.value = Float((CellcommentList?.serviceScore) ?? 0)
        HeadImaegView.kf.setImage(urlString: CellcommentList?.headUrl, placeholder:  UIImage(named: ""))
        
        if CellcommentList?.replyContent == nil {
            linView.isHidden = true
            FKLabel.isHidden = true
            feedbackLabel.isHidden = true
        }else{
            linView.isHidden = false
            FKLabel.isHidden = false
            feedbackLabel.isHidden = false
        }
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = 5
        
        StartView.sizeToFit()
        StartView.markFont = UIFont.systemFont(ofSize: 18)
        StartView.highlightColor = UIColor.init(r: 255, g: 211, b: 84)
        StartView.isUserInteractionEnabled = false
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
