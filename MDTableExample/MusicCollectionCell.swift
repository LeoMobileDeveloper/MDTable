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
class MusicCollectionCell: UICollectionViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    func config(_ music:NMLatestMusic, style:MusicCollectionCellStyle){
        switch style {
        case .normal:
            coverImageView.isHidden = true
        default:
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
