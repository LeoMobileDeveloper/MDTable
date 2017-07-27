//
//  NMColumnistCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable
//专栏
class NeteaseColumnlistRow: ReactiveRow{
    var columnists:[Columnist]
    var isDirty = true
    init(columnists:[Columnist]){
        self.columnists = columnists
        super.init()
        self.rowHeight = UIScreen.main.bounds.width / 320.0  * 75.0 * 3
        self.reuseIdentifier = "NeteaseColumnlistRow"
        self.initalType = .code(className: NeteaseColumnlistCell.self)
    }
}

class NeteaseColumnlistCell: MDTableViewCell{
    weak var row:NeteaseColumnlistRow?
    let section:Section = Section(rows: [])
    var itemViews:[ColumnistItemView] = []
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for _ in 0..<3{
            let itemView = ColumnistItemView(frame: CGRect.zero).added(to:contentView)
            itemViews.append(itemView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let x:CGFloat = 0.0
        var y:CGFloat = 0.0
        let rowHeight = UIScreen.main.bounds.width / 320.0 * 75.0
        let width = contentView.frame.width
        for i in 0..<itemViews.count{
            let itemView = itemViews[i]
            itemView.frame = CGRect(x: x, y: y, width: width, height: rowHeight)
            y += rowHeight
        }
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NeteaseColumnlistRow else{
            return
        }
        self.row = _row
        if _row.isDirty{
            reloadData()
            _row.isDirty = true
        }
    }
    func reloadData(){
        guard let row = self.row else {
            return
        }
        for i in 0..<row.columnists.count{
            TaskDispatcher.common.add("columnists\(i)", {
                let itemView = self.itemViews[i]
                let columnist = row.columnists[i]
                let style:ColumnistItemCellStyle = i == 0 ? .full : .topPadding
                let item = ColumnistItem(item: columnist, style: style)
                itemView.config(item)
            })
        }
    }
}

class NeteaseColumnlistSection: Section,SortableSection {
    var identifier: String = "NeteaseColumnlistSection"
    var sortTitle: String = "精选专栏"
    var defaultSequeue: Int = 5
    var sequence: Int = 5
    static var mockSection:NeteaseColumnlistSection{
        get{
            let exclusiveTitleRow = NMColumnTitleRow(title: "精选专栏")
            let images = (1...3).map{"columnistl_\($0)"}.map{ UIImage(named: $0)!}
            let counts = [23641,23080,13073]
            let titles = ["重温《春光乍泄》：一层胸壁的距离，这么远那么近","来学习！一个嘿趴零基础路人怎么看中国有嘻哈"," 如今年轻人错过了流行音乐最辉煌的时代"]
            var rows = [Columnist]()
            for i in 0...2{
                rows.append(Columnist(title: titles[i], avatar: images[i], readCount: counts[i]))
            }
            let columnlistRow = NeteaseColumnlistRow(columnists: rows)
            let columnlistSection = NeteaseColumnlistSection(rows: [exclusiveTitleRow,columnlistRow])
            return columnlistSection
        }
    }
}

extension NeteaseColumnlistSection: PreloadableSection{
    var preloadRows:[RowConvertable]{
        return [NeteaseColumnlistRow(columnists: [])]
    }
}
