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


class NMMVCell: MDTableViewCell,UICollectionViewDelegate,UICollectionViewDataSource{
    var collectionView:UICollectionView!
    weak var row:NMMVRow?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: NMMVConst.itemWidth, height: NMMVConst.itemHeight)
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: contentView.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        contentView.addSubview(collectionView)
        let nib = UINib(nibName: "MVCollectionCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMMVRow else {
            return;
        }
        self.row = _row
        if _row.isDirty{
            self.collectionView.reloadData()
            _row.isDirty = false
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
        return self.row?.mvs.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MVCollectionCell
        if let recommend = self.row?.mvs[indexPath.item]{
            cell.config(recommend)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
}

class NMMVSection : Section{
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
