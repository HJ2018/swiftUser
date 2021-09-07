//
//  LYDropListView.swift
//  LYDropListView
//
//  Created by discover on 2017/9/28.
//  Copyright © 2017年 LY. All rights reserved.
//

import UIKit

typealias backSearchConten = (_ grade : String , _ subjects : String , _ sex : String , _ exp : String , _ price : String)->Void

class LYDropListView: UIView,UITableViewDelegate,UITableViewDataSource{


   fileprivate var cellid = "cellid"
   lazy  var titleArray = [String]()
   lazy  var tableArray = [[String]]()
    
    
    var sexStr : String! = ""
    
    var expStr : String! = ""
    
    var picStr : String! = ""
    
    var selIndex : Int = 100
    
    var backSearchConten:backSearchConten?
    
//年级
    let arr1 : [String] = ["一年级","二年级","三年级","四年级","五年级","六年级"]
    let arr2 : [String] = ["初一","初二","初三"]
    let arr3 : [String] = ["高一","高二","高三"]
    
//    科目
    let arr4 : [String] = ["地理","化学","历史","生物","数学","物理","英语","语文","政治"]
    
//    筛选
    let arr5 : [String] = ["男","女"]
    let arr6 : [String] = ["1-3年","3-5年","5-10年","10年以上"]
    let arr7 : [String] = ["100元-200元","200元-400元","400元以上"]
    
    var arrylianji : [[String]] = []
    var arrykenu : [[String]] = []
    var arrySx : [[String]] = []
    
    var isSel : Bool?
    
