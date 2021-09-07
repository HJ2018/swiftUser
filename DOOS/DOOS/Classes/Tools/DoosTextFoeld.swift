//
//  DoosTextFoeld.swift
//  DOOS
//
//  Created by jie.huang on 29/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit

class DoosTextFoeld: UITextField {

    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        
        let Rect = CGRect(x: bounds.origin.x+5, y:  bounds.origin.y, width: bounds.size.width - 10, height: bounds.size.height)
        return Rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        let Rect = CGRect(x: bounds.origin.x+10, y:  bounds.origin.y, width: bounds.size.width - 25, height: bounds.size.height)
        return Rect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        let Rect = CGRect(x: bounds.origin.x+10, y:  bounds.origin.y, width: bounds.size.width - 25, height: bounds.size.height)
        return Rect
    }
    
}
