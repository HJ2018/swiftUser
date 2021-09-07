//
//  SearchDetilsViewController.swift
//  DOOS
//
//  Created by jie.huang on 15/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit

class SearchDetilsViewController: YNSearchViewController, YNSearchDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        let demoCategories = ["数学", "安徽大学硕士", "语文", "家教", "合工大老师", "1对1物理家教", "化学"]
        
        let ynSearch = YNSearch()
        ynSearch.setCategories(value: demoCategories)
        self.ynSearchinit()

        ynSearchView.ynSearchMainView.redrawSearchHistoryButtons()
        
        self.delegate = self
        self.sh_prefersNavigationBarHidden = true

        self.setYNCategoryButtonType(type: .zdyColor)
        
        let backBtn = UIButton(frame: CGRect(x: 10, y: kStatusBarHeight + 12, width: 40, height: 40))
        backBtn.setImage(UIImage(named: "navigationButtonReturn"), for: .normal)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        view.addSubview(backBtn)
    }
    
    @objc func back(){
        
        topVC?.navigationController?.popViewController(animated: true)
    }
    
    func ynSearchListViewDidScroll() {
            self.ynSearchTextfieldView.ynSearchTextField.endEditing(true)
       }
       

       func ynSearchHistoryButtonClicked(text: String) {
           self.pushViewController(text: text)
           print(text)
       }
       
       func ynCategoryButtonClicked(text: String) {
           self.pushViewController(text: text)
           print(text)
       }
       
       func ynSearchListViewClicked(key: String) {
           self.pushViewController(text: key)
           print(key)
       }
       
       func ynSearchListViewClicked(object: Any) {
           print(object)
       }
       
       func ynSearchListView(_ ynSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = self.ynSearchView.ynSearchListView.dequeueReusableCell(withIdentifier: YNSearchListViewCell.ID) as! YNSearchListViewCell
           if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel {
               cell.searchLabel.text = ynmodel.key
           }
           
           return cell
       }
       
       func ynSearchListView(_ ynSearchListView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel, let key = ynmodel.key {
               self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(key: key)
               self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(object: self.ynSearchView.ynSearchListView.database[indexPath.row])
               self.ynSearchView.ynSearchListView.ynSearch.appendSearchHistories(value: key)
           }
       }
       
       func pushViewController(text:String) {
        
        let vc = SearchTeacherTableController()
        vc.searchConten = text
        navigationController?.pushViewController(vc, animated: true)
       }

}
