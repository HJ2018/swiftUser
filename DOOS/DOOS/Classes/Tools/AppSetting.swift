//
//  AppSetting.swift
//  DOOS
//
//  Created by jie.huang on 24/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

func clearData() {
    
    UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userID.rawValue)
    UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.token.rawValue)
}
enum UserDefaultsKeys : String {
    case isLoggedIn
    case userID
    case token
}

extension UserDefaults{
    
    //MARK: Check Login
     func setLoggedIn(value: Bool) {
         set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
         //synchronize()
     }

     func isLoggedIn()-> Bool {
         return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
     }

     //MARK: Save User Data
     func setUserID(value: Int){
         set(value, forKey: UserDefaultsKeys.userID.rawValue)
         //synchronize()
     }

     //MARK: Retrieve User Data
     func getUserID() -> Int{
         return integer(forKey: UserDefaultsKeys.userID.rawValue)
     }
    
//    token
    func setToken(value : String) {
        set(value, forKey: UserDefaultsKeys.token.rawValue)
    }
    func getToken() ->String{
        return string(forKey: UserDefaultsKeys.token.rawValue) ?? ""
    }
}


//Save in UserDefaults where you want
//UserDefaults.standard.setLoggedIn(value: true)          // Bool
//UserDefaults.standard.setUserID(value: result.User.id!) // String


//Retrieve data anywhere in app
//print("ID : \(UserDefaults.standard.getUserID())")
//UserDefaults.standard.getUserID()


//Remove Values
//UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userID)



@objc class AppSetting: NSObject{
    
    
    var SettingInfo:AppSettingModel? = nil
    
    
    static let sex = "dict_sex"
    static let exp = "doos_experience"
    static let pic = ""

    @objc static let share = AppSetting()

    override init()
    {
         SettingInfo = AppSettingModel()
    }

}



struct SubjectList :HandyJSON {
       var name: String?
       var value: String?
       var subjectList: [String]?
}

struct Doos_teachType :HandyJSON {
       var name: String?
       var value: String?
       var remark: String?
}

struct Doos_degreeType :HandyJSON {
       var name: String?
       var value: String?
       var remark: String?
}

struct Doos_experience :HandyJSON {
       var name: String?
       var value: String?
       var remark: String?
}

struct Doos_sex :HandyJSON {
       var name: String?
       var value: String?
       var remark: String?
}

struct Dict :HandyJSON {
       var doos_teachType: [Doos_teachType]?
       var doos_degreeType: [Doos_degreeType]?
       var doos_experience: [Doos_experience]?
       var doos_sex: [Doos_sex]?
}

struct AppSettingModel :HandyJSON {
       var subjectList: [SubjectList]?
       var dict: Dict?
}


