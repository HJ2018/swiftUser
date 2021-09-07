//
//  DoosNetAPI.swift
//  DOOS
//
//  Created by jie.huang on 24/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Moya
import HandyJSON
import MBProgressHUD
import FCUUID



enum errorCode: Int {
    case SUCCESS = 200
    case ERROR = 401
}

let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended:
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<DoosApi>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let ApiProvider = MoyaProvider<DoosApi>(requestClosure: timeoutClosure)
let ApiLoadingProvider = MoyaProvider<DoosApi>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])


enum DoosApi {
    
//    验证码登录
    case login(state : String , mobile : String , password : String , code : String)
//    获取验证码
    case getSendSms(type : String , mobile : String)
//    验证手机验证码
    case authCode(code : String , type : String , mobile : String)
//    修改用户资料
    case updateUser(genderType : Userdata)
//    修改手机号
    case updateMobile(code : String , mobile : String)
//    用户上传头像接口
    case uodateHeadImage(resource : String ,file : String)
//    获取用户个人信息
    case getUserData
//    退出登录
    case exit
//    找回密码
    case getPassword(code : String , type : String , phone : String , password : String)
//    获取最新版本接口
    case checkUpdate(deviceCode : String)
//    意见反馈
    case feedback(content : String , otherContent : String)
//    首页数据获取接口
    case getHomeData
//    教员详情
    case getTeactherDetils(ID : String)
//    获取更多评论
    case getcommentList(tutorId : String,tagName : String , pageSize : Int , page : Int)
//    基础接口
    case getSettingData
//    获取老师列表
    case getteachList(Parmerdata : SearchParmer)
}

extension DoosApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://parent.ahduosi.com")!
    }
    
    var path: String {
        switch self {
        case .login: return "/member/login"
        case .getSendSms: return "/auth/sendSms"
        case .authCode: return "/auth/mobileVerification"
        case .updateUser: return "/member/updateBy"
        case .updateMobile: return "/member/updateMobile"
        case .uodateHeadImage: return " /common/file"
        case .getUserData: return "/member/getById"
        case .exit: return "/auth/exit"
        case .getPassword: return "/member/changePassword"
        case .checkUpdate: return "/common/version/checkUpdate"
        case .feedback: return "/common/feedback/submit"
        case .getHomeData: return "/common/home"
        case .getTeactherDetils: return "/tutor/getById"
        case .getcommentList: return "/tutor/commentList"
        case .getSettingData: return "/common/init/dictChildren"
        case .getteachList: return "/tutor/list"
            
        }
    }
    
    
    var method: Moya.Method {return .post}
    
    /// 请求方式 get post put delete
//    var method: Moya.Method {
//        switch self {
//        case .testApi:
//            return .get
//        default:
//            return .post
//        }
//
    
    /// 这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {  return "".data(using: String.Encoding.utf8)!  }
    
    var task: Task {
        var parmeters : [String : Any] = [:]
        
        switch self {
        case let .login(state, mobile, password, code):
            parmeters["state"] = state
            parmeters["mobile"] = mobile
            parmeters["password"] = password
            parmeters["code"] = code
        case let .getSendSms(type, mobile):
            parmeters["type"] = type
            parmeters["mobile"] = mobile
        case let .authCode(code, type, mobile):
            parmeters["code"] = code
            parmeters["type"] = type
            parmeters["mobile"] = mobile
        case let .updateUser(Userdata):
            parmeters["nickName"] = Userdata.nickName
            parmeters["sex"] = Userdata.sex
            parmeters["school"] = Userdata.school
            parmeters["headUrl"] = Userdata.headUrl
            parmeters["grade"] = Userdata.grade
        case let .updateMobile(code, mobile):
            parmeters["code"] = code
            parmeters["mobile"] = mobile
        case let .uodateHeadImage(resource, file):
            parmeters["resource"] = resource
            parmeters["file"] = file
        case .getUserData: break
        case .exit: break
        case let .getPassword(code, type, phone, password):
            parmeters["type"] = type
            parmeters["code"] = code
            parmeters["phone"] = phone
            parmeters["password"] = password
        case let .checkUpdate(deviceCode):
             parmeters["deviceCode"] = deviceCode
        case let .feedback(content, otherContent):
            parmeters["content"] = content
            parmeters["otherContent"] = otherContent
        case .getHomeData:  break
        case let .getTeactherDetils(ID):
             parmeters["tutorId"] = ID
        case let .getcommentList(tutorId, tagName, pageSize, page):
             parmeters["tutorId"] = tutorId
             parmeters["tagName"] = tagName
             parmeters["pageSize"] = pageSize
             parmeters["page"] = page
        case .getSettingData: break
        case let .getteachList(Parmerdata):
            parmeters["sex"] = Parmerdata.sex
            parmeters["subject"] = Parmerdata.subject
            parmeters["grade"] = Parmerdata.grade
            parmeters["experience"] = Parmerdata.experience
            parmeters["priceRange"] = Parmerdata.priceRange
            parmeters["teachingArea"] = Parmerdata.teachingArea
            parmeters["pageSize"] = Parmerdata.pageSize
            parmeters["page"] = Parmerdata.page
        }
        
        return .requestData(jsonToData(jsonDic: parmeters)!)
//        return .requestCompositeData(bodyData: jsonToData(jsonDic: parmeters)!, urlParameters: parmeters)
    }
    
    var headers: [String : String]? {
        
        return ["Content-type" : "application/json" , "deviceCode" : UIDevice.current.uuid() , "deviceType" : "2" , "devicePlatform" : "2" , "accessToken" :  UserDefaults.standard.getToken()]
    }
    
}

func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
    if (!JSONSerialization.isValidJSONObject(jsonDic)) {
        print("is not a valid json object")
        return nil
    }
    let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
    let str = String(data:data!, encoding: String.Encoding.utf8)
    print("Json Str:\(str!)")
    return data
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
    

        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }

        return model
    }
}

extension MoyaProvider {
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ReturnData<T>.self) else {
                completion(nil)
                
                return
            }
            guard returnData.code == errorCode.SUCCESS.rawValue else{
                guard let vc = topVC else { return }
                
                if returnData.code == errorCode.ERROR.rawValue{
                    let vc = topVC!.creatStoryboardVc(StoryboardName: "Main", StoryboardID: "VerificationLoginController")
//                    vc.modalPresentationStyle = .fullScreen
//                    topVC?.present(vc, animated: true, completion: nil)
                    topVC?.navigationController?.pushViewController(vc, animated: true)
                }else{
                   vc.alterMessage(title: "提示", message: returnData.message! as NSString)
                }
                completion(nil)
                return
            }
            
            completion(returnData.data)
        })
    }
}




