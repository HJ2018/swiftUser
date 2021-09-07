//
//  TeacherFourCell.swift
//  DOOS
//
//  Created by jie.huang on 6/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit
import Reusable
import IBAnimatable
class TeacherFourCell: UITableViewCell ,NibReusable{

    @IBOutlet weak var starsView: SlidingRatingView!
    @IBOutlet weak var ManyLabel: UILabel!
    @IBOutlet weak var NickLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var PjLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var TopH: NSLayoutConstraint!
    @IBOutlet weak var PjAllView: UIView!
    @IBOutlet weak var HFlabel: UILabel!
    @IBOutlet weak var moreBtn: AnimatableButton!
    @IBOutlet weak var HeadImaegView: AnimatableImageView!
    
    
    var cellThreeModel : TeacherDataModel? {didSet {
        
        let pjarr : [CommentList] = cellThreeModel?.comment!.commentList ?? []
        
        if pjarr.count > 0 {
             PjAllView.isHidden = false
            
            starsView.value = Float((cellThreeModel?.comment!.serviceScore) ?? 0)
            starsView.isUserInteractionEnabled = false
            
            let m = (Int)(((cellThreeModel?.comment!.serviceScore ?? 0)/5) * 100)
            ManyLabel.text = String(format: "服务满意度: %d%%",m)
            
            if v == nil {
                let rect = CGRect(x: 0, y: 90, width: UIScreen.main.bounds.size.width, height: 0)
                let arr =  (cellThreeModel?.comment!.tagsList!.components(separatedBy:",")) ?? []
                              
                v = QYPAdaptiveButton.creat(frame: rect, titleArr:arr)
                              TopH.constant = 90 + v!.height
                v!.isSel = false
                self.addSubview(v!)
            }
            
            HeadImaegView.kf.setImage(urlString: cellThreeModel?.comment!.commentList?.first?.headUrl, placeholder:  UIImage(named: ""))
            PjLabel.text = cellThreeModel?.comment!.commentList?.first?.content
            tagLabel.text = cellThreeModel?.comment!.commentList?.first?.tagsList
            NickLabel.text = cellThreeModel?.comment!.commentList?.first?.parentName
            gradeLabel.text = cellThreeModel?.comment!.commentList?.first?.gradeName
            TimeLabel.text = cellThreeModel?.comment!.commentList?.first?.createTime
            HFlabel.text = cellThreeModel?.comment!.commentList?.first?.replyContent
            
        }else{
            PjAllView.isHidden = true
        }
        }
    }
    
    
    
    var v : QYPAdaptiveButton? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        starsView.sizeToFit()
        starsView.markFont = UIFont.systemFont(ofSize: 19)
        starsView.highlightColor = UIColor.init(r: 255, g: 211, b: 84)
       
    }
    @IBAction func morepjClick(_ sender: Any) {
        
        let vc = CommentsTableController()
        vc.tutorId = cellThreeModel?.id
        topVC?.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
