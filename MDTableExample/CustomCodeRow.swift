//
//  CustomCodeRow.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/16.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable

class CustomCodeRow: TableRow{
    //Protocol
    var rowHeight: CGFloat{
        get{
            let attributes = [NSFontAttributeName: CustomCellWithCodeConfig.font]
            let size = CGSize(width: CustomCellWithCodeConfig.cellWidth, height: .greatestFiniteMagnitude)
            let height = (self.title as NSString).boundingRect(with: size,
                                                               options: [.usesLineFragmentOrigin],
                                                               attributes: attributes,
                                                               context: nil).size.height
            return height + 8.0
        }
    }
    var reuseIdentifier: String = "CustomCodeRow"
    var initalType: TableRowInitalType = TableRowInitalType.code(className: CustomCellWithCode.self)
    
    //Optional evnet 
    var didSelectRowAt: (UITableView, IndexPath) -> Void

    //Data
    var title:String
    init(title:String) {
        self.title = title
        self.didSelectRowAt = {_,_ in}
    }
    
}
