//
//  SearchBarText.swift
//  DOOS
//
//  Created by jie.huang on 15/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit

class SearchBarText: UITextField {


    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {

         let Rect = CGRect(x: bounds.origin.x+40, y:  bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height)
         return Rect
     }

     override func textRect(forBounds bounds: CGRect) -> CGRect {

         let Rect = CGRect(x: bounds.origin.x+45, y:  bounds.origin.y, width: bounds.size.width - 25, height: bounds.size.height)
         return Rect
     }

     override func editingRect(forBounds bounds: CGRect) -> CGRect {

         let Rect = CGRect(x: bounds.origin.x+40, y:  bounds.origin.y, width: bounds.size.width - 25, height: bounds.size.height)
         return Rect
     }

   override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
   func setUI(){
        
        self.font = UIFont.systemFont(ofSize: 15)
        self.layer.masksToBounds = true
        self.height = 32
        self.layer.cornerRadius  = 16
        self.tintColor = UIColor.MainColor
        self.backgroundColor = UIColor.init(r: 245, g: 245, b: 245)
        self.returnKeyType = .search
        self.layer.borderColor = UIColor.init(r: 250, g: 250, b: 250).cgColor
        self.layer.borderWidth = 0.2
        
        let  searchIcon = UIImageView(image: UIImage(named: "sous"))
        searchIcon.width = 30
        searchIcon.height = 30
        searchIcon.contentMode = .center
    
        self.leftView = searchIcon;
        self.leftViewMode = .always
        self.placeholder = "输入老师/年级/科目"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
         self.leftView?.x = 15
    }
}
