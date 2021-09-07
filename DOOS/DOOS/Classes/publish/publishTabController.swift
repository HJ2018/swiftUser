//
//  publishTabController.swift
//  DOOS
//
//  Created by jie.huang on 17/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import MapKit
class publishTabController: UBaseViewController,CLLocationManagerDelegate {
    
    private lazy var placeholderTextView : PlaceholderTextView = {
        
        let placeholderTextView = PlaceholderTextView(placeholder: "请输入要求...", placeholderColor: UIColor.lightGray, frame: CGRect(x: 10, y: 5, width: kScreenWidth - 20, height: 150))
    
        placeholderTextView.isShowCountLabel = true
        placeholderTextView.limitWords = 200
        placeholderTextView.isReturnHidden = true
        
        return placeholderTextView
        
    }()
    
    private lazy var hview : PublishHeadView = {
        
       let hview = PublishHeadView.loadFromNib()
        hview.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60)
        return hview
    }()
    
    private lazy var footview : UIView = {
           
          let footview = UIView()
           footview.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 150)
            footview.layer.shadowColor =  UIColor.lightGray.cgColor
            footview.layer.shadowOpacity = 0.15
            footview.layer.shadowRadius = 5.0
            footview.layer.shadowOffset = CGSize.init(width: 0, height: 0)
            footview.layer.cornerRadius = 5
           return footview
       }()
    
    private lazy var locationManager: CLLocationManager = {
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        return locationManager
    }()
    
    
    private lazy var BootmBtn : UIButton = {
        let footBtn = UIButton()
        footBtn.frame = CGRect(x: 0, y: SCREEN_HEIGHT - kTabBarHeight - kNavBarHeight, width: SCREEN_WIDTH, height: kTabBarHeight)
        footBtn.backgroundColor = UIColor.MainColor
        footBtn.setTitle("立即匹配", for: .normal)
        return footBtn
    }()
    
    lazy  var NameArrOne: [String] = {
              
              return ["年级：","科目："]
          }()
    
    private lazy var tableView: UITableView = {
        
       let tableView = UITableView(frame:CGRect(x: 0, y: 0, width:kScreenWidth, height: kScreenHeight - kNavBarHeight - OldTabBarHeight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType:PublishTableCell.self )
        tableView.register(cellType: PublishTwoCell.self)
        tableView.register(cellType: PublishThreeCell.self)
        tableView.tableFooterView = footview
        tableView.separatorStyle = .none
//        tableView.tableHeaderView = hview
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "找家教"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationButtonReturn"), style: .plain, target: self, action: #selector(pressBack(btn:)))
        
       
        hview.PMapBtn.addTapGesture { (tap) in
            
            let vc = topVC!.creatStoryboardVc(StoryboardName: "Main", StoryboardID: "AMap") as! ShowMapViewController
            vc.searchMapPOI = {(mapPIO) in
                self.hview.addressLabel.text = mapPIO.name
            }
            vc.searchMapTip = {(mapTip) in
                self.hview.addressLabel.text = mapTip.name
            }
            topVC!.present(vc, animated: true, completion: nil)
        }
        
        locationManager.startUpdatingLocation()
        
        BootmBtn.addTapGesture { (tap) in
            
            self.alterMessage(title: "提示", message: "发布需求！")
        }
    
        footview.addSubview(placeholderTextView)
        
        view.addSubview(tableView)
        
        view.addSubview(BootmBtn)
        
    }
    
    @objc func pressBack(btn : UIButton){
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
          return .default
      }

}

extension publishTabController : UITableViewDelegate , UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int { return 2 }
    
    
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section < 1 ? 70 : 0
      }
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 50
          
      }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section < 1 {
            return hview
        }else{
            return nil
        }
        
    }
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          
        let titleArr : [String] = ["学生信息","老师信息"]
        let imageArr : [String] = ["xuesheng","laoshi"]
        let Hview = UIView()
        Hview.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50)
        Hview.backgroundColor = UIColor.white
        let imgV = UIImageView()
        imgV.image = UIImage(named:imageArr[section])
        Hview.addSubview(imgV)
        imgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(Hview)
            make.left.equalTo(15)
            make.height.equalTo(25)
            make.width.equalTo(25)
        }
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 55, y: 0, width: SCREEN_WIDTH - 15, height: 50)
        titleLabel.textAlignment = .left
        titleLabel.backgroundColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.text = titleArr[section]
        Hview.addSubview(titleLabel)
        let linView = UIView()
        linView.frame = CGRect(x: 0, y: 50, width: SCREEN_WIDTH, height: 0.5)
        linView.backgroundColor = UIColor.init(r: 230, g: 230, b: 230)
        Hview.addSubview(linView)
        return Hview
        
      }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section < 1 ? 2 : 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.section > 0 ? 60 : 65
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section < 1 {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PublishTwoCell.self)
                return cell
            }else{
               
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PublishTableCell.self)
                cell.Titlelabel.text = "上课频次(周/次):"
                return cell
            }
        }else{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PublishThreeCell.self)
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PublishTableCell.self)
                cell.Titlelabel.text = "教龄: "
                return cell
            }
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
        
      }

}



extension publishTabController{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let changeLocation:NSArray =  locations as NSArray
        let currentLocation = changeLocation.lastObject as! CLLocation
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            
            if error != nil && placemarks != nil{
                if((placemarks?.count)! > 0){
                    let placeMark = placemarks?.first
                    
                    self.hview.addressLabel.text = "\(placeMark?.locality ?? "")\(placeMark?.subLocality ?? "")\(placeMark?.name ?? "")"
                   
                }
            }
        }
    }
}

