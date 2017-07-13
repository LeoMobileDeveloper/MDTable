//
//  NMMVCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable
import UIKit
//推荐MV

class NMMVRow: ReactiveRow{
    var mvs:[NMMV]
    var isDirty = true
    init(mvs:[NMMV]) {
        self.mvs = mvs
        super.init()
        self.rowHeight = NMMVConst.itemHeight * 2.0 + 6.0
        self.reuseIdentifier = "NMMVRow"
        self.initalType = .code(className: NMMVCell.self)
    }
}

struct NMMVConst {
    static var itemWidth: CGFloat{
        get{
            return UIScreen.main.bounds.width / 2.0 - 2.0
        }
    }
    static var itemHeight: CGFloat{
        get{
            return NMMVConst.itemWidth / 62.0 * 35.0 + 45.0
        }
    }
}


class NMMVCell: MDTableViewCell{
    var itemViews:[MVItemView] = []
    weak var row:NMMVRow?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for _ in 0..<4{
            let itemView = MVItemView(frame: CGRect.zero).added(to:contentView)
            itemViews.append(itemView)
        }
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMMVRow else {
            return;
        }
        self.row = _row
        if _row.isDirty{
            _row.isDirty = false
            reloadData()
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var x:CGFloat = 0.0
        var y:CGFloat = 0.0
        for i in 0..<itemViews.count{
            if i == 2{
                x = 0.0
                y = NMMVConst.itemHeight
            }
            let itemView = itemViews[i]
            itemView.frame = CGRect(x: x, y: y, width:NMMVConst.itemWidth, height: NMMVConst.itemHeight)
            x = x + itemView.frame.width + 4.0
        }
        
    }
    func reloadData(){
        guard let row = self.row else{
            return
        }
        for i in 0..<row.mvs.count{
            let mv = row.mvs[i]
            let itemView = itemViews[i]
            itemView.config(mv)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NMMVSection : Section,SortableSection{
    var sortTitle: String = "推荐MV"
    var defaultSequeue: Int = 4
    var sequence: Int = 4
    static var mockSection: NMMVSection{
        get{
            let exclusiveTitleRow = NMColumnTitleRow(title: "推荐MV")
            let images = (1...4).map{"mv_\($0).jpeg"}.map{ UIImage(named: $0)!}
            let counts = [9936,48380,770000,1720000]
            let singers = ["徐歌阳","Liam Gallagher","薛之谦","DJ Khaled/Rihanna"]
            let names = ["Forever","Chinatown","高尚","Wild Thoughts"]
            var mvs = [NMMV]()
            for i in 0...3{
                let mv = NMMV(avatar: images[i], name: names[i], singer: singers[i], playCount: counts[i])
                mvs.append(mv)
            }
            let mvRow = NMMVRow(mvs: mvs)
            let exclusiveSection = NMMVSection(rows: [exclusiveTitleRow,mvRow])
            return exclusiveSection
        }
    }
}
