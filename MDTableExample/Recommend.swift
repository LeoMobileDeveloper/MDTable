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

class NMRecommendCell: MDTableViewCell,UICollectionViewDataSource,UICollectionViewDelegate {
    var collectionView:UICollectionView!
    weak var row:NMRecommendRow?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: NMRecommendConst.itemWidth, height: NMRecommendConst.itemHeight)
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        contentView.addSubview(collectionView)
        let nib = UINib(nibName: "MusicSheetCollectionCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMRecommendRow else {
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
        return self.row?.recommends.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicSheetCollectionCell
        if let recommend = self.row?.recommends[indexPath.item]{
            cell.config(recommend)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

class RecommendSection:Section{
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
