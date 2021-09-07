//
//  CommentsTableController.swift
//  DOOS
//
//  Created by jie.huang on 10/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit

class CommentsTableController: UBaseTableViewController {
    
    
    private var page: Int = 1
    private var pageSize: Int = 20
    private var tagName:String = ""
    var tutorId:String?
    var DataModel : commentListModel?
    
    var headView : commentsView?
    
    private var CommentList = [CommentDetilsList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "评论列表"
        tableView.register(cellType: commentsTableViewCell.self)
        
//        loadData(more: false)
        
        tableView.tableFooterView = UIView()
        
        tableView.separatorStyle = .none
        
        headView = commentsView.loadFromNib()
   
        tableView.tableHeaderView = headView
        tableView.DHead = URefreshHeader { [weak self] in self?.loadData(more: false) }
        tableView.DFoot = URefreshFooter { [weak self] in self?.loadData(more: true) }
        
        tableView.DHead.beginRefreshing()
    }
    
    
    @objc private func loadData(more: Bool) {
        
         page = (more ? ( page + 1) : 1)
        ApiLoadingProvider.request(DoosApi.getcommentList(tutorId: tutorId!, tagName: tagName, pageSize: pageSize, page: page), model: commentListModel.self) { (returnData) in
            
            self.tableView.DHead.endRefreshing()
            if (returnData?.commentList!.count) ?? 0 <= 20  {
                self.tableView.DFoot.endRefreshingWithNoMoreData()
            } else {
                self.tableView.DFoot.endRefreshing()
            }
            if more == false{
                self.headView?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: (returnData?.HeadH) ?? 0)
                self.headView!.ViewCommenModel = returnData
                self.DataModel = returnData
            }
            if !more { self.CommentList.removeAll() }
            
            self.CommentList.append(contentsOf: returnData?.commentList ?? [])
            self.tableView.reloadData()
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CommentList[indexPath.row].cellH ?? 0
     }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentList.count
      }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: commentsTableViewCell.self)
        cell.selectionStyle = .none
        cell.CellcommentList = CommentList[indexPath.row]
        
           return cell
       }

}

