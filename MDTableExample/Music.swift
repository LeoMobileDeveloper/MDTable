//
//  Music.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/11.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import MDTable


class NMLatestMusicRow:ReactiveRow {
    var musics:[NMLatestMusic]
    var isDirty = true
    init(musics:[NMLatestMusic]){
        self.musics = musics
        super.init()
        self.rowHeight = NMMusicConst.itemHeight * 2.0 + 15.0
        self.shouldHighlight = false
        self.initalType = .code(className: NMMusicCell.self)
    }
}

struct NMMusicConst {
    static var itemWidth:CGFloat {
        get{
            return (UIScreen.main.bounds.width - 12.0) / 3.0
        }
    }
    static var itemHeight:CGFloat{
        get{
            return NMMusicConst.itemWidth + 45.0
        }
    }
}

class NMMusicCell: MDTableViewCell {
    var itemViews:[MusicItemView] = []
    weak var row:NMLatestMusicRow?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        for _ in 0..<6{
            let itemView = MusicItemView(frame: CGRect.zero).added(to:contentView)
            itemViews.append(itemView)
        }
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMLatestMusicRow else {
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
                y = NMMusicConst.itemHeight
            }
            let itemView = itemViews[i]
            itemView.frame = CGRect(x: x, y: y, width:NMMusicConst.itemWidth, height: NMMusicConst.itemHeight)
            x = x + itemView.frame.width + 4.0
        }
    }
    func reloadData(){
        guard let row = self.row else{
            return
        }
        for i in 0..<row.musics.count{
            TaskDispatcher.common.add("Music\(i)") {
                let style:MusicCollectionCellStyle = i == 0 ? .slogen : .normal;
                let music = row.musics[i]
                let itemView = self.itemViews[i]
                itemView.config(music, style: style)
            }
        }
    }
}

class LatestMusicSection: Section,SortableSection{
    
    var identifier: String = "LatestMusicSection"
    var sortTitle: String = "最新音乐"
    var defaultSequeue: Int = 3
    var sequence: Int = 3
    static var mockSection:LatestMusicSection{
        get{
            let musicTitleRow = NMColumnTitleRow(title: "最新音乐")
            let images = (1...6).map{"music_\($0).jpeg"}.map{ UIImage(named:$0)}
            let titles = ["新歌推荐","爱如空气","原上草","猎户星座","2017跨界歌王", "Despicable Me"]
            let subTitles = ["推荐合口味的新歌","韦礼安","刘惜君","朴树","群星","Various Artists"]
            var musics = [NMLatestMusic]()
            for i in 0...5{
                let music = NMLatestMusic(avatar: images[i], title: titles[i], subTitle: subTitles[i])
                musics.append(music)
            }
            let musicRow = NMLatestMusicRow(musics: musics)
            let musicSection = LatestMusicSection(rows: [musicTitleRow,musicRow])
            return musicSection
        }
    }
}

extension LatestMusicSection: PreloadableSection{
    var preloadRows:[RowConvertable]{
        return [NMLatestMusicRow(musics: [])]
    }
}

