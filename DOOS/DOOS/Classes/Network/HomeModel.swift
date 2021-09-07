//
//  HomeModel.swift
//  DOOS
//
//  Created by jie.huang on 31/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import HandyJSON


struct HomeDataModel: HandyJSON {
    var activityList: [activityListModel]?
    var subjects: [subjectsModel]?
    var tutorList: [tutorListModel]?
}

struct activityListModel: HandyJSON {
    var imgUrl: String?
    var linkUrl: String?
    var title: String?
}

struct subjectsModel: HandyJSON {
    
    var name: String?
    var value: String?
}

struct tutorListModel: HandyJSON {
    
    var subjects: String?
    var school: String?
    var isAuth: String?
    var id: String?
    var price: String?
    var introduction: String?
    var teachingArea: String?
    var experience: String?
    var headUrl: String?
    var realName: String?
    var sex: String?
    
}


struct TeacherDataModel : HandyJSON {
    
    
   var id: String?
   var experienceDescription: String?
   var headUrl: String?
   var realName: String?
   var school: String?
   var introduction: String?
   var type: Int = 0
   var comment: Comment?
   var level: String?
   var address: String?
   var price: String?
   var teachingArea: String?
   var coverUrl: String?
   var lastLoginTime: String?
   var periodList: [PeriodList]?
   var experience: String?
   var honor: String?
    
    var clleOneH : CGFloat?{
    
        let TextH = textHeight(text: introduction ?? "", fontSize: 14, width: screenWidth - 25.0)
        return (45 + 18 + 15 + 30 + 15 ) + TextH
    }
    var clleTwoH : CGFloat?{
        
        var scH : CGFloat = 0
//        if periodList?.count == 1{
//            scH = 18
//        }else if periodList?.count == 2{
//            scH = 18 + 18
//        }else if periodList?.count == 3{
//           scH = 18 + 18 + 18
//        }
         scH = 18 + 18 + 18
        return 22 + 15 + 10 + 8 + 8 + 15 + 20 + 20 + scH
    }
    var cellThreeH : CGFloat?{
        
         let TextH = textHeight(text: experienceDescription ?? "", fontSize: 14, width: screenWidth - 25.0) + 10
        return 15 + 21 + 10 + 16 + 15 + 20 + 8 + TextH
    }
    
    var cellFourH : CGFloat?{
        
        
        let str : String =  comment!.tagsList ?? ""
        let arr = str.components(separatedBy:",")
        let H = QYPAdaptiveButton.creat(frame: CGRect.zero, titleArr:arr).height
        
        let TextH1 = textHeight(text: (comment?.commentList?.first?.content) ?? "", fontSize: 14, width: screenWidth - 65.0)
        let TextH2 = textHeight(text: (comment?.commentList?.first?.tagsList) ?? "", fontSize: 13, width: screenWidth - 80.0)
        let TextH3 = textHeight(text: (comment?.commentList?.first?.replyContent) ?? "", fontSize: 12, width: screenWidth - 80.0)
        
        if (comment?.commentList ?? []).count > 0{
            return 15 + 21 + 10 + 26 + H + 10 + 15 + 40 + 10 + 10 + 32 + 30 + 5 + TextH1 + TextH2 + 40 + TextH3
        }else{
            return 15 + 21 + 10 + 26 + 30
        }
        
    }
    
    
}

struct PeriodList : HandyJSON {
   var name: String?
   var subjectList: [String]?
}

struct Comment : HandyJSON {
   var serviceScore: CGFloat = 0.0
   var tagsList: String?
   var commentList: [CommentList]?
   var isShow: Int = 0
    
    

}

struct CommentList : HandyJSON {

    var gradeName: String?
    var content: String?
    var headUrl: String?
    var id: String?
    var parentName: String?
    var serviceScore: Int = 0
    var replyContent: String?
    var subjectName: String?
    var createTime: String?
    var tagsList: String?
}


struct commentListModel :HandyJSON {
    
    var serviceScore: CGFloat = 0.0
    var tagsList: String?
    var percentage: String?
    var commentList: [CommentDetilsList]?
    var isShow: Int = 0
    
    var HeadH : CGFloat?{
        let arr =  tagsList!.components(separatedBy:",")
        let H = QYPAdaptiveButton.creat(frame: CGRect(x: 10, y: 10, width: kScreenWidth - 20 , height: 0), titleArr:arr).height
        
        return H + 20 + 100
    }
}

struct CommentDetilsList :HandyJSON {
    
    var gradeName: String?
    var content: String?
    var headUrl: String?
    var id: String?
    var parentName: String?
    var serviceScore: Int = 0
    var replyContent: String?
    var subjectName: String?
    var createTime: String?
    var tagsList: String?
    
    
    var cellH : CGFloat?{
        
        let TextH1 = textHeight(text: content ?? "", fontSize: 14, width: screenWidth - 65.0)
        let TextH2 = textHeight(text:  tagsList ?? "", fontSize: 13, width: screenWidth - 80.0)
        let TextH3 = textHeight(text:  replyContent ?? "", fontSize: 12, width: screenWidth - 80.0)
        
        if replyContent == nil {
            return 15 + 40  + 15 + 10 + TextH1 + TextH2
        }else{
            return 15 + 40 + 10 + 8 + 15 + 10 + 15 + 15 + TextH1 + TextH2 + TextH3
        }
    }

}





//struct Records : HandyJSON {
//       var subjects: String?
//       var school: String?
//       var isAuth: String?
//       var id: String?
//       var price: String?
//       var introduction: String?
//       var teachingArea: String?
//       var experience: String?
//       var headUrl: String?
//       var realName: String?
//       var sex: Int = 0
//
//}

struct teachListModel : HandyJSON {
       var orders: String?
       var pages: Int = 0
       var current: Int = 0
       var size: Int = 0
       var searchCount: Bool = false
       var total: Int = 0
       var records: [tutorListModel]?

}





//查询老师参数
struct SearchParmer : HandyJSON {
    
    var subject: String!                 // 科目
    var sex: String!               // 性别 0男 1女
    var grade: String!                   // 年级
    var experience: String!               // 授课经验
    var teachingArea: String!             // 区域
    var priceRange : String!              //价格范围
    var pageSize: Int!
    var page: Int!
}

