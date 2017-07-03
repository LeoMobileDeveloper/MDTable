//
//  BaseRow.swift
//  MDTable
//
//  Created by Leo on 2017/7/3.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit

open class Row:ReactiveRow{
    public var image:UIImage?
    public var title:String
    public var detailTitle:String?
    public var accessoryType: UITableViewCellAccessoryType
    public var cellStyle: UITableViewCellStyle = .default
    public init(title:String,
                image:UIImage? = nil,
                detailTitle:String? = nil,
                rowHeight:CGFloat = 44.0,
                accessoryType: UITableViewCellAccessoryType = .none) {
        self.image = image
        self.title = title
        self.detailTitle = detailTitle
        self.accessoryType = accessoryType
        super.init()
        self.rowHeight = rowHeight
        self.accessoryType = accessoryType
    }
}

