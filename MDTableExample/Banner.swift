//
//  NMBannerCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/4.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import Foundation
import UIKit
import MDTable

class NMBannerRow : ReactiveRow, ParallexBannerDelegate, ParallexBannerDataSource{
    var items:[BannerItem]{
        didSet{
            bannerView?.reloadData()
        }
    }
    var isDirty = true
    func bindTo(_ banner:ParallexBanner){
        bannerView = banner
        bannerView?.delegate = self
        bannerView?.dataSource = self
        bannerView?.transitionMode = .Normal
        if isDirty{
            bannerView?.reloadData()
            isDirty = false
        }
    }
    weak var bannerView:ParallexBanner?
    init(items:[BannerItem]) {
        self.items = items
        super.init()
        self.rowHeight = UIScreen.main.bounds.width / 320.0 * 125.0
        self.initalType = .code(className: NMBannerCell.self)
        self.shouldHighlight = false
    }
    
    func banner(banner: ParallexBanner, didClickAtIndex index: NSInteger) {
        print("Click at index \(index)")
    }
    func banner(banner: ParallexBanner, didScrollToIndex index: NSInteger) {
        print("Scroll to \(index)")
    }
    func numberOfBannersIn(bannner: ParallexBanner) -> NSInteger {
        return self.items.count
    }
    func banner(banner: ParallexBanner, imageAt index: NSInteger) -> BannerItem {
        return self.items[index]
    }
}


class NMBannerCell: MDTableViewCell {
    var bannerView:ParallexBanner!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bannerView = ParallexBanner(frame: self.bounds)
        contentView.addSubview(bannerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? NMBannerRow else {
            return
        }
        _row.bindTo(bannerView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        bannerView.frame = self.bounds
    }
}

