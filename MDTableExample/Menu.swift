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
        self.initalType = .code(className: NMMenuCell.self)
        self.shouldHighlight = false
    }
}

class NMMenuCell: MDTableViewCell {
    var itemViews = [MenuItemView]()
    var separatorView = UIView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func commonInit(){
        var images = ["cm4_disc_topbtn_fm","cm4_disc_topbtn_daily","cm4_disc_topbtn_rank"]
        var titles = ["私人FM","每日歌曲推荐","云音乐热歌榜"]
        for i in 0...2{
            let itemView = MenuItemView(frame: CGRect.zero).added(to: contentView)
            itemView.foregroundImageView.image = UIImage(named: images[i])
            itemView.foregroundImageView.highlightedImage =  UIImage(named: "\(images[i])_prs")
            itemView.textLabel.text = titles[i]
            itemView.dateLabel.isHidden = (i != 1)
            itemView.dateLabel.text = Date.dayOfToday
            itemViews.append(itemView)
        }
        contentView.addSubview(separatorView)
        separatorView.backgroundColor = UIColor.groupTableViewBackground
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let itemWidth = contentView.frame.width / CGFloat(itemViews.count)
        for i in 0..<itemViews.count{
            let view = itemViews[i]
            view.frame = CGRect(x: itemWidth  * CGFloat(i), y: 0, width: itemWidth, height: self.frame.height)
        }
        separatorView.frame = CGRect(x: 0, y: self.frame.height - 1.0, width: self.frame.width, height: 1.0)
    }
}
class MenuSection:Section{
    static var mockSection:MenuSection{
        get{
            let items = (1...6).map{"cm2_daily_banner\($0).jpg"}.map { BannerItem(image: UIImage(named: $0), type: "推荐", color: UIColor.orange) }
            let bannerRow = NMBannerRow(items: items)
            let menuRow = NMMenuRow()
            let section = MenuSection(rows: [bannerRow,menuRow])
            return section
        }
    }
}
