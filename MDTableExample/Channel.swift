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

class NMChannelCell: MDTableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    var collectionView:UICollectionView!
    weak var row:NMChannelRow?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: NMChannelConst.itemWidth, height: NMChannelConst.itemHeight)
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        contentView.addSubview(collectionView)
        let nib = UINib(nibName: "ChannelCollectionCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMChannelRow else {
            return;
        }
        self.row = _row
        if _row.isDirty{
            _row.isDirty = false
            //self.collectionView.reloadData()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    // MARK: - CollectionView DataSource and Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.row?.channels.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ChannelCollectionCell
        if let channel = self.row?.channels[indexPath.item]{
            cell.config(channel)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

class ChannelSection: Section{
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


