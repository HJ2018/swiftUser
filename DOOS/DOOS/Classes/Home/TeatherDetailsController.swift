//
//  TeatherDetailsController.swift
//  DOOS
//
//  Created by jie.huang on 5/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit

class TeatherDetailsController: UBaseViewController,UIScrollViewDelegate {
    
    
    
    
    var DataModel : TeacherDataModel?
    
    var TeacherID : String?

    
    private lazy var NavView : NavBarView = {
       
        let  naview = NavBarView.loadFromNib()
        naview.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kNavBarHeight + 20)
        return naview
    }()
    
    private lazy var headView : HeadView = {
       
        let  headView = HeadView.loadFromNib()
        headView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 180)
        return headView
    }()
    
    private lazy var bottomView : TeacherBottomView = {
       
        let  BView = TeacherBottomView.loadFromNib()
        BView.frame = CGRect(x: 0, y: kScreenHeight - OldTabBarHeight, width: kScreenWidth, height: OldTabBarHeight)
        return BView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:kScreenWidth, height: kScreenHeight - OldTabBarHeight), self as UITableViewDelegate, self as UITableViewDataSource, nil)
        tableView.separatorStyle = .none
        tableView.register(cellType: TeacherOneCell.self)
        tableView.register(cellType: TeacherTwoCell.self)
        tableView.register(cellType: TableThreeViewCell.self)
        tableView.register(cellType: TeacherFourCell.self)
         return tableView
     }()
    
    deinit {
           /// 移除通知
           NotificationCenter.default.removeObserver(self)
       }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        view.addSubview(tableView)
        view.addSubview(bottomView)
        view.addSubview(NavView)
        tableView.tableHeaderView = headView
        NavView.alpha = 0
        
        
        ApiLoadingProvider.request(DoosApi.getTeactherDetils(ID: TeacherID!), model: TeacherDataModel.self) { (TeacherModel) in
            self.DataModel = TeacherModel
            self.headView.HeadModel = TeacherModel
            self.NavView.HeadImaegView.kf.setImage(urlString: TeacherModel?.headUrl, placeholder:  UIImage(named: ""))
            self.tableView.reloadData()
            uLog(TeacherModel?.realName)
        }
        
        self.sh_prefersNavigationBarHidden = true
        
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY:CGFloat = scrollView.contentOffset.y
        if offsetY < 0 {
            let originalHeight:CGFloat = headView.height
            
            let scale:CGFloat = (originalHeight - offsetY) / originalHeight
            let transformScale3D:CATransform3D = CATransform3DMakeScale(scale, scale, 1.0)
            let translation3D:CATransform3D = CATransform3DMakeTranslation(0, offsetY/2, 0)
            headView.BgImageView.layer.transform = CATransform3DConcat(transformScale3D, translation3D)

        } else {
            headView.BgImageView.layer.transform = CATransform3DIdentity
        }
        var delta =  offsetY / (headView.BgImageView.height - kNavBarHeight)
        delta = CGFloat.maximum(delta, 0)
        NavView.alpha = CGFloat.minimum(delta, 1)
        
        if offsetY < kTopSafeHeight + 50 {
            NavView.HeadImaegView.layer.cornerRadius = offsetY/2
            NavView.imageW.constant = offsetY
            NavView.iamgeH.constant = offsetY
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offsetY:CGFloat = scrollView.contentOffset.y
        if offsetY > kTopSafeHeight + 50 {
            NavView.HeadImaegView.layer.cornerRadius = 25
            NavView.imageW.constant = 50
            NavView.iamgeH.constant = 50
        }
    }

}

extension TeatherDetailsController : UITableViewDelegate , UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row == 0 {
            return DataModel?.clleOneH ?? 0
         }else if indexPath.row == 1{
            return DataModel?.clleTwoH ?? 0
         }else if indexPath.row == 2{
            return DataModel?.cellThreeH ?? 0
         }else{
            return DataModel?.cellFourH ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           return 4
       }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TeacherOneCell.self)
            cell.cellOneModel = DataModel
            return cell
        }else if indexPath.row == 1{
           let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TeacherTwoCell.self)
            cell.cellTwoModel = DataModel
           return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TableThreeViewCell.self)
            cell.cellThreeModel = DataModel
            return cell
        }else{
          let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TeacherFourCell.self)
            cell.cellThreeModel = DataModel
            return cell
      }
   }
       
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
       
     }

    

}
