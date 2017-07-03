//
//  XibRow.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/15.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable

class XibRow: RowConvertable{
    //Protocol
    var rowHeight: CGFloat = 80.0
    var reuseIdentifier: String = "XibRow"
    var initalType: RowConvertableInitalType = RowConvertableInitalType.xib(xibName: "CusomCellWithXib")
    
    var didSelectRowAt: (UITableView, IndexPath) -> Void
    
    //Data
    var title:String
    var subTitle:String
    var image:UIImage
    init(title:String, subTitle:String, image:UIImage) {
        self.title = title
        self.subTitle = subTitle
        self.image = image
        self.didSelectRowAt = {_,_ in}
    }

}
