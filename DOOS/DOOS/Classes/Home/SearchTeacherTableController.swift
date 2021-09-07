//
//  SearchTeacherTableController.swift
//  DOOS
//
//  Created by jie.huang on 13/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit

class SearchTeacherTableController: UBaseViewController {

    
    
    private var TeacherList = [tutorListModel]()
    
    var searchConten : String!
    
    let Arrayone:[String] = ["小学","初中","高中"]
    let Arraytwo:[String] = ["科目"]
    let Arraythree:[String] = ["性别","教学经验","价格"]
    
    
    private var page: Int = 1
    private var pageSize: Int = 20
    
    lazy var dropList:LYDropListView = {
          //传入一个二维数组即可
          let drop = LYDropListView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 40), tableArr: [self.Arrayone,self.Arraytwo,self.Arraythree], selectClosure: { (tag, row) in
              //tag - 100是第几个标题菜单，row是菜单第几行
                print(tag-100,row)
          })
         
          return drop
      }()
    
    private lazy var tableView: UITableView = {
     
     let tableView = UITableView(frame: CGRect(x: 0, y: 40, width:kScreenWidth, height: kScreenHeight - kNavBarHeight - 40), style: .plain)
     tableView.delegate = self
     tableView.dataSource = self
     tableView.separatorStyle = .none
     tableView.register(cellType:HomeTableCell.self )
     tableView.rowHeight = 165
     tableView.DHead = URefreshHeader { [weak self] in self?.loadData(more: false) }
     tableView.DFoot = URefreshFooter { [weak self] in self?.loadData(more: true) }
        return tableView
    }()
    
    
    func removeVc(){

        var  arrVc  = navigationController?.viewControllers
        
        for (i , v) in (arrVc?.enumerated())! {
            
            if v is SearchDetilsViewController{
        
                arrVc?.remove(at: i)
            }
        }
        navigationController?.viewControllers = arrVc!
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        removeVc()
        self.title = "老师"
        view.addSubview(tableView)
        view.addSubview(dropList)
        
        tableView.tableFooterView = UIView()
        
        tableView.register(cellType:HomeTableCell.self )
        
         tableView.DHead.beginRefreshing()
        
        
        let Homesearch = SearchBarText()
        Homesearch.frame = CGRect(x: 0, y: 8, width: kScreenWidth - 100, height: 36)
        navigationItem.titleView = Homesearch
        
        self.dropList.backSearchConten = { (grade , subjects , sex , exp , price)->Void in
            
            print(grade,subjects,sex,exp,price)
        }
        
    }
    
    @objc private func loadData(more: Bool) {
    
        page = (more ? ( page + 1) : 1)
        
        let parmer = SearchParmer(subject: "", sex: "" , grade: "", experience: "", teachingArea: "", priceRange: "", pageSize: pageSize, page: page)
        
        ApiLoadingProvider.request(DoosApi.getteachList(Parmerdata: parmer), model: teachListModel.self) { (returnData) in
            
            self.tableView.DHead.endRefreshing()
            if (returnData?.records!.count) ?? 0 <= 20  {
                self.tableView.DFoot.endRefreshingWithNoMoreData()
            } else {
                self.tableView.DFoot.endRefreshing()
            }
            
            if !more { self.TeacherList.removeAll() }
            
            self.TeacherList.append(contentsOf: returnData?.records ?? [])
            
            self.tableView.reloadData()
            
        }
        
        
        self.tableView.DHead.endRefreshing()
    }

}
extension SearchTeacherTableController : UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
       
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TeatherDetailsController()
        vc.TeacherID = TeacherList[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
       
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return TeacherList.count
      }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeTableCell.self)
       cell.teacherModel = TeacherList[indexPath.row]
        
           return cell
       }
}
