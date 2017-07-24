//
//  NMChannelCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/7.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable

//主播电台
class NMChannel {
    var describe:String
    var avatar:UIImage
    var podcasterName:String
    init(avatar:UIImage, describe:String,podcasterName:String){
        self.avatar = avatar
        self.podcasterName = podcasterName
        self.describe = describe
    }
}

class NMChannelRow:ReactiveRow {
    var channels:[NMChannel]
    var isDirty = true
    init(channels:[NMChannel]){
        self.channels = channels
        super.init()
        self.rowHeight = NMChannelConst.itemHeight * 2.0 
        self.reuseIdentifier = "NMChannelRow"
        self.shouldHighlight = false
        self.initalType = .code(className: NMChannelCell.self)
    }
}

struct NMChannelConst {
    static var itemWidth:CGFloat {
        get{
            return (UIScreen.main.bounds.width - 12.0) / 3.0
        }
    }
    static var itemHeight:CGFloat{
        get{
            return NMChannelConst.itemWidth + 40.0
        }
    }
}

class NMChannelCell: MDTableViewCell {
    weak var row:NMChannelRow?
    var itemViews:[ChannelItemView] = []
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for _ in 0..<6{
            let itemView = ChannelItemView(frame: CGRect.zero).added(to:contentView)
            itemViews.append(itemView)
        }
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMChannelRow else {
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
                y = NMChannelConst.itemHeight
            }
            let itemView = itemViews[i]
            itemView.frame = CGRect(x: x, y: y, width:NMChannelConst.itemWidth, height: NMChannelConst.itemHeight)
            x = x + itemView.frame.width + 4.0
        }
        
    }
    func reloadData(){
        guard let row = self.row else{
            return
        }
        for i in 0..<row.channels.count{
            TaskDispatcher.shared.add("NMChannelCell\(i)") {
                let chanel = row.channels[i]
                let itemView = self.itemViews[i]
                itemView.config(chanel)
            }
        }
    }
}

class ChannelSection: Section, SortableSection{
    var identifier: String = "ChannelSection"
    var sortTitle: String = "主播电台"
    var defaultSequeue: Int = 6
    var sequence: Int = 6
    static var mockSection:ChannelSection{
        get{
            let channelTitleRow = NMColumnTitleRow(title: "主播电台")
            let images = (1...6).map{"channel_\($0).jpeg"}.map{ UIImage(named:$0)! }
            let podcaster = ["盗墓笔记","陈一发儿","PAGE SEVEN 胡先笙","冯提莫","明星会客室","网易轻松一刻"]
            let describes = ["长热不衰的盗墓悬疑之作","知性女性陈一发的空灵音色","解读这个世界背后的逻辑","人气主播冯提莫的活力唱腔","本期嘉宾梅婷张智霖阿娇耿乐","网易新闻轻松一刻频道"]
            var channels = [NMChannel]()
            for i in 0...5{
                let channel = NMChannel(avatar: images[i], describe: describes[i], podcasterName: podcaster[i])
                channels.append(channel)
            }
            let channelRow = NMChannelRow(channels: channels)
            let channelSection = ChannelSection(rows: [channelTitleRow,channelRow])
            return channelSection
        }
    }
}


