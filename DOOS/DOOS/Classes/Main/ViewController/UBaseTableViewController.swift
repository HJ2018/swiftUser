//
//  UBaseTableViewController.swift
//  DOOS
//
//  Created by jie.huang on 28/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit

class UBaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = UIColor.background
       if #available(iOS 11.0, *) {
           UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
       } else {
           automaticallyAdjustsScrollViewInsets = false
       }
      
       configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            configNavigationBar()
        }
        
        func configUI() {}
        
        func configNavigationBar() {
            guard let navi = navigationController else { return }
            if navi.visibleViewController == self {
               navi.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
                navi.barStyle(.theme)
//                navi.disablePopGesture = false
//                navi.setNavigationBarHidden(false, animated: true)
                if navi.viewControllers.count > 1 {
                    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationButtonReturn"), style: .plain, target: self, action: #selector(pressBack))
                }
            }
        }
        
        @objc func pressBack() {
            navigationController?.popViewController(animated: true)
        }


}

extension UBaseTableViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
}
