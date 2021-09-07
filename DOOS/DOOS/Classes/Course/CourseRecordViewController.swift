//
//  CourseRecordViewController.swift
//  DOOS
//
//  Created by jie.huang on 10/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit

class CourseRecordViewController: UBaseViewController,UITableViewDataSource, UITableViewDelegate, FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate {

    
    var pageCount = 5
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var TopHegith: NSLayoutConstraint!
    
    
    fileprivate let lunarFormatter = LunarFormatter()
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    var strData : String = ""
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        self.calendar.appearance.weekdayTextColor = UIColor.black
        self.calendar.appearance.headerTitleColor = UIColor.black
        self.calendar.appearance.headerDateFormat = "yyyy年MM月"
        self.calendar.locale = NSLocale.init(localeIdentifier: "zh_CN") as Locale;
        
        strData = self.dateFormatter.string(from: Date())
        
        tableView.register(UINib.init(nibName: "CourseDetailsTbCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 29, right: 0)
        self.calendar.select(Date())
               
        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .week
       
       // For UITest
       self.calendar.accessibilityIdentifier = "calendar"

    }
    
    
    // MARK:- UIGestureRecognizerDelegate
      
      func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
          let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
          if shouldBegin {
              let velocity = self.scopeGesture.velocity(in: self.view)
              switch self.calendar.scope {
              case .month:
                  return velocity.y < 0
              case .week:
                  return velocity.y > 0
              }
          }
          return shouldBegin
      }
    
    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
           return self.gregorian.isDateInToday(date) ? "今天" : nil
       }
       
//       func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//           return self.lunarFormatter.string(from: date)
//       }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
           let day: Int! = self.gregorian.component(.day, from: date)
           return day % 5 == 0 ? 1 : 0;
       }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        strData = selectedDates.last ?? ""
        tableView.reloadData()
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
    
    // MARK:- UITableViewDataSource
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        return cell
    }
    
    // MARK:- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(CourseDetatilsController(), animated: true)
    }
    

}



