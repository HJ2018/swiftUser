//
//  UTabBarController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        
 /// 首页
        addChildViewController(HomeController(),
                               title: "首页",
                               image: UIImage(named: "tabbar_home"),
                               selectedImage: UIImage(named: "tabbar_home_highlighted"))
        

         let vc = creatStoryboardVc(StoryboardName: "Main", StoryboardID: "CourseRecordViewController")
        addChildViewController(vc,
                               title: "课程安排",
                               image: UIImage(named: "tabbar_discover"),
                               selectedImage: UIImage(named: "tabbar_discover_highlighted"))

        addChildViewController(MessageTableViewController(),
                               title: "消息",
                               image: UIImage(named: "tabbar_message_center"),
                               selectedImage: UIImage(named: "tabbar_message_center_highlighted"))
        
        
        /// 我的
        let mineVC = ProfileViewController()
        addChildViewController(mineVC,
                               title: "我的",
                               image: UIImage(named: "tabbar_profile"),
                               selectedImage: UIImage(named: "tabbar_profile_highlighted"))
        
        let HJtabBar = BSJTabBar()
        self.setValue(HJtabBar, forKeyPath: "tabBar")
        HJtabBar.publishBtnClick = {(tab : BSJTabBar! , btn : UIButton!) in
//            let publishVC = PublishPagController(titles: ["预约","短期"],vcs: [UWebViewController(url: "https://h5.ahduosi.com"),publishTabController()], pageStyle: .navgationBarSegment)
            let nav = UINavigationController(rootViewController: publishTabController())
            nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
        
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
//            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        addChild(UNavigationController(rootViewController: childController))
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var frame = self.tabBar.frame
        frame.size.height = 53 + kBottomSafeHeight
        frame.origin.y = self.view.frame.size.height - frame.size.height
        self.tabBar.frame = frame
//        self.tabBar.backgroundColor = UIColor.black
//        self.tabBar.barStyle = UIBarStyle.black
    }
}


extension UTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
