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
        self.rowHeight = NMMusicConst.itemHeight * 2.0
        self.reuseIdentifier = "NMMusicRow"
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
            return NMMusicConst.itemWidth + 40.0
        }
    }
}

class NMMusicCell: MDTableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    var collectionView:UICollectionView!
    weak var row:NMLatestMusicRow?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.itemSize = CGSize(width: NMMusicConst.itemWidth, height: NMMusicConst.itemHeight)
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        contentView.addSubview(collectionView)
        let nib = UINib(nibName: "MusicCollectionCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMLatestMusicRow else {
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
        return self.row?.musics.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCollectionCell
        let style:MusicCollectionCellStyle = indexPath.item == 0 ? .slogen : .normal;
        if let music = self.row?.musics[indexPath.item]{
            cell.config(music, style: style)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

    }
}

class LatestMusicSection: Section{
    static var mockSection:LatestMusicSection{
        get{
            let musicTitleRow = NMColumnTitleRow(title: "最新音乐")
            let images = (1...6).map{"music_\($0).jpeg"}.map{ UIImage(named:$0)! }
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



