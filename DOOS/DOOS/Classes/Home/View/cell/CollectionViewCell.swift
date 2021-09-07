//
//  CollectionViewCell.swift
//  DOOS
//
//  Created by jie.huang on 15/12/2019.
//  Copyright © 2019 DOOS. All rights reserved.
//

import UIKit
import Reusable

class CollectionViewCell: UICollectionViewCell ,NibReusable{

    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var BtnImage: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
