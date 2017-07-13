//
//  MusicCollectionCell.swift
//  MDTableExample
//
//  Created by Leo on 2017/7/11.
//  Copyright © 2017年 Leo Huang. All rights reserved.
//

import UIKit

enum MusicCollectionCellStyle {
    case normal
    case slogen
}
class MusicItemView: UIView {
    var avatarImageView: UIImageView!
    var titleLabel: UILabel!
    var subTitleLabel: UILabel!
    var coverImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit(){
        avatarImageView = UIImageView(frame: CGRect.zero).added(to: self)
        coverImageView  = UIImageView(frame: CGRect.zero).added(to: self)
        titleLabel = UILabel.title().added(to: self)
        subTitleLabel = UILabel.subTitle().added(to: self)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width)
        coverImageView.frame = avatarImageView.frame
        titleLabel.frame = CGRect(x: 4.0, y: avatarImageView.maxY + 4.0, width: self.frame.width - 8.0, height: 15.0)
        subTitleLabel.frame = CGRect(x: 4.0, y: titleLabel.maxY + 2.0, width: self.frame.width - 8.0, height: 15.0)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(_ music:NMLatestMusic, style:MusicCollectionCellStyle){
        switch style {
        case .normal:
            coverImageView.isHidden = true
        default:
            coverImageView.image = UIImage(named: "cm4_disc_cover_new")
            coverImageView.isHidden = false
        }
        avatarImageView.asyncSetImage(music.avatar)
        titleLabel.text = music.title
        subTitleLabel.text = music.subTitle
    }
}

//新歌推荐
class NMLatestMusic {
    var avatar:UIImage
    var title:String
    var subTitle:String
    init(avatar:UIImage, title:String,subTitle:String){
        self.avatar = avatar
        self.title = title
        self.subTitle = subTitle
    }
}
