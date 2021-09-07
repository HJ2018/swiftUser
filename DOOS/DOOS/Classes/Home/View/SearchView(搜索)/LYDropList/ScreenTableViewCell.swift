//
//  ScreenTableViewCell.swift
//  LYDropListView
//
//  Created by jie.huang on 13/1/2020.
//  Copyright © 2020 LY. All rights reserved.
//

import UIKit
import Reusable

typealias backSearch = (_ name : String , _ row : Int)->Void

class ScreenTableViewCell: UITableViewCell,NibReusable {

    
    let arr1 : [String] = ["一年级","二年级","三年级","四年级","五年级","六年级"]
    let arr2 : [String] = ["初一","初二","初三"]
    let arr3 : [String] = ["高一","高二","高三"]
    
    var NameLabel: UILabel!
    
     var Sv : SearchSView? = nil
    
     var isAll : Bool?
    
     var backSearch:backSearch?
    
    var contnetArr : [String]? {didSet {
    
        
        if Sv == nil {
            let rect = CGRect(x: 15, y: 40, width: kScreenWidth - 30 , height: 0)
            Sv = SearchSView.creat(frame: rect, titleArr:contnetArr!)
            Sv!.delegate = self
            self.contentView.addSubview(Sv!)
        }
       
    }
    }

    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        NameLabel = UILabel()
        NameLabel.frame = CGRect(x: 15, y: 15, width: 100, height: 20)
        self.addSubview(NameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension ScreenTableViewCell:SearchButtonDelegate{

    
    func searchHistory(index: Int, selBtn: UIButton) {
        
        
        var row : Int = 0
        if arr1.contains(contnetArr![index]) {
            row = 0
        }else if arr2.contains(contnetArr![index]){
            row = 1
        }else if arr3.contains(contnetArr![index]){
            row = 2
        }
      
        if (self.backSearch != nil){
            self.backSearch!(contnetArr![index] , row)
        }
    }
}
