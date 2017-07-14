//
//  NMRecommendCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable


class NMRecommendRow:ReactiveRow {
    var recommends:[NMRecommend]
    var isDirty = true
    init(recommends:[NMRecommend]){
        self.recommends = recommends
        super.init()
        self.rowHeight = NMRecommendConst.itemHeight * 2.0 + 10.0
        self.reuseIdentifier = "NMRecommendRow"
        self.shouldHighlight = false
        self.initalType = .code(className: NMRecommendCell.self)
    }
}

struct NMRecommendConst {
    static var itemWidth:CGFloat {
        get{
            return (UIScreen.main.bounds.width - 12.0) / 3.0
        }
    }
    static var itemHeight:CGFloat{
        get{
            return NMRecommendConst.itemWidth + 30.0
        }
    }
}

class NMRecommendCell: MDTableViewCell {
    weak var row:NMRecommendRow?
    var itemViews:[RecommendItemView] = []
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for _ in 0..<6{
            let itemView = RecommendItemView(frame: CGRect.zero).added(to:contentView)
            itemViews.append(itemView)
        }
    }
    
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMRecommendRow else {
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
            if i == 3{
                x = 0.0
                y = NMRecommendConst.itemHeight
            }
            let itemView = itemViews[i]
            itemView.frame = CGRect(x: x, y: y, width:NMRecommendConst.itemWidth, height: NMRecommendConst.itemHeight)
            x = x + itemView.frame.width + 4.0
        }
        
    }
    func reloadData(){
        guard let row = self.row else{
            return
        }
        for i in 0..<row.recommends.count{
            let recommend = row.recommends[i]
            let itemView = itemViews[i]
            itemView.config(recommend)
        }
    }

}

class RecommendSection:Section,SortableSection{
    var identifier: String = "RecommendSection"
    var sortTitle: String = "推荐歌单"
    var defaultSequeue: Int = 1
    var sequence: Int = 1
    static var mockSection:RecommendSection{
        get{
            let recommendTitleRow = NMColumnTitleRow(title: "推荐歌单")
            let recommends = (1...6).map{"music_sheet_\($0).jpeg"}.map { NMRecommend(avatar: UIImage(named: $0)!, playCount: 200000, describe: "hiphop*嘻哈玩家必备 首首精选") }
            let recommendRow = NMRecommendRow(recommends: recommends)
            let recommendSection = RecommendSection(rows: [recommendTitleRow,recommendRow])
            return recommendSection
        }
    }
}
