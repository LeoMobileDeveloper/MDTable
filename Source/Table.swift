//
//  MDTable.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import ObjectiveC

struct MDTableConst{
    static let associatedKey = UnsafeRawPointer.init(bitPattern: "MDTableAccessoryKey".hashValue)
}
public extension UITableView{
    var manager:TableManager?{
        get{
            return objc_getAssociatedObject(self,MDTableConst.associatedKey) as? TableManager
        }set{
            executeOnMain {
                newValue?.bindTo(tableView: self)
                objc_setAssociatedObject(self, MDTableConst.associatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}
