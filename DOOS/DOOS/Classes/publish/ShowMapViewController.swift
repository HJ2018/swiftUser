//
//  ShowMapViewController.swift
//  AMapPositionDemo
//
//  Created by lifubing on 16/11/25.
//  Copyright © 2016年 lifubing. All rights reserved.
//

import UIKit
import MapKit
typealias searchMapPOI = (_ Map : AMapPOI)->Void
typealias searchMapTip = (_ Map : AMapTip)->Void
class ShowMapViewController: UIViewController, MAMapViewDelegate, AMapSearchDelegate,UISearchBarDelegate {

    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var mainViews: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var tapLocationBut: UIButton!
    
    var mapView: MAMapView!
    var dataArray: NSMutableArray!
    var searchDataArray: NSMutableArray!
    var currentLocation: CLLocation!
    var search: AMapSearchAPI!
    
    var searchMapTip:searchMapTip?
    var searchMapPOI:searchMapPOI?

    var didStopLocating:Bool = false
    var _searchResult:UITableView?
    
    var cityCode : String!
    
    var searchResult: UITableView? {
        
        get{
            if _searchResult != nil {
                if !self.mainViews.isDescendant(of: _searchResult!) {
                    self.mainViews.addSubview(_searchResult!)
                }
            }else {
                
                self._searchResult = UITableView.init(frame:self.mainViews.bounds)
                self._searchResult?.register(UINib.init(nibName: "tableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCellID")
                self._searchResult?.delegate = self
                self._searchResult?.dataSource = self
                self._searchResult?.tag = 10
                self.mainViews.addSubview(self._searchResult!)
                self.mainViews.bringSubviewToFront(self._searchResult!)

            }
            
            return _searchResult
        }
    }
    
    //MARK:- viewload - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "tableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCellID")
        
        dataArray = NSMutableArray()
        searchDataArray = NSMutableArray()
        initSearchBar()
        initSearch()
        initMapView()
    }

    //MARK:- Initialization - 初始化操作
    
    func initMapView() {
        mapView = MAMapView(frame: self.midView.bounds)
        mapView.showsCompass = false
        mapView.zoomLevel = 15.1
        mapView.distanceFilter = 100.0
        
        mapView.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.showsScale = false
        mapView.logoCenter = CGPoint(x: self.mapView.frame.size.width-mapView.logoSize.width + 25, y: self.mapView.frame.size.height-mapView.logoSize.height+5)
        mapView.mapType = .standard
        mapView.delegate = self
        self.midView.addSubview(mapView)
        self.midView.bringSubviewToFront(self.arrowImageView)
        self.midView.bringSubviewToFront(self.tapLocationBut)
        
    }
    
    func setMapView() {
        
    }
    
    func initSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        UISearchBar.appearance().tintColor = UIColor.black
        
        let view: UIView = self.searchBar.subviews[0] as UIView
        for subView: UIView in view.subviews {
            if subView is UITextField{
                subView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            if subView is UIButton {
                subView.backgroundColor = UIColor.red
            }
        }
    }
    func initSearch() {
        search = AMapSearchAPI()
        search.delegate = self
    }
    func initSearChs() {
        if currentLocation == nil || search == nil {
            return
        }
        
        searchPOI(loca: currentLocation)
    }
    
    //MARK:- searchPOI By CLLocation  根据地理坐标搜索
    func searchPOI(loca:CLLocation) {
        let request = AMapPOIAroundSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(loca.coordinate.latitude), longitude: CGFloat(loca.coordinate.longitude))
        request.types = "风景名胜|商务住宅|政府机构及社会团体|交通设施服务|道路附属设施|地名地址信息|高等院校|住宅"
        request.sortrule = 0
        request.offset = 30
        request.requireExtension = true
        search.delegate = self
        search.aMapPOIAroundSearch(request)
    }
    
    //MARK:- AMapSearchDelegate  POI查询回调函数
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.pois.count == 0 {
            return
        }
        dataArray = NSMutableArray.init(array: response.pois)
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
    
    // MARK: tableView delegate

    
    
    // MARK :MAMapViewDelegate 回调
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        self.currentLocation = userLocation.location
//        print("-------- didUpdate userLocation ---------")
//        if currentLocation == nil {
//            initSearChs()
//        }
    }
    
    func mapView(_ mapView: MAMapView!, didSelect view: MAAnnotationView!) {
        if view.annotation is MAUserLocation {
            tapAction()
        }
    }
    
    func mapView(_ mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {
        
        if didStopLocating {
        
            searchPOI(loca: CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude))
            
            let cor : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            searchReGeocodeWithCoordinate(coordinate:cor)

        }
        
    }
    
    func mapView(_ mapView: MAMapView!, mapWillMoveByUser wasUserAction: Bool) {
        didStopLocating = false
    }
    
    func mapView(_ mapView: MAMapView!, mapDidMoveByUser wasUserAction: Bool) {
        didStopLocating = true
    }
    
    func searchReGeocodeWithCoordinate(coordinate: CLLocationCoordinate2D!) {
        let regeo: AMapReGeocodeSearchRequest = AMapReGeocodeSearchRequest()
        regeo.location = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.latitude), longitude: CGFloat(coordinate.longitude))
        self.search!.aMapReGoecodeSearch(regeo)
    }
    
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        
        var str = response.regeocode.addressComponent.city;
        cityCode = response.regeocode.addressComponent.citycode
        if str != nil {
            str = response.regeocode.addressComponent.province
        }
        self.mapView.userLocation.title = str;
        self.mapView.userLocation.subtitle = response.regeocode.formattedAddress
    }
    
    // MARK: search delegate 搜索结果的回调
    func onInputTipsSearchDone(_ request: AMapInputTipsSearchRequest!, response: AMapInputTipsSearchResponse!) {
        
        if response.count == 0 {
            return
        }
        self.searchDataArray = NSMutableArray.init(array: response.tips)
        self.searchResult?.reloadData()
    }
    

    // MARK: UISearchBarDelegate UISearchBar的代理
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchArround(str: searchBar.text!)
        print(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false

        searchBar.resignFirstResponder()
        searchBar.text = ""
        if _searchResult == nil {
            return
        }
        self.searchResult?.removeFromSuperview()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        self.searchDataArray = self.dataArray
        self.searchResult?.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if searchBar.text == "" {
            searchBar.showsCancelButton = false
        }
    }

    // MARK :scrollView delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    // MARK :help func
    func tapAction (){
        
        if ((self.currentLocation) != nil) {
            let request = AMapReGeocodeSearchRequest()
            request.location = AMapGeoPoint.location(withLatitude: CGFloat(self.currentLocation.coordinate.latitude
            ), longitude: CGFloat(self.currentLocation.coordinate.longitude))
            
            search.aMapReGoecodeSearch(request)
        }
    }
    
    func searchArround(str:String){
        let tips = AMapInputTipsSearchRequest()
        tips.keywords = str;
        tips.city     = cityCode;
        tips.types = "风景名胜|商务住宅|政府机构及社会团体|交通设施服务|道路附属设施|地名地址信息|高等院校|住宅"
//        tips.cityLimit = true; //是否限制城市 。
        self.search.aMapInputTipsSearch(tips);
    }
    
    // MARK :Target
    @IBAction func tapped(_ sender: Any) {
        if self.currentLocation == nil {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.mapView.centerCoordinate = CLLocationCoordinate2D(latitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude)
            self.mapView.showsCompass = false
            self.mapView.zoomLevel = 15.1
            self.tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        })
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
