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

class NMExclusiveCell:MDTableViewCell,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    var collectionView:UICollectionView!
    weak var row:NMExclusiveRow?
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
        let nib = UINib(nibName: "ExclusiveCollectionCell", bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMExclusiveRow else {
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
        return self.row?.exclusives.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExclusiveCollectionCell
        if let exclusive = self.row?.exclusives[indexPath.item]{
            cell.config(exclusive)
            if indexPath.item < 2{
                cell.remakeAspectRadio(.fullScreen)
            }else{
                cell.remakeAspectRadio(.halfScreen)
            }
            cell.setNeedsUpdateConstraints()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item < 2{
            return CGSize(width: NMExclusiveConst.halfItemWidth, height: NMExclusiveConst.halfItemHeight)
        }else{
            return CGSize(width: NMExclusiveConst.fullItemWidth, height: NMExclusiveConst.fullItemHeight)
        }
    }
}

class ExclusiveSection: Section{
    static var mockSection: Section {
        get{
            let exclusiveTitleRow = NMColumnTitleRow(title: "独家放送")
            let images = (1...3).map{"exclusive_\($0).jpeg"}.map{ UIImage(named: $0)!}
            let describe = ["当电子音乐遇到逆天芭蕾舞，优雅又现代感十足！",
                            "达人翻弹胡夏新歌《夏至未至》，温柔哭了",
                            "一起去嘻哈世界里感受独一不二的swag"
                            ]
            let exclusives =  zip(images, describe).map { NMExclusive(avatar: $0.0, describe: $0.1)}
            let exclusiveRow = NMExclusiveRow(exclusives: exclusives)
            let exclusiveSection = Section(rows: [exclusiveTitleRow,exclusiveRow])
            return exclusiveSection
        }
    }
}
