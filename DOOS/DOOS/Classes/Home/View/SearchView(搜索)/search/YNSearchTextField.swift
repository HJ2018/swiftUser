//
//  YNSearchTextField.swift
//  YNSearch
//
//  Created by YiSeungyoun on 2017. 4. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

open class YNSearchTextField: UITextField {
    
    
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        let Rect = CGRect(x: bounds.origin.x+40, y:  bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height)
        return Rect
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {

        let Rect = CGRect(x: bounds.origin.x+45, y:  bounds.origin.y, width: bounds.size.width - 25, height: bounds.size.height)
        return Rect
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {

        let Rect = CGRect(x: bounds.origin.x+40, y:  bounds.origin.y, width: bounds.size.width - 25, height: bounds.size.height)
        return Rect
    }
       
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func initView() {
        self.leftViewMode = .always
        
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        self.layer.cornerRadius  = 18
        self.tintColor = UIColor.MainColor
        self.backgroundColor = UIColor.init(r: 245, g: 245, b: 245)
        self.leftView = searchImageViewWrapper
        self.returnKeyType = .search
        self.placeholder = "输入老师/年级/科目"
        self.font = UIFont.systemFont(ofSize: 14)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
         self.leftView?.x = 15
    }
}


open class YNSearchTextFieldView: UIView {
    open var ynSearchTextField: YNSearchTextField!
    open var cancelButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func initView() {
        self.ynSearchTextField = YNSearchTextField(frame: CGRect(x: 30, y: 0, width: kScreenWidth - 100, height: self.frame.height))
        self.addSubview(self.ynSearchTextField)
        
        self.cancelButton = UIButton(frame: CGRect(x: kScreenWidth - 70, y: 0, width: 40, height: self.frame.height))
        self.cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.cancelButton.setTitleColor(UIColor.darkGray, for: .normal)
    self.cancelButton.setTitleColor(UIColor.darkGray.withAlphaComponent(0.3), for: .highlighted)
        self.cancelButton.setTitle("取消", for: .normal)
        self.cancelButton.isHidden = true
        self.addSubview(self.cancelButton)
        
    }
    
    

}