    lazy var bottomView:UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 50))
        view.backgroundColor = UIColor.white
        let btn1 = UIButton(frame: CGRect(x: 0, y: 0, width: kScreenWidth/2, height: 50))
        btn1.setTitle("重置", for: .normal)
        
        btn1.backgroundColor = UIColor.init(r: 224, g: 224, b: 224)
        let btn2 = UIButton(frame: CGRect(x: kScreenWidth/2, y: 0, width: kScreenWidth/2, height: 50))
        btn2.setTitle("确定", for: .normal)
        btn2.backgroundColor = UIColor.MainColor
        view.addSubview(btn1)
        view.addSubview(btn2)
        
        btn1.addTarget(self, action: #selector(btn1Click), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(btn2Click), for: .touchUpInside)
        return view
    }()

    
    @objc func btn1Click(){
        
        print("12334")
        
        isSel = true
        let tableView = self.viewWithTag(100+2) as! UITableView
        tableView.reloadData()
        
    }
    
    @objc func btn2Click(){
        
        isSel = false
        print("23244")
        
        let tableView = self.viewWithTag(100+2) as! UITableView
        tableView.reloadData()
        
        let drop = self.viewWithTag(tableView.tag-100+1000) as! LYDropListTItleView
        drop.isSelected = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute:{
            
            UIView.animate(withDuration: 0.2, animations: {
                tableView.frame = CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 0)
                self.maskViewSS?.alpha = 0
                self.height = 40
            }, completion: { (idCom) in
                self.maskViewSS?.removeFromSuperview()
            })
        })

    }
    var maskViewSS:UIView?
    var selectClosure:((_ tag:Int,_ row:Int)->Void)?
    init(frame: CGRect,tableArr:[[String]],selectClosure : @escaping (_ tag:Int,_ row:Int)->Void) {
        super.init(frame: frame)
//        self.titleArray = tableArr.map({ (arr) -> String in
//            return arr[0]
//        })
        self.titleArray = ["年级","科目","筛选"]
        self.tableArray = tableArr
        self.selectClosure = selectClosure
        self.backgroundColor = UIColor.white
        self.setTitleButton()
        setMaskView()
        setTableView()
        
        arrylianji.append(arr1)
        arrylianji.append(arr2)
        arrylianji.append(arr3)
        arrykenu.append(arr4)
        arrySx.append(arr5)
        arrySx.append(arr6)
        arrySx.append(arr7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setMaskView(){
        maskViewSS = UIView.init(frame: CGRect.init(x: 0, y: 40, width: kScreenWidth, height: kScreenHeight-40-kNaviHeight))
        maskViewSS?.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.3)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))

        maskViewSS?.alpha = 0
        maskViewSS?.addGestureRecognizer(tap)
        
    }
    @objc func tapAction(){
//        self.maskViewSS?.removeFromSuperview()
        for i in 0..<self.tableArray.count{
            let tableView = self.viewWithTag(100+i) as! UITableView
            let drop = self.viewWithTag(1000+i) as! LYDropListTItleView
            
            if tableView.frame.height>1{
                drop.isSelected = false
                self.height = 40
                UIView.animate(withDuration: 0.2, animations: {
                    tableView.frame = CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 0)
                    self.maskViewSS?.alpha = 0
                }, completion: { (idCom) in
                    self.maskViewSS?.removeFromSuperview()
                })
                
            }
        }
    }
    func setTitleButton(){
        let totalArry:Array<Array<String>>  = self.tableArray
        let width:CGFloat = kScreenWidth/CGFloat(titleArray.count)
        
        for i in 0..<self.titleArray.count{
            let view = LYDropListTItleView.init(frame: CGRect.init(x: CGFloat(i)*width, y: 0, width: width, height: 40), title: titleArray[i])
            view.tag = 1000+i
            view.gesClosure = { (select)->Void in
                self.insertSubview(self.maskViewSS!, at: 0)
                UIView.animate(withDuration: 0.2, animations: {
                    self.maskViewSS?.alpha = 1
                })
                if select {
                    
                    for n in 0..<self.titleArray.count {
                        let drop = self.viewWithTag(1000+n) as! LYDropListTItleView
                        let tableView = self.viewWithTag(100+n) as! UITableView
                        if i == n {
                            drop.isSelected = true
                                                        
                        }else{
                            drop.isSelected = false
                        }
                        let arr = totalArry[n] as [String]
                        tableView.reloadData()
                      
                        if i == n {
                            
                            var H : CGFloat = 0
                            
                            if self.titleArray[i] == "年级" {
                                H = self.CellHeight(arr: self.arr1) + self.CellHeight(arr: self.arr2) + self.CellHeight(arr: self.arr3)
                            }
                            
                            if self.titleArray[i] == "科目" {
                                H = self.CellHeight(arr: self.arr4)
                            }
                            if self.titleArray[i] == "筛选" {
                                
                               H = self.CellHeight(arr: self.arr5) + self.CellHeight(arr: self.arr6) + self.CellHeight(arr: self.arr7) + 40
                                
                           }
                            
                            UIView.animate(withDuration: 0.2, animations: {
                                tableView.frame = CGRect.init(x: 0, y: 40, width: kScreenWidth, height: H + 10)
                                 
                            }) { (errer) in
                                self.height = H + 50
                            }

                        }else{
                            
                            UIView.animate(withDuration: 0.2, animations: {
                                tableView.frame = CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 0)
                            })
                            
                        }
                        
                        
                        
                    }
                    
                }else{
                  
                    
                    
                    let tableView = self.viewWithTag(100+i) as! UITableView

                    UIView.animate(withDuration: 0.2, animations: {
                        tableView.frame = CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 0)
                        self.maskViewSS?.alpha = 0
                    }, completion: { (idCom) in
                        self.height = 40
                        tableView.reloadData()
                        self.maskViewSS?.removeFromSuperview()
                    })
                    
                }
                
            }
            self.addSubview(view)
            
        }
    }
    func setTableView(){
        let totalArry:Array<Array<String>>  = self.tableArray
        
        
        
        for i in 0..<totalArry.count{
        
            let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 0), style: .plain)
            
