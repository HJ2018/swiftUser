//
//  HomeheadView.swift
//  DOOS
//
//  Created by jie.huang on 14/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable

class HomeheadView: UIView,NibReusable {

    @IBOutlet weak var HeadCollectionView: UICollectionView!
    @IBOutlet weak var OneView: UIView!
        @IBOutlet weak var TwoView: UIView!
    @IBOutlet weak var ThereView: UIView!
    @IBOutlet weak var PMDView: JJMarqueeView!
    
    var flowLayout :UICollectionViewFlowLayout?
    var arrayM = [" 语文" , "数学" , "英语" , "化学" , "物理" , "政治" , "生物"]
    
    // 自定义图片宽度和指示器的位置和颜色
       lazy var customPagetrolPositionnCycleView: ICycleView = {
           let cycleView = ICycleView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 140))
           cycleView.imgViewWidth = SCREEN_WIDTH - 30
           cycleView.pageIndicatorTintColor = .green
           cycleView.delegate = self
           self.addSubview(cycleView)
           return cycleView
       }()
    // 图片
   let pictures = ["https://goodreading.mobi/StudentApi/UserFiles/Banner/Student/Home/banner_tz.png", "https://goodreading.mobi/StudentApi/UserFiles/Banner/Student/Home/banner_dzsyy.png", "https://goodreading.mobi/studentapi/userfiles/banner/student/home/studenttj.png"]
    
    override func awakeFromNib() {
          super.awakeFromNib()
        
        customPagetrolPositionnCycleView.pictures = pictures
        
        OneView.layer.cornerRadius = 5
        OneView.layer.shadowColor =  UIColor.lightGray.cgColor
        OneView.layer.shadowOpacity = 0.1
        OneView.layer.shadowRadius = 5.0
        OneView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        OneView.backgroundColor = UIColor(r: 247, g: 250, b: 233)
        
        TwoView.layer.cornerRadius = 5
        TwoView.layer.shadowColor =  UIColor.lightGray.cgColor
        TwoView.layer.shadowOpacity = 0.1
        TwoView.layer.shadowRadius = 5.0
        TwoView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        TwoView.backgroundColor = UIColor(r: 244, g: 249, b: 244)
        
        ThereView.layer.cornerRadius = 5
        ThereView.layer.shadowColor =  UIColor.lightGray.cgColor
        ThereView.layer.shadowOpacity = 0.1
        ThereView.layer.shadowRadius = 5.0
        ThereView.layer.shadowOffset = CGSize.init(width: 0, height: 0)
        ThereView.backgroundColor = UIColor(r: 239, g: 248, b: 254)
        
        
        HeadCollectionView?.dataSource = self
        HeadCollectionView?.delegate = self
        flowLayout = UICollectionViewFlowLayout()
        HeadCollectionView.collectionViewLayout = flowLayout!
        // 流式布局时设置集合视图单元格大小
        self.flowLayout!.itemSize = CGSize(width: (SCREEN_WIDTH)/4, height: 75)
        HeadCollectionView?.isPagingEnabled = true
        self.flowLayout?.scrollDirection = .horizontal
        HeadCollectionView?.showsHorizontalScrollIndicator = false
        HeadCollectionView.register(cellType: CollectionViewCell.self)
        
        
//      跑马灯
        PMDView.automaticSlidingInterval = 3
        PMDView.delegate = self
        PMDView.dataSource = self
        PMDView.reload()
        
      }
}

extension HomeheadView : JJMarqueeViewDelegate,JJMarqueeViewDataSource{
    
    
    /// MARK: - 跑马灯View 代理 ==========
    func numberOfItems(_ marqueeView: JJMarqueeView) -> Int {
        return 3
    }
    func marqueeView(_ marqueeView: JJMarqueeView, cellForItemAt index: Int) -> NSAttributedString {
        
        if index == 0 {
            
            let str = "【我只是说说而已】"
            let fullStr = "\(str) 提现了100.00元到支付宝" as NSString
            let r = fullStr.range(of: str)
            let att = NSMutableAttributedString.init(string: fullStr as String)
            att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: r)
            return att
            
        }else if index == 1{
            
            let str = "【梦想只是说说而已】"
            let fullStr = "\(str) 提现了200.00元到支付宝" as NSString
            let r = fullStr.range(of: str)
            let att = NSMutableAttributedString.init(string: fullStr as String)
            att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: r)
            return att
        }else{
            
            let str = "【梦想就是梦】"
            let fullStr = "\(str) 提现了900.00元到支付宝" as NSString
            let r = fullStr.range(of: str)
            let att = NSMutableAttributedString.init(string: fullStr as String)
            att.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.purple, range: r)
            return att
        }
    }
}

extension HomeheadView : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CollectionViewCell  = collectionView.dequeueReusableCell(for: indexPath as IndexPath, cellType: CollectionViewCell.self)
        cell.textlabel.text = "\(arrayM[indexPath.row])"
        return cell
    }
    
    
    // MARK:- UICollectionViewDataSource
    // 定义展示的Section的个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 定义展示的UICollectionViewCell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayM.count
    }

    // MARK:- UICollectionViewDelegateFlowLayout
         // 设置cell和视图边的间距
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
             return UIEdgeInsets(top: 15, left: 0, bottom: 10, right: 10)
         }
         
         // 设置每一个cell最小行间距
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 0
         }
         
         // 设置每一个cell的列间距
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
             return 0
         }
         

    
}

// MARK: ICycleViewDelegate
extension HomeheadView: ICycleViewDelegate {
    
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
