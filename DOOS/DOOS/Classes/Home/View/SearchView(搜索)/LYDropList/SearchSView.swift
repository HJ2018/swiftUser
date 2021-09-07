//
//  SearchSView.swift
//  DOOS
//
//  Created by jie.huang on 13/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit
import Closures

let Searchgap = 20
/// 定义一个代理方法，在实现类里面可以获取到点击的是哪个button，这里是传的index索引，根据需要可以将参数变为button
protocol SearchButtonDelegate:class {
    func searchHistory(index:Int , selBtn : UIButton);
}

class SearchSView: UIView {
    weak var delegate:SearchButtonDelegate?
    /// 中间button,记录选中状态
    var tempButton:UIButton?
    /// 按钮的button中文字数组
    var titleArray = [String]()
    /// 正常时候显示的字体大小
    var normal = CGFloat()
    /// 放大时候显示的字体大小
    var bigger = CGFloat()
    /// 设置每一个按钮的高度
    var heightBtn = CGFloat()
    
    var AllBtn :[UIButton] = []
    

    class func creat(frame:CGRect,titleArr:[String],normal:CGFloat = 14,bigger:CGFloat = 15,heightBtn:CGFloat = 38) -> SearchSView{
        let v = SearchSView(frame: frame)
        v.titleArray = titleArr
        v.normal = normal
        v.bigger = bigger
        v.heightBtn = heightBtn
        v.setupUI()
        return v
    }
    
   
}

extension SearchSView {
    
    fileprivate func setupUI(){
        // 定义常量 btn的height + 顶部空隙(没增加一行的高度)
        let rowHeight:CGFloat = heightBtn + 20
        // 定义一个变量,用于记录每一个btn的x值
        let btnX:CGFloat = CGFloat(gap)
        let btnY:CGFloat = 0
        var x:CGFloat = btnX
        var y:CGFloat = btnY
        // 定义一个属性,记录已经是第几行,然后对应的背景view也要需要增加多高
        var index = 0

        // 创建证件类型选择按钮
        for i in 0..<titleArray.count {
            let size = titleArray[i].getLabWidth(font: UIFont.systemFont(ofSize: bigger), height: heightBtn)
            if x + (size.width < 75 ? 75 : size.width + 10) > SCREEN_WIDTH {
                index += 1
                x = CGFloat(gap)
                y += rowHeight
            }

            let rect = CGRect(x: x, y: y, width: size.width < 75 ? 75 : size.width + 10, height: heightBtn)
            x += rect.width + CGFloat(gap)
            let btn = UIButton()
            //2:设置按钮的bg图片与普通图片

            btn.frame = rect
            btn.setTitle(titleArray[i], for: .normal)
            btn.setTitleColor(UIColor.gray , for: .normal)
            btn.setTitle(titleArray[i], for: .selected)
            btn.setTitleColor(#colorLiteral(red: 0, green: 0.7529411765, blue: 0.4196078431, alpha: 1), for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: normal)
            btn.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:0.5)
            btn.layer.cornerRadius = 8
            btn.tag = 98889 + i
            btn.addTarget(target, action: #selector(SchooseOCR), for: .touchUpInside)
//            

            btn.titleLabel?.font = UIFont.systemFont(ofSize: normal)
            AllBtn.append(btn)
            self.addSubview(btn)
        }
        // 重新设置self.height的高度
        self.height += CGFloat(index) * rowHeight + rowHeight
    }
    /// 点击某一个button的时候，通过tag值获取到了对应的button，然后做出对应的响应
    @objc func SchooseOCR(btn:UIButton){
        tempButton?.titleLabel?.font = UIFont.systemFont(ofSize: normal)
        tempButton?.isSelected = false
        tempButton = btn
        btn.titleLabel?.font = UIFont.systemFont(ofSize: bigger)
        btn.isSelected = true
        if delegate != nil {
            delegate?.searchHistory(index:btn.tag - 98889 ,selBtn: btn)
        }
    }
}
