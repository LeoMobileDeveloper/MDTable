//
//  XibRow.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable

class XibRow:ReactiveRow{
    
    //Data
    var title:String
    var subTitle:String
    var image:UIImage
    init(title:String, subTitle:String, image:UIImage) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
        super.init()
        self.rowHeight = 80.0
        self.initalType = RowConvertableInitalType.xib(xibName: "CusomCellWithXib")
    }

}
