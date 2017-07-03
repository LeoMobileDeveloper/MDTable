//
//  DynamicHeightCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/6/16.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

struct DynamicHeightCellConst{
    static let font = UIFont.systemFont(ofSize: 16)
    static let cellWidth = UIScreen.main.bounds.size.width - 20.0
}
class DynamicHeightCell: MDTableViewCell {
    
    var customLabel: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customLabel = UILabel(frame: self.contentView.bounds)
        customLabel.font = DynamicHeightCellConst.font
        customLabel.textColor = UIColor.orange
        customLabel.numberOfLines = 0
        contentView.addSubview(customLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        customLabel.frame = CGRect(x: 20.0, y: 0, width: contentView.frame.size.width - 20.0, height: contentView.frame.size.height)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func render(with row: RowConvertable) {
        super.render(with: row)
        guard let row = row as? DynamicHeightRow else {
            return
        }
        customLabel.text = row.title
    }

}
