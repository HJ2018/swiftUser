//
//  UIBarButtonItem+Extension.swift
//  JuShareClub
//
//  Created by wangjiayu on 2019/5/13.
//  Copyright © 2019 wangjiayu. All rights reserved.
//

import UIKit

extension UIViewController {
    //    当前控制器
    func getTopVC() -> (UIViewController?) {
        var window = UIApplication.shared.keyWindow
        //是否为当前显示的window
        if window?.windowLevel != UIWindow.Level.normal{
            let windows = UIApplication.shared.windows
            for  windowTemp in windows{
                if windowTemp.windowLevel == UIWindow.Level.normal{
                    window = windowTemp
                    break
                }
            }
        }
        let vc = window?.rootViewController
        return getTopVC(withCurrentVC: vc)
    }
    ///根据控制器获取 顶层控制器
    func getTopVC(withCurrentVC VC :UIViewController?) -> UIViewController? {
        if VC == nil {
            print(" 找不到顶层控制器")
            return nil
        }
        if let presentVC = VC?.presentedViewController {
            //modal出来的 控制器
            return getTopVC(withCurrentVC: presentVC)
        }else if let tabVC = VC as? UITabBarController {
            // tabBar 的跟控制器
            if let selectVC = tabVC.selectedViewController {
                return getTopVC(withCurrentVC: selectVC)
            }
            return nil
        } else if let naiVC = VC as? UINavigationController {
            // 控制器是 nav
            return getTopVC(withCurrentVC:naiVC.visibleViewController)
        } else {
            // 返回顶控制器
            return VC
        }
    }
}

extension UIViewController {
    
    
    /** 添加右侧两个图片按钮 */
      func addLeftBarButtonItem(textStr:String,rightImg:String) {
         
         let btn = UIButton(frame:CGRect(x: 0, y: 0, width: 18, height: 18))
         btn.setImage(UIImage(named: rightImg), for:UIControl.State.normal)
         btn.setTitle(textStr, for: UIControl.State.normal)
         btn.titleLabel?.font = .systemFont(ofSize: 17)
         btn.setTitleColor(UIColor.black, for: .normal)
    btn.addTarget(self,action:#selector(leftBarButtonAction(btn:)),for:.touchUpInside)
        let barBtn = UIBarButtonItem(customView: btn)
           //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,action: nil)
        spacer.width = -10;
           //设置按钮（注意顺序）
        self.navigationItem.leftBarButtonItem = barBtn
      }
      
      /** 导航栏右侧添加一个文字按钮和一个图片按钮 */
      func addRightBarButtonItem(textStr :String,ImgStr:String ){
        let btn = UIButton(frame:CGRect(x: 0, y: 0, width: 18, height: 18))
        btn.setImage(UIImage(named: ImgStr), for:UIControl.State.normal)
        btn.setTitle(textStr, for: UIControl.State.normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17)
        btn.setTitleColor(UIColor.black, for: .normal)
    btn.addTarget(self,action:#selector(rightBarButtonAction(btn:)),for:.touchUpInside)
        let barBtn = UIBarButtonItem(customView: btn)
          //用于消除右边边空隙，要不然按钮顶不到最边上
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil,action: nil)
        spacer.width = -10;
          //设置按钮（注意顺序）
        self.navigationItem.rightBarButtonItems = [spacer,barBtn]
      }
    
    
    func alterMessage(title : NSString , message : NSString) {
        
        let alertController = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        
        
        let otherAction = UIAlertAction(title: "知道了", style: UIAlertAction.Style.cancel) { ( alertAction : UIAlertAction) in
            print("取消")
        }
        
        alertController.addAction(otherAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func alterMessage(title : NSString , message : NSString , handler: @escaping () -> Void)  {
        
         let alertController = UIAlertController(title: title as String, message: message as String, preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { ( alertAction : UIAlertAction) in
            print("取消")
        }
        let ConfirmAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default) { ( alertAction : UIAlertAction) in
            handler()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(ConfirmAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func SheetMessage(title : NSString , selectarry : [Any]) {
        
    }
    
    func creatStoryboardVc(StoryboardName : String , StoryboardID : String) -> UIViewController {
           let storyboard = UIStoryboard(name: StoryboardName, bundle: nil)
           let vc = storyboard.instantiateViewController(withIdentifier: StoryboardID)
           return vc
       }

}
// MARK: - 事件监听
extension UIViewController {
    
    
    @objc func rightBarButtonAction(btn:UIButton) {
        
    }
    
    @objc func leftBarButtonAction(btn:UIButton){
        
    }
}
