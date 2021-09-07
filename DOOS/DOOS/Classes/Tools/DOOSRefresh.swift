//
//  DOOSRefresh.swift
//  DOOS
//
//  Created by jie.huang on 11/1/2020.
//  Copyright © 2020 DOOS. All rights reserved.
//

import UIKit
import MJRefresh

class DOOSRefresh: NSObject {

}
/*
 tw.uHead = URefreshHeader { [weak self] in self?.loadData(more: false) }
 tw.uFoot = URefreshFooter { [weak self] in self?.loadData(more: true) }
 */

extension UIScrollView {
    var DHead: MJRefreshHeader {
        get { return mj_header!}
        set { mj_header = newValue }
    }
    
    var DFoot: MJRefreshFooter {
        get { return mj_footer! }
        set { mj_footer = newValue }
    }
}

class URefreshHeader: MJRefreshNormalHeader {}

class URefreshAutoHeader: MJRefreshHeader {}

class URefreshFooter: MJRefreshBackNormalFooter {}

class URefreshAutoFooter: MJRefreshAutoFooter {}
