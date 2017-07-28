//
//  NMHomeColumnCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/6.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

class NMColumnTitleRow: ReactiveRow{
    let columnTitle:String
    init(title:String) {
        columnTitle = title
        super.init()
        self.rowHeight = 45.0
        self.initalType = .xib(xibName: "NMColumnTitleCell")
    }
}

class NMColumnTitleCell: MDTableViewCell{
    
    @IBOutlet weak var columnTitleLabel: UILabel!
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMColumnTitleRow else {
            return
        }
        self.columnTitleLabel.text = _row.columnTitle
    }
}
