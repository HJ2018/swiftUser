//
//  DoosModel.swift
//  DOOS
//
//  Created by jie.huang on 24/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import HandyJSON



//用户名登录
struct loginModel: HandyJSON {
    var token:  String?
    var member: memberModel?
    
}
struct memberModel: HandyJSON {
    
    var id:  String?
    var nickName: String?
    var sex:  String?
    var sign: String?
    var coverUrl: String?
    var level: String?
    var headUrl: String?
    var mobile: String?
    var realName: String?
    var registerIp: String?
    var email: String?
    var lastLoginTime: String?
    var lastLoginIp: String?
    var registerTime: String?
    var address: String?
}

struct UpDateUserModel: HandyJSON {
    
    var id:  String?
    var nickName: String?
    var sex:  String?
    var sign: String?
    var coverUrl: String?
    var level: String?
    var headUrl: String?
    var mobile: String?
    var school: String?
    var realName: String?
    var registerIp: String?
    var email: String?
    var lastLoginTime: String?
    var lastLoginIp: String?
    var registerTime: String?
    var address: String?
}






extension Array: HandyJSON{}

struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String?
    var data: T?
    var code: Int = 0
    var timestamp:String?
}


//用户资料
struct Userdata : HandyJSON {
    
    var nickName: String!                 // 用户姓名
    var sex: genderType!               // 性别 0男 1女
    var school: String!                   // 学校
    var headUrl: String!               // 头像
    var grade: String!             // 年级
}

enum genderType: Int,HandyJSONEnum {
    case 男 = 0
    case 女 = 1
}
