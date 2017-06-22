//
//  MDCellRenderable.swift
//  MDTableView
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit


open class SystemTableViewCell:UITableViewCell{
    public typealias MDRowDataType = SystemRow
    open func render(with row: TableRow) {
        if let row = row as? SystemRow{
            self.textLabel?.text = row.title
            self.imageView?.image = row.image
            self.detailTextLabel?.text = row.detailTitle
            self.accessoryType = row.accessoryType
        }
    }
}
