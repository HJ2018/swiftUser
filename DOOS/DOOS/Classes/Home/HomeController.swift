//
//  HomeController.swift
//  DOOS
//
//  Created by jie.huang on 14/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit

class HomeController: UBaseViewController  {

    
    var HomeData : HomeDataModel?
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width:kScreenWidth, height: kScreenHeight - kNavBarHeight - kTabBarHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
//        tableView.backgroundColor = UIColor.red
        tableView.register(cellType:HomeTableCell.self )
        tableView.register(cellType:BannerTableViewCell.self )
        tableView.register(cellType: MoreTableCell.self)
        tableView.DHead = URefreshHeader { [weak self] in self?.getData() }
           return tableView
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        getData()
        
        getSettingData()
        
        
        let Homesearch = SearchBarText()
        Homesearch.frame = CGRect(x: 0, y: 8, width: kScreenWidth - 100, height: 36)
        navigationItem.titleView = Homesearch
        

        let btn = UIButton()
        btn.isUserInteractionEnabled = true
        btn.frame = CGRect(x: 0, y: 0, width: kScreenWidth - 100, height: 32)
        Homesearch.addSubview(btn)
        btn.addTapGesture { (tap) in
        self.navigationController?.pushViewController(SearchDetilsViewController(), animated: true)
        }
    
        
    }

    
    
    func getSettingData(){
        
        ApiProvider.request(DoosApi.getSettingData, model: AppSettingModel.self) { (returnSetting) in
            
            AppSetting.share.SettingInfo = returnSetting
        }
    }
    
    
     @objc private func getData(){
        
        ApiLoadingProvider.request(DoosApi.getHomeData, model: HomeDataModel.self) { (homeData) in
            self.tableView.DHead.endRefreshing()
            self.HomeData = homeData
            self.tableView.reloadData()
        }
        
    }
    
    
}

extension HomeController : UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int { return 2 }
    
   func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 110: 0
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let menuSectionHeaderView = groupHeadView.loadFromNib()
            menuSectionHeaderView.frame = CGRect(x:0,y:0,width:kScreenWidth,height:110)
            menuSectionHeaderView.backgroundColor = UIColor.white
            menuSectionHeaderView.subjectsModel = HomeData?.subjects
            menuSectionHeaderView.GroupCollectionView.reloadData()
            return menuSectionHeaderView
        }else{return nil}
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
          return indexPath.section == 0 ? 140 + 45 + 15 : indexPath.row == 0 ? 44 : 165
         }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section < 1 ? 1 : (HomeData?.tutorList!.count ?? 0) + 1
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.section == 1 && indexPath.row > 0 {
            let vc = TeatherDetailsController()
            vc.TeacherID = HomeData?.tutorList?[indexPath.row - 1].id
            navigationController?.pushViewController(vc, animated: true)
        }
        
     }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BannerTableViewCell.self)
            cell.BannerModel = HomeData?.activityList ?? []
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MoreTableCell.self)
                cell.selectionStyle = .none
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeTableCell.self)
                cell.teacherModel = HomeData?.tutorList?[indexPath.row - 1]
                return cell
            }
             
        }
        
    }
}

