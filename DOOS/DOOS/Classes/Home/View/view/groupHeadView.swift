//
//  groupHeadView.swift
//  DOOS
//
//  Created by jie.huang on 31/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable
import SVGKit

class groupHeadView: UIView ,NibReusable{

    @IBOutlet weak var pageCont: CHIPageControlJaloro!
    
    @IBOutlet weak var GroupCollectionView: UICollectionView!
    
    var subjectsModel : [subjectsModel]? = []
   
//    {didSet {}}
    
    var flowLayout :UICollectionViewFlowLayout?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        GroupCollectionView?.dataSource = self
        GroupCollectionView?.delegate = self
        flowLayout = UICollectionViewFlowLayout()
        GroupCollectionView.collectionViewLayout = flowLayout!
        // 流式布局时设置集合视图单元格大小
        self.flowLayout!.itemSize = CGSize(width: (SCREEN_WIDTH)/4, height: 85)
//        GroupCollectionView?.isPagingEnabled = true
        self.flowLayout?.scrollDirection = .horizontal
        GroupCollectionView?.showsHorizontalScrollIndicator = false
        GroupCollectionView.register(cellType: CollectionViewCell.self)
    }
    

}

extension groupHeadView : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CollectionViewCell  = collectionView.dequeueReusableCell(for: indexPath as IndexPath, cellType: CollectionViewCell.self)
        
        cell.textlabel.text = subjectsModel![indexPath.row].name
//        cell.iconImageView.image =
        cell.BtnImage.setImage(SVGKImage.init(named: subjectsModel![indexPath.row].name ?? "").uiImage, for: .normal)
        if subjectsModel![indexPath.row].name == "数学" || subjectsModel![indexPath.row].name == "地理"{
            cell.BtnImage.backgroundColor = UIColor.init(r: 233, g: 246, b: 254)
        }else if subjectsModel![indexPath.row].name == "语文"{
            cell.BtnImage.backgroundColor = UIColor.init(r: 255, g: 246, b: 233)
        }else if subjectsModel![indexPath.row].name == "英语"{
            cell.BtnImage.backgroundColor = UIColor.init(r: 255, g: 238, b: 239)
        }else if subjectsModel![indexPath.row].name == "物理" || subjectsModel![indexPath.row].name == "政治"{
             cell.BtnImage.backgroundColor = UIColor.init(r: 229, g: 250, b: 244)
        }else if subjectsModel![indexPath.row].name == "化学" || subjectsModel![indexPath.row].name == "历史"{
            cell.BtnImage.backgroundColor = UIColor.init(r: 240, g: 243, b: 255)
        }else if subjectsModel![indexPath.row].name == "生物"{
            cell.BtnImage.backgroundColor = UIColor.init(r: 240, g: 243, b: 255)
        }
        return cell
    }
    
    
    // MARK:- UICollectionViewDataSource
    // 定义展示的Section的个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 定义展示的UICollectionViewCell的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjectsModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        topVC?.navigationController?.pushViewController(SearchTeacherTableController(), animated: true)
    }

    // MARK:- UICollectionViewDelegateFlowLayout
         // 设置cell和视图边的间距
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
             return UIEdgeInsets(top: 5, left: 0, bottom: 10, right: 10)
         }
         
         // 设置每一个cell最小行间距
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 0
         }
         
         // 设置每一个cell的列间距
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
             return 0
         }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let total = scrollView.contentSize.width - scrollView.bounds.width
        let offset = scrollView.contentOffset.x
        let percent = Double(offset / total)
        let progress = percent
        pageCont.progress = progress
    }

}

