//
//  commentsView.swift
//  DOOS
//
//  Created by jie.huang on 11/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit
import Reusable

class commentsView: UIView ,NibReusable{

    
    var TitleName : ((_ name : String ) ->Void)?
    
    @IBOutlet weak var AllstateView: SlidingRatingView!
    @IBOutlet weak var AllManyiLabel: UILabel!
    
    var ViewCommenModel : commentListModel? {didSet {
        
        
        if v == nil {
           let rect = CGRect(x: 10, y: 110, width: kScreenWidth - 20 , height: 0)
           let arr =  (ViewCommenModel?.tagsList!.components(separatedBy:",")) ?? []
           v = QYPAdaptiveButton.creat(frame: rect, titleArr:arr)
           v!.isSel = true
           v!.delegate = self
           self.addSubview(v!)
        }
        AllstateView.value = Float((ViewCommenModel?.serviceScore) ?? 0)
        let m = (Int)(((ViewCommenModel?.serviceScore ?? 0)/5) * 100)
        AllManyiLabel.text = String(format: "服务满意度: %d%%",m)
        }
    }
  
    
    var v : QYPAdaptiveButton? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       AllstateView.sizeToFit()
       AllstateView.markFont = UIFont.systemFont(ofSize: 20)
       AllstateView.highlightColor = UIColor.init(r: 255, g: 211, b: 84)
       AllstateView.isUserInteractionEnabled = false
       
    }
    
    
}

extension commentsView:QYPAdaptiveButtonDelegate{
    
    func searchHistory(index: Int) {
        
        let arr = (ViewCommenModel?.tagsList!.components(separatedBy:",")) ?? []
        print(arr[index])
        if TitleName != nil {
            TitleName!(arr[index] as String)
        }
    }
}