//            tableView.bounces = false
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tag = 100+i
            tableView.backgroundColor = UIColor.white
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
//            tableView.register(cellType: ScreenTableViewCell.self)
            tableView.isScrollEnabled = false
            tableView.separatorStyle = .none
            if i == 2 {
                tableView.tableFooterView = self.bottomView
            }
            self.addSubview(tableView)
            
            
            
            
        }
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var view = super.hitTest(point, with: event)
        if view == nil {
            for subView in self.subviews {
                let tp = subView.convert(point, from: self)
                if subView.bounds.contains(tp) {
                    view = subView
                }
            }
        }
        return view
    }

    
    
}
extension LYDropListView{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let strNmae = tableArray[tableView.tag - 100][indexPath.row]
        if  strNmae == "小学" {
            return CellHeight(arr: arr1)
        }else if  strNmae == "初中"{
             return CellHeight(arr: arr2)
        }else if  strNmae == "高中"{
             return CellHeight(arr: arr3)
        }else if strNmae == "科目"{
           return CellHeight(arr: arr4)
        }else if strNmae == "性别"{
           return CellHeight(arr: arr5)
        }else if strNmae == "教学经验"{
            return CellHeight(arr: arr6)
        }else if strNmae == "价格"{
           return CellHeight(arr: arr7)
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let drop = self.viewWithTag(tableView.tag-100+1000) as! LYDropListTItleView
        if drop.isSelected == nil {
            return 0
        }else{
            return  drop.isSelected! ? self.tableArray[tableView.tag-100].count : 0
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: String(format: "%ld", indexPath.row)) as? ScreenTableViewCell
        if cell == nil {
            cell = ScreenTableViewCell.init(style: .default, reuseIdentifier: String(format: "%ld", indexPath.row))
        }
    
        cell?.selectionStyle = .none
        let strNmae = tableArray[tableView.tag - 100][indexPath.row]
        cell?.NameLabel.text = strNmae
        
        
        if (tableView.tag - 100) == 0 {
            cell?.contnetArr = arrylianji[indexPath.row]
            cell?.isAll = false
            
            if indexPath.row == 0 {

                if selIndex == 1 || selIndex == 2{
                    for btn in (cell?.Sv!.AllBtn)! {
                        btn.isSelected = false
                    }
                }
                
            }else if indexPath.row == 1{
               
                 if selIndex == 0 || selIndex == 2{
                    
                     for btn in (cell?.Sv!.AllBtn)! {
                         btn.isSelected = false
                     }
                 }
                
            }else if indexPath.row == 2{
                
                if selIndex == 1 || selIndex == 0{
                    
                    for btn in (cell?.Sv!.AllBtn)! {
                        btn.isSelected = false
                    }
                    
                }
            }
            
            
            cell?.backSearch = { (name , row)->Void in
                self.updata(tableView: tableView, name: name, index: indexPath.row)
                
                if self.backSearchConten != nil{
                    for btn in (cell?.Sv!.AllBtn)! {
                       
                        if btn.isSelected {
                            self.backSearchConten!(btn.titleLabel!.text! , "" , "" ,"" ,"" )
                        }
                    }
                }
                
              self.selIndex = row
                
                
                
            }
        }else if (tableView.tag - 100) == 1{
            cell?.contnetArr = arrykenu[indexPath.row]
            cell?.isAll = false
            cell?.backSearch = { (name , row)->Void in
                self.updata(tableView: tableView, name: name, index: indexPath.row)
                
                if self.backSearchConten != nil{
                    for btn in (cell?.Sv!.AllBtn)! {
                       
                        if btn.isSelected {
                            self.backSearchConten!("", btn.titleLabel!.text! , "" ,"" ,"" )
                        }
                    }
                }
            }
        }else if (tableView.tag - 100) == 2{
            cell?.contnetArr = arrySx[indexPath.row]
            cell?.isAll = true
            if isSel == true {
                for btn in (cell?.Sv!.AllBtn)! {
                  btn.isSelected = false
                }
            }
            
            if indexPath.row == 0 {
                for btn in (cell?.Sv!.AllBtn)! {
                    if btn.isSelected {
                        sexStr = btn.titleLabel?.text
                    }
                }
            }else if indexPath.row == 1{
                for btn in (cell?.Sv!.AllBtn)! {
                    if btn.isSelected {
                        expStr = btn.titleLabel?.text
                    }
                }
            }else if indexPath.row == 2{
                for btn in (cell?.Sv!.AllBtn)! {
                    if btn.isSelected {
                        picStr = btn.titleLabel?.text
                    }
                }
            }
            
            if self.backSearchConten != nil{
                self.backSearchConten!("","" ,sexStr,expStr,picStr)
                sexStr = ""
                expStr = ""
                picStr = ""
            }
            
//            cell?.backSearch = { (name , row)->Void in
//                self.updata(tableView: tableView, name: name, index: indexPath.row)
//            }
        }
        
        

        return cell!
    }
    
    func updata(tableView : UITableView , name : String , index : NSInteger){
        let drop = self.viewWithTag(tableView.tag-100+1000) as! LYDropListTItleView
                      
        drop.title  = name
        if self.selectClosure != nil {
            self.selectClosure!(tableView.tag,index)
        }
        drop.isSelected = false
              
        self.height = 40
        UIView.animate(withDuration: 0.2, animations: {
                tableView.frame = CGRect.init(x: 0, y: 40, width: kScreenWidth, height: 0)
               self.maskViewSS?.alpha = 0
        }, completion: { (idCom) in
            self.maskViewSS?.removeFromSuperview()
        })
    }
    
    func CellHeight(arr : [String]) -> CGFloat{
       return SearchSView.creat(frame: CGRect.zero, titleArr:arr).height + 40
    }
}



