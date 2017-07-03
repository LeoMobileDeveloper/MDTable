//
//  MDTable.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import ObjectiveC

public extension UITableView{
    var manager:TableManager?{
        get{
            return objc_getAssociatedObject(self, "MDTableManager") as? TableManager
        }set{
            newValue?.bindTo(tableView: self)
            objc_setAssociatedObject(self, "MDTableManager", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
