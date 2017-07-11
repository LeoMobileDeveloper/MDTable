//
//  ColumnistItemCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/10.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit
import MDTable

enum ColumnistItemCellStyle{
    case full
    case topPadding
}
class ColumnistItemCell: MDTableViewCell {
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    @IBOutlet weak var columnTitleLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var prefixLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        prefixLabel.layer.borderColor = UIColor.theme.cgColor
        prefixLabel.textColor = UIColor.theme
        prefixLabel.layer.borderWidth = 0.5
    }
    override func render(with row: RowConvertable) {
        guard let _row = row as? ColumnistItemRow else{
            return;
        }
        columnTitleLabel.text = _row.title
        avatarImageView.asyncSetImage(_row.avatar)
        readCountLabel.text = _row.readCount
        relayout(with: _row.style)
    }
    func relayout(with style:ColumnistItemCellStyle){
        switch style {
        case .full:
            self.bottomConstraint.constant = 0
            self.topConstraints.constant = 0
        case .topPadding:
            self.topConstraints.constant = 5.0
            self.bottomConstraint.constant = -5.0
        }
    }
}

class ColumnistItemRow:ReactiveRow{
    var title:String
    var avatar:UIImage
    var readCount:String
    var style:ColumnistItemCellStyle
    var attributeTitle:NSAttributedString {
        get{
            let graphStyle = NSMutableParagraphStyle()
            graphStyle.alignment = .natural
            let attr1 = NSAttributedString(string: self.title, attributes: [NSParagraphStyleAttributeName: graphStyle])
            return attr1
        }
    }
    init(item:Columnist,style:ColumnistItemCellStyle) {
        self.title = "       " + item.title
        self.avatar = item.avatar
        self.readCount = "阅读 " + item.readCount.asLocalizedPlayCount()
        self.style = style
        super.init()
        self.rowHeight = UIScreen.main.bounds.width / 320.0 * 75.0
        self.reuseIdentifier = "ColumnistItemRow"
        self.initalType = .xib(xibName: "ColumnistItemCell")
    }
}

class Columnist{
    var title:String
    var avatar:UIImage
    var readCount:Int
    init(title:String, avatar:UIImage, readCount:Int) {
        self.title = title
        self.avatar = avatar
        self.readCount = readCount
    }
}

