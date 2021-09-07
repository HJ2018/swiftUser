//
//  CourseDetatilsController.swift
//  DOOS
//
//  Created by jie.huang on 10/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit

class CourseDetatilsController: UBaseViewController {
    
    var headView : CourseDetailsHeadView! = nil
    
    private lazy var tableView: UITableView = {
    let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:kScreenWidth, height: kScreenHeight - kNavBarHeight), self as UITableViewDelegate, self as UITableViewDataSource, nil)
     tableView.register(cellType:CourseDetailsTbCell.self )
     tableView.tableFooterView = UIView()
     headView = CourseDetailsHeadView.loadFromNib()
     headView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 340  )
     tableView.separatorStyle = .none
     tableView.rowHeight = 220
     tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kStatusBarHeight, right: 0)
     tableView.tableHeaderView = headView
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.headView.progressRing.startProgress(to: 80, duration: 2.0) {
            print("Done animating!")
            }
        }
         title = "课程详情"
         view.addSubview(tableView)
    }

}

extension CourseDetatilsController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CourseDetailsTbCell.self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
        
      }

}
