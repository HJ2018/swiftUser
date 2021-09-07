//
//  ProfileViewController.swift
//  DOOS
//
//  Created by jie.huang on 26/11/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable
import SVGKit
class ProfileViewController: UPageViewController {

    
   let dataArray = ["我的收藏","推荐有礼","联系我们","关于我们","设置"];
    
    
    let imaegArry = ["wodeshoucang","tuijianyoujiang","mylianxiwomen","guanyuwomen","shezhi"]
    
    private lazy var tableView: UITableView = {
       let tableView = tableViewConfig(CGRect(x: 0, y: -kStatusBarHeight, width:kScreenWidth, height: kScreenHeight + kNavBarHeight + kTabBarHeight), self as UITableViewDelegate, self as UITableViewDataSource, nil)
        tableView.register(cellType:ProfileViewCell.self )
        tableView.rowHeight = 55
        let headView = ProfileHeadView.loadFromNib()
        headView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 225 + kNavBarHeight)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .always
        }
        tableView.tableHeaderView = headView
        let footView = MeFooterView.loadFromNib()
        footView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 260)
        tableView.tableFooterView = UIView()
           return tableView
       }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none;
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ProfileViewCell.self)
        cell.accessoryType = .disclosureIndicator;
        cell.textLabel?.text = "\(dataArray[indexPath.row])"
        cell.imageView?.image = SVGKImage.init(named: imaegArry[indexPath.row]).uiImage
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             tableView.deselectRow(at: indexPath, animated: true)
           
         }
}
