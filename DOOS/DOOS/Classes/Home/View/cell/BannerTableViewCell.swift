//
//  BannerTableViewCell.swift
//  DOOS
//
//  Created by jie.huang on 31/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable
class BannerTableViewCell: UITableViewCell,NibReusable {
    
       var pictures : [String]? = []
       var BannerModel : [activityListModel]? = [] {didSet {
             for (_,value) in BannerModel!.enumerated() {
                     pictures?.append(value.imgUrl!)
                 }
              customPagetrolPositionnCycleView.pictures = pictures!
          }
      }
    
//    自定义图片宽度和指示器的位置和颜色
      lazy var customPagetrolPositionnCycleView: ICycleView = {
          let cycleView = ICycleView(frame: CGRect(x: 0, y: 15, width: UIScreen.main.bounds.width, height: 140))
          cycleView.imgViewWidth = SCREEN_WIDTH - 30
        cycleView.currentPageIndicatorTintColor = UIColor.MainColor
        cycleView.pageIndicatorTintColor = UIColor(r: 184, g: 184, b: 184)
          cycleView.delegate = self
          self.addSubview(cycleView)
          return cycleView
      }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


// MARK: ICycleViewDelegate
extension BannerTableViewCell: ICycleViewDelegate {
    
    /**
     - 协议方法都是可选方法，根据需要实现即可
     */
    
    // 图片点击
    func iCycleView(cycleView: ICycleView, didSelectItemAt index: Int) {
        print("你点击了第 \(index) 张图片")
    }
    
    // 图片自动滚动
    func iCycleView(cycleView: ICycleView, autoScrollingItemAt index: Int) {
        print("当前滚动的图片是第 \(index) 张")
    }
    
}
