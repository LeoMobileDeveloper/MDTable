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
class ColumnistItemView: UIView {
    var columnTitleLabel: UILabel!
    var avatarImageView: UIImageView!
    var readCountLabel: UILabel!
    var prefixLabel: UILabel!
    var separatorView:UIView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func commonInit(){
        columnTitleLabel = UILabel().added(to: self)
        columnTitleLabel.font = UIFont.systemFont(ofSize: 14)
        columnTitleLabel.numberOfLines = 2
        readCountLabel = UILabel.title().added(to: self)
        prefixLabel = UILabel().added(to: self)
        prefixLabel.textColor = UIColor.theme
        prefixLabel.font = UIFont.systemFont(ofSize: 10)
        prefixLabel.layer.borderColor = UIColor.theme.cgColor
        prefixLabel.textColor = UIColor.theme
        prefixLabel.layer.borderWidth = 0.5
        prefixLabel.text = "专栏"
        avatarImageView = UIImageView().added(to: self)
        separatorView.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(separatorView)
    }
    func config(_ item:ColumnistItem){
        columnTitleLabel.text = item.title
        avatarImageView.asyncSetImage(item.avatar)
        readCountLabel.text = item.readCount
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let avatarHeight = self.frame.height
        let avatarWidth = avatarHeight / 146.0 * 246.0
        avatarImageView.frame = CGRect(x: self.frame.width - avatarWidth, y: 0, width: avatarWidth, height: avatarHeight)
        columnTitleLabel.frame = CGRect(x:8.0 , y: 8.0, width: self.frame.width - 8.0 - 8.0 - avatarWidth, height: 34.0)
        readCountLabel.frame = CGRect(x: 8.0, y: columnTitleLabel.maxY + 4.0, width: columnTitleLabel.frame.width, height: 15.0)
        prefixLabel.sizeToFit()
        prefixLabel.frame = CGRect(x: columnTitleLabel.x, y: columnTitleLabel.y + 2.0, width: prefixLabel.frame.width, height: prefixLabel.frame.height)
        separatorView.frame = CGRect(x: 0, y: self.frame.height - 1.0, width: self.frame.width, height: 1.0)
    }
}

class ColumnistItem{
    var title:String
    var avatar:UIImage?
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
    }
}

class Columnist{
    var title:String
    var avatar:UIImage?
    var readCount:Int
    init(title:String, avatar:UIImage?, readCount:Int) {
        self.title = title
        self.avatar = avatar
        self.readCount = readCount
    }
}

