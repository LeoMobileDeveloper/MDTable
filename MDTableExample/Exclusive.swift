//
//  NMExclusiveCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable
//独家放送

class NMExclusive{
    var describe:String
    var avatar:UIImage
    init(avatar:UIImage, describe:String){
        self.avatar = avatar
        self.describe = describe
    }
}

struct NMExclusiveConst {
    static var halfItemWidth:CGFloat{
        get{
            return UIScreen.main.bounds.width / 2.0 - 2.0
        }
    }
    static var halfItemHeight:CGFloat{
        get{
            return NMExclusiveConst.halfItemWidth / 158.0 * 87.0 + 40.0
        }
    }
    static var fullItemWidth:CGFloat{
        get{
            return UIScreen.main.bounds.width
        }
    }
    static var fullItemHeight:CGFloat{
        get{
            return NMExclusiveConst.fullItemWidth / 320.0 * 117.0 + 40.0
        }
    }
}

class NMExclusiveRow:ReactiveRow {
    var isDirty = true
    var exclusives:[NMExclusive]
    init(exclusives:[NMExclusive]){
        self.exclusives = exclusives
        super.init()
        self.rowHeight = NMExclusiveConst.halfItemHeight + NMExclusiveConst.fullItemHeight
        self.reuseIdentifier = "NMExclusiveRow"
        self.shouldHighlight = false
        self.initalType = .code(className: NMExclusiveCell.self)
    }
}

class NMExclusiveCell:MDTableViewCell{
    weak var row:NMExclusiveRow?
    var itemViews:[ExclusiveItemView] = []
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for _ in 0..<3{
            let itemView = ExclusiveItemView(frame: CGRect.zero).added(to:contentView)
            itemViews.append(itemView)
        }
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMExclusiveRow else {
            return;
        }
        self.row = _row
        if _row.isDirty{
            _row.isDirty = false
            reloadData()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var x:CGFloat = 0.0
        var y:CGFloat = 0.0
        for i in 0..<itemViews.count{
            if i == 2{//
                x = 0.0
                y = NMExclusiveConst.halfItemHeight
                let itemView = itemViews[i]
                itemView.frame = CGRect(x: x, y: y, width:NMExclusiveConst.fullItemWidth, height: NMExclusiveConst.fullItemHeight)
                return;
            }
            let itemView = itemViews[i]
            itemView.frame = CGRect(x: x, y: y, width:NMExclusiveConst.halfItemWidth, height: NMExclusiveConst.halfItemHeight)
            x = x + itemView.frame.width + 4.0
            itemView.layoutSubviews()
        }
        
    }
    func reloadData(){
        guard let row = self.row else{
            return
        }
        for i in 0..<row.exclusives.count{
            let exclusive = row.exclusives[i]
            let itemView = itemViews[i]
            let style = i == 2 ? ExclusiveStyle.fullScreen : ExclusiveStyle.halfScreen
            itemView.config(exclusive, style: style)
        }
    }
   
}

class ExclusiveSection: Section,SortableSection{
    var identifier: String = "ExclusiveSection"
    var sortTitle: String = "独家放送"
    var defaultSequeue: Int = 2
    var sequence: Int = 2
    static var mockSection: ExclusiveSection {
        get{
            let exclusiveTitleRow = NMColumnTitleRow(title: "独家放送")
            let images = (1...3).map{"exclusive_\($0).jpeg"}.map{ UIImage(named: $0)!}
            let describe = ["当电子音乐遇到逆天芭蕾舞，优雅又现代感十足！",
                            "达人翻弹胡夏新歌《夏至未至》，温柔哭了",
                            "一起去嘻哈世界里感受独一不二的swag"
                            ]
            let exclusives =  zip(images, describe).map { NMExclusive(avatar: $0.0, describe: $0.1)}
            let exclusiveRow = NMExclusiveRow(exclusives: exclusives)
            let exclusiveSection = ExclusiveSection(rows: [exclusiveTitleRow,exclusiveRow])
            return exclusiveSection
        }
    }
}
