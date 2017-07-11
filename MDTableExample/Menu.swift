//
//  NMMenuCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/4.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable

class NMMenuRow: ReactiveRow {
    override init() {
        super.init()
        self.rowHeight = 100.0
        self.initalType = .xib(xibName: "NMMenuCell")
        self.shouldHighlight = false
    }
}

class NMMenuCell: MDTableViewCell {
    
}
class MenuSection:Section{
    static var mockSection:MenuSection{
        get{
            let items = (1...6).map{"cm2_daily_banner\($0).jpg"}.map { BannerItem(image: UIImage(named: $0)!, type: "推荐", color: UIColor.orange) }
            let bannerRow = NMBannerRow(items: items)
            let menuRow = NMMenuRow()
            let section = MenuSection(rows: [bannerRow,menuRow])
            return section
        }
    }
}
